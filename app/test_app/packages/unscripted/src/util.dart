
library unscripted.src.util;

import 'dart:async';
import 'dart:mirrors';
import 'dart:io';

import 'package:args/args.dart' show ArgParser, ArgResults;
import 'package:unscripted/unscripted.dart';
import 'package:unscripted/src/string_codecs.dart';
import 'package:unscripted/src/usage.dart';
import 'package:unscripted/src/invocation_maker.dart';
import 'package:mockable_filesystem/filesystem.dart' as filesystem;

const HELP = 'help';

/// A base class for script annotations which include help.
class Help {
  /// The help text to include for this part of the command line interface.
  final String help;

  const Help({this.help});
}

class BaseCommand extends Help {
  const BaseCommand({String help}) : super(help: help);
}

Rest getRestFromMethod(MethodMirror method) {
  var lastParameter = method.parameters.lastWhere(
      (parameter) => !parameter.isOptional,
      orElse: () => null);
  if(lastParameter != null) {
    Rest rest = getFirstMetadataMatch(lastParameter,
        (metadata) => metadata is Rest);

    var restName = getDefaultPositionalName(lastParameter.simpleName);
    var type = lastParameter.type;
    var parserFromTypeArgument;
    if(type.originalDeclaration == reflectClass(List) &&
       type.typeArguments.isNotEmpty) {
      parserFromTypeArgument = getParserFromType(type.typeArguments.single);
    }

    if(rest != null) {
      var parser = rest.parser;
      if(parser == null) {
        parser = parserFromTypeArgument;
      }
      if(rest.name != null) {
        restName = rest.name;
      }
      rest = new Rest(
          required: rest.required,
          help: rest.help,
          name: restName,
          parser: parser);
    } else if(parserFromTypeArgument != null) {
      rest = new Rest(name: restName, parser: parserFromTypeArgument);
    }

    return rest;
  }
  return null;
}

getDefaultPositionalName(Symbol symbol) {
  return MirrorSystem.getName(symbol).toUpperCase();
}

Usage getUsageFromFunction(MethodMirror methodMirror, {Usage usage}) {

  if(usage == null) usage = new Usage();

  usage.rest = getRestFromMethod(methodMirror);

  _addCommandMetadata(usage, methodMirror);

  var parameters = methodMirror.parameters;

  var required = parameters
      .where((parameter) => !parameter.isOptional).toList();
  if(usage.rest != null) required.removeLast();

  var positionals = required.map((parameter) {
    Positional positional = getFirstMetadataMatch(
        parameter, (metadata) => metadata is Positional);

    String positionalName = getDefaultPositionalName(parameter.simpleName);
    String positionalHelp;
    var parser;

    if(positional != null) {
      if(positional.name != null) {
        positionalName = positional.name;
      }
      positionalHelp = positional.help;
      parser = positional.parser;
    }

    if(parser == null) {
      parser = getParserFromType(parameter.type);
    }

    return new Positional(name: positionalName, help: positionalHelp, parser: parser);
  });

  positionals.forEach((positional) =>
      usage.addPositional(positional));

  parameters.where((parameter) => parameter.isNamed).forEach((parameter) {

    Option option;
    var type = parameter.type;

    var parameterName = MirrorSystem.getName(parameter.simpleName);

    InstanceMirror argAnnotation = parameter.metadata.firstWhere((annotation) =>
        annotation.reflectee is Option, orElse: () => null);

    if(argAnnotation != null) {
      option = argAnnotation.reflectee;
    } else if(type == reflectClass(bool)) {
      option = new Flag();
    } else {
      option = new Option();
    }

    var parser = option.parser;
    if(parser == null) {
      parser = getParserFromType(type);
    }

    var allowMultiple = option.allowMultiple;

    if(parser == null && type.originalDeclaration == reflectClass(List)) {
      allowMultiple = true;
      if(type.typeArguments.isNotEmpty){
        parser = getParserFromType(type.typeArguments.single);
      }
    }

    var defaultValue = option.defaultsTo;
    if(defaultValue == null && parameter.hasDefaultValue) {
      defaultValue = parameter.defaultValue.reflectee;
    }

    // Update option with any configuration detected in the parameter.
    // TODO: This is not very maintainable.
    // Use reflection instead to copy values over?
    option = option is Flag ?
        new Flag(help: option.help, abbr: option.abbr,
            defaultsTo: defaultValue, negatable: option.negatable) :
        new Option(help: option.help, abbr: option.abbr,
            defaultsTo: defaultValue, allowed: option.allowed,
            allowMultiple: allowMultiple, hide: option.hide,
            parser: parser);

    var optionName = dashesToCamelCase.decode(parameterName);

    usage.addOption(optionName, option);
  });

  _addSubCommandsForClass(usage, methodMirror.returnType);

  return usage;
}

