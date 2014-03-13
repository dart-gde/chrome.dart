
library unscripted.usage;

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:path/path.dart' as path;
import 'package:args/args.dart' show ArgParser, ArgResults;
import 'package:unscripted/unscripted.dart';
import 'package:unscripted/src/util.dart';

part 'usage_formatter.dart';

/// Adds a standard --help (-h) option to [parser].
/// If [parser] has any sub-commands also add a help sub-command,
/// and recursively add help to all sub-commands' parsers.
class Usage {

  /// The name used to invoke this command.
  final String name = null;

  /// The parent command's usage.  This is null for root commands.
  final Usage parent = null;

  /// A simple description of what this script does, for use in help text.
  String description;

  CallStyle callStyle = CallStyle.NORMAL;

  // TODO: Make public ?
  bool _allowTrailingOptions = false;

  Usage();

  /// The parser associated with this usage.
  // TODO: Make private.
  ArgParser get parser {
    if(_parser == null) {
      _parser = _getParser();
      _addHelpFlag(_parser);
    }
    return _parser;
  }
  ArgParser _getParser() => new ArgParser();
  ArgParser _parser;

  // Positionals

  addPositional(Positional positional) {
    _positionals.add(positional);
  }

  List<Positional> _positionals = [];
  List<Positional> _positionalsView;
  List<Positional> get positionals {
    if(_positionalsView == null) {
      _positionalsView = new UnmodifiableListView(_positionals);
    }
    return _positionalsView;
  }

  Rest rest;

  // Options

  Map<String, Option> _options = {};
  Map<String, Option> _optionsView;
  Map<String, Option> get options {
    if(_optionsView == null) {
      _optionsView = new UnmodifiableMapView(_options);
    }
    return _optionsView;
  }
  addOption(String name, Option option) {
    addOptionToParser(parser, name, option);
    _options[name] = option;
  }

  _addHelpFlag(ArgParser parser) =>
      addOption(HELP, new Flag(
          abbr: 'h',
          help: 'Print this usage information.',
          negatable: false));

  List<String> _commandPath;
  List<String> get commandPath {
    if(_commandPath == null) {
      var path = [];
      var usage = this;
      while(true) {
        if(usage.parent == null) {
          _commandPath = path;
          break;
        }
        usage = usage.parent;
      }
    }
    return _commandPath;
  }

  List<ArgExample> _examples = [];
  List<ArgExample> _examplesView;
  List<ArgExample> get examples {
    if(_examplesView == null) {
      _examplesView = new UnmodifiableListView(_examples);
    }
    return _examplesView;
  }
  addExample(ArgExample example) {
    _examples.add(example);
  }

  Map<String, Usage> _commands = {};
  Map<String, Usage> _commandsView;
  Map<String, Usage> get commands {
    if(_commandsView == null) {
      _commandsView = new UnmodifiableMapView(_commands);
    }
    return _commandsView;
  }
  Usage addCommand(String name) {
    parser.addCommand(name);
    var command = _commands[name] = new _SubCommandUsage(this, name);
    if(name != HELP && !commands.keys.contains(HELP)) {
      addCommand(HELP);
    }
    return command;
  }

  CommandInvocation validate(List<String> arguments) {

    var results = parser.parse(arguments, allowTrailingOptions: _allowTrailingOptions);

    var commandInvocation = convertArgResultsToCommandInvocation(results);

    // Don't apply usage if help is requested.
    var shouldApplyUsage = commandInvocation.helpPath == null;
    if(shouldApplyUsage) {
      commandInvocation = applyUsageToCommandInvocation(this, commandInvocation);
    }
    return commandInvocation;
  }

  CommandInvocation _validate(CommandInvocation commandInvocation) {
    var actual = commandInvocation.positionals != null ?
        commandInvocation.positionals.length : 0;
    int max;
    var min = positionals.length;
    if(rest == null) {
      max = positionals.length;
    } else if(rest.required) {
      min++;
    }

    throwPositionalCountError(String expectation) {
      throw new UsageException(usage: this, cause: 'Received $actual positional command-line '
          'arguments, but $expectation.');
    }

    if(actual < min) {
      throwPositionalCountError('at least $min required');
    }

    if(max != null && actual > max) {
      throwPositionalCountError('at most $max allowed');
    }
  }
}

class _SubCommandUsage extends Usage {

  final Usage parent;
  final String name;

  CallStyle get callStyle => parent.callStyle;

  _SubCommandUsage(this.parent, this.name);

  ArgParser _getParser() => parent.parser.commands[name];
}

class CommandInvocation {

  final String name;
  final List positionals;
  final Map<String, dynamic> options;
  final CommandInvocation subCommand;
  List<String> get helpPath {
    if(_helpPath == null) _helpPath = _getHelpPath();
    return _helpPath;
  }
  List<String> _getHelpPath() {
    var path = [];
    var subCommandInvocation = this;
    while(true) {
      if(subCommandInvocation.options.containsKey(HELP) &&
          subCommandInvocation.options[HELP]) return path;
      if(subCommandInvocation.subCommand == null) return null;
      if(subCommandInvocation.subCommand.name == HELP) {
        var helpCommand = subCommandInvocation.subCommand;
        if(helpCommand.positionals.isNotEmpty) {
          path.add(helpCommand.positionals.first);
        }
        return path;
      }
      subCommandInvocation = subCommandInvocation.subCommand;
      path.add(subCommandInvocation.name);
    }
    return path;
  }
  List<String> _helpPath;

  CommandInvocation._(this.name, this.positionals, this.options, this.subCommand);
}

class UsageException {
  final Usage usage;
  final String arg;
  final cause;

  UsageException({this.usage, this.arg, this.cause});

  String toString() {
    var argMesage = arg == null ? '' : ': argument $arg';
    var callStyle = usage.callStyle;
    if(callStyle == CallStyle.NORMAL) callStyle = CallStyle.SHEBANG;
    var command = formatCallStyle(callStyle);
    return '$command: error$argMesage: $cause';
  }
}

CommandInvocation convertArgResultsToCommandInvocation(ArgResults results) {

  var positionals = results.rest;

  var options = results.options.fold({}, (options, optionName) {
        options[optionName] = results[optionName];
        return options;
      });

  CommandInvocation subCommand;

  if(results.command != null) {
    subCommand =
        convertArgResultsToCommandInvocation(results.command);
  }

  return new CommandInvocation._(results.name, positionals, options, subCommand);
}

CommandInvocation applyUsageToCommandInvocation(Usage usage, CommandInvocation invocation) {

  usage._validate(invocation);

  var positionalParams = usage.positionals;
  var positionalArgs = invocation.positionals;
  int restParameterIndex;

  if(usage.rest != null) {
    restParameterIndex = positionalParams.length;
    positionalArgs = positionalArgs.take(restParameterIndex).toList();
  }

  var positionalParsers =
      positionalParams.map((positional) => positional.parser);
  var positionalNames =
      positionalParams.map((positional) => positional.name);

  parseArg(parser, arg, name) {
    if(parser == null || arg == null) return arg;
    try {
      return parser(arg);
    } catch(e) {
      throw new UsageException(usage: usage, arg: name, cause: e);
    }
  }

  List zipParsedArgs(args, parsers, names) {
    return new IterableZip([args, parsers, names])
        .map((parts) => parseArg(parts[1], parts[0], parts[2]))
        .toList();
  }

  var positionals = zipParsedArgs(
      positionalArgs,
      positionalParsers,
      positionalNames);

  if(usage.rest != null) {
    var rawRest = invocation.positionals.skip(restParameterIndex);
    var rest = zipParsedArgs(
        rawRest,
        new Iterable.generate(rawRest.length, (_) => usage.rest.parser),
        new Iterable.generate(rawRest.length, (_) => usage.rest.name));
    positionals.add(rest);
  }

  var options = <String, dynamic> {};

  usage.options
      .forEach((optionName, option) {
        var optionValue = invocation.options[optionName];
        var values = optionValue is List ? optionValue : [optionValue];
        parseValue(value) => parseArg(option.parser, value, optionName);
        options[optionName] = optionValue is List ?
            new UnmodifiableListView(optionValue.map(parseValue)) :
            parseValue(optionValue);
      });

  CommandInvocation subCommand;

  if(invocation.subCommand != null) {
    subCommand =
        applyUsageToCommandInvocation(usage.commands[invocation.subCommand.name], invocation.subCommand);
  }

  return new CommandInvocation._(invocation.name, positionals, options, subCommand);
}