getParserFromType(TypeMirror typeMirror) {
  if(typeMirror is ClassMirror &&
      typeMirror.declarations.values.any((d) => d.isStatic && d.simpleName == #parse)) {
    var closure = typeMirror[#parse];
    // TODO: This is a workaround for http://dartbug.com/16025.
    return (item) => closure(item).reflectee;
  }
  return null;
}

_addSubCommandsForClass(Usage usage, TypeMirror typeMirror) {
  if(typeMirror is ClassMirror) {

    var methods = getInstanceMethods(typeMirror).values;

    Map<MethodMirror, SubCommand> subCommands = {};

    methods.forEach((methodMirror) {
      var subCommand = methodMirror.metadata
          .map((im) => im.reflectee)
          .firstWhere(
              (v) => v is SubCommand,
              orElse: () => null);

      if(subCommand != null) {
        subCommands[methodMirror] = subCommand;
      }
    });

    var commands = {};

    subCommands.forEach((methodMirror, subCommand) {
      var commandName = dashesToCamelCase
          .decode(MirrorSystem.getName(methodMirror.simpleName));
      var subCommandUsage = getUsageFromFunction(
          methodMirror,
          usage: usage.addCommand(commandName));
    });
  }
}

_addCommandMetadata(Usage usage, DeclarationMirror declaration) {
  BaseCommand command = getFirstMetadataMatch(
      declaration, (metadata) => metadata is BaseCommand);
  var description = command == null ? '' : command.help;
  usage.description = description;
  Iterable<ArgExample> examples = declaration.metadata
      .map((annotation) => annotation.reflectee)
      .where((metadata) => metadata is ArgExample);
  examples.forEach((example) {
    usage.addExample(example);
  });
}

getFirstMetadataMatch(DeclarationMirror declaration, bool match(metadata)) {
  return declaration.metadata
      .map((annotation) => annotation.reflectee)
        .firstWhere(match, orElse: () => null);
}

void addOptionToParser(ArgParser parser, String name, Option option) {

  var suffix;

  var props = {
    #abbr: option.abbr,
    #help: option.help,
    #defaultsTo: option.defaultsTo
  };

  if(option is Flag) {
    suffix = 'Flag';
    props.addAll({
      #negatable: option.negatable
    });
  } else {
    suffix = 'Option';

    if(option.allowed != null) {
      var allowed = option.allowed;
      if(allowed is Map<String, String>) {
        allowed = allowed.keys.toList();
        props[#allowedHelp] = option.allowed;
      }
      props[#allowed] = allowed;
    }
    props.addAll({
      #allowMultiple: option.allowMultiple,
      #hide: option.hide,
    });
  }

  var namedParameters = props.keys.fold({}, ((ret, prop) {
    var value = props[prop];
    if(value != null) {
      ret[prop] = value;
    }
    return ret;
  }));

  var parserMethod = 'add$suffix';

  reflect(parser).invoke(new Symbol(parserMethod), [name], namedParameters);
}

// Returns a List whose elements are the required argument count, and whether
// there is a Rest parameter.
List getPositionalParameterInfo(MethodMirror methodMirror) {
  var positionals = methodMirror.parameters.where((parameter) =>
      !parameter.isNamed);

  // TODO: Find a better place for this check.
  if(positionals.any((positional) => positional.isOptional)) {
    throw new ArgumentError('Cannot use optional positional parameters.');
  }
  var requiredPositionals =
      positionals.where((parameter) => !parameter.isOptional);

  var isRest = false;
  if(requiredPositionals.isNotEmpty) {

    var lastFuncPositional = requiredPositionals.last;

    var isRestAnnotated = lastFuncPositional.metadata
        .map((annotation) => annotation.reflectee)
        .any((metadata) => metadata is Rest);
    // TODO: How to check if the type is List or List<String> ?
    // var isList = lastFuncPositional.type == reflectClass(List);
    isRest = isRestAnnotated;// || isList;
  }

  return [requiredPositionals.length - (isRest ? 1 : 0), isRest];
}

getRestParameterIndex(MethodMirror methodMirror) {
  var positionalParameterInfo = getPositionalParameterInfo(methodMirror);
  return positionalParameterInfo[1] ?
      positionalParameterInfo[0] :
        null;
}

MethodMirror getUnnamedConstructor(ClassMirror classMirror) {
  var constructors = classMirror.declarations.values
  .where((d) => d is MethodMirror && d.isConstructor);

  return constructors.firstWhere((constructor) =>
      constructor.constructorName == const Symbol(''), orElse: () => null);
}

convertCommandInvocationToInvocation(CommandInvocation commandInvocation, MethodMirror method, {Symbol memberName: #call}) {

  var positionals = commandInvocation.positionals;

  var named = {};

  commandInvocation.options.forEach((option, value) {
    var paramSymbol = new Symbol(dashesToCamelCase.encode(option));
    var paramExists = method.parameters.any((param) =>
        param.simpleName == paramSymbol);
    if(paramExists) {
      named[paramSymbol] = value;
    }
  });

  return new InvocationMaker.method(memberName, positionals, named).invocation;
}

// TODO (https://github.com/seaneagan/unscripted/issues/18)
Map<Symbol, MethodMirror> getInstanceMethods(ClassMirror classMirror) {
  var declarations = classMirror.declarations;
  return declarations.keys.fold({}, (ret, name) {
    var declaration = declarations[name];
    if(declaration is MethodMirror &&
       declaration.isRegularMethod &&
       !declaration.isStatic) {
      ret[name] = declaration;
    }
    return ret;
  });
}

parseInput(String arg, {filesystem.FileSystem fileSystem}) {
  if(fileSystem == null) {
    fileSystem = filesystem.fileSystem;
  }
  return _parseIOArg(arg, stdin, (stdin) => new _StdInput(stdin),
      (file) => new _FileInput(file), fileSystem);
}

parseOutput(String arg, {filesystem.FileSystem fileSystem}) {
  if(fileSystem == null) {
    fileSystem = filesystem.fileSystem;
  }
  return _parseIOArg(arg, stdout, (stdout) => new _StdOutput(stdout),
      (file) => new _FileOutput(file), fileSystem);
}

_parseIOArg(String arg, stdio, convertStdio(stdio), convertFile(file), filesystem.FileSystem fileSystem) {

  if(arg == '-') return convertStdio(stdio);

  var file = fileSystem.getFile(arg);

  if(!file.existsSync()) {
    throw 'File path does not exist or is not a file: ${file.path}';
  }

  return convertFile(file);
}

class _FileInput implements Input {

  File _file;

  _FileInput(this._file);

  String get path => _file.path;
  List<String> get lines => _file.readAsLinesSync();
  Stream<List<int>> get stream => _file.openRead();
  String get text => _file.readAsStringSync();
}

class _StdInput implements Input {

  Stdin _stdin;

  _StdInput(this._stdin);

  String get path => null;
  List<String> get lines => _getStdinLines(_stdin);
  Stdin get stream => _stdin;
  String get text => _getStdinLines(_stdin, true).join();
}

class _StdOutput implements Output {

  final IOSink _sink;

  _StdOutput(this._sink);

  String get path => null;
  IOSink get sink => _sink;
}

class _FileOutput implements Output {

  final File _file;

  _FileOutput(this._file);

  String get path => _file.path;
  IOSink get sink {
    if(_sink == null) _sink = _file.openWrite();
    return _sink;
  }

  IOSink _sink;
}

List<String> _getStdinLines(Stdin stdin, [bool retainNewlines = false]) {
  var lines = [];
  String line;
  while((line = stdin.readLineSync(retainNewlines: retainNewlines)) != null) {
    lines.add(line);
  }
  return lines;
}
