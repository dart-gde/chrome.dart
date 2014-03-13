
library unscripted.declaration_script;

import 'dart:mirrors';

import 'package:unscripted/unscripted.dart';
import 'package:unscripted/src/string_codecs.dart';
import 'package:unscripted/src/usage.dart';
import 'package:unscripted/src/util.dart';

abstract class ScriptImpl implements Script {

  Usage get usage;

  UsageFormatter getUsageFormatter(Usage usage) =>
      new TerminalUsageFormatter(usage);

  execute(List<String> arguments) {

    CommandInvocation commandInvocation;

    try {
      commandInvocation = usage.validate(arguments);
    } catch (e) {
      // TODO: ArgParser.parse throws FormatException which does not indicate
      // which sub-command was trying to be executed.
      var helpUsage = e is UsageException ? e.usage : usage;
      print('$e\n');
      _printHelp(helpUsage);
      return;
    }

    if(_checkHelp(commandInvocation)) return;
    _handleResults(commandInvocation);

  }

  /// Handles successfully validated [commandInvocation].
  _handleResults(CommandInvocation commandInvocation);

  /// Prints help information for the associated command or sub-command thereof
  /// at [commandPath].
  // TODO: Integrate with Loggers.
  _printHelp(Usage helpUsage) {
    print(getUsageFormatter(helpUsage).format());
  }

  bool _checkHelp(CommandInvocation commandInvocation) {
    var path = commandInvocation.helpPath;
    if(path != null) {
      var helpUsage = path
          .fold(usage, (usage, subCommand) =>
              usage.commands[subCommand]);
      _printHelp(helpUsage);
      return true;
    }
    return false;
  }
}

abstract class DeclarationScript extends ScriptImpl {

  DeclarationMirror get _declaration;

  MethodMirror get _method;

  DeclarationScript();

  Usage get usage => getUsageFromFunction(_method);

  _handleResults(CommandInvocation commandInvocation) {

    var topInvocation = convertCommandInvocationToInvocation(commandInvocation, _method);

    var topResult = _getTopCommandResult(topInvocation);

    _handleSubCommands(topResult, commandInvocation.subCommand, usage);
  }

  _getTopCommandResult(Invocation invocation);

  _handleSubCommands(InstanceMirror result, CommandInvocation commandInvocation, Usage usage) {

    if(commandInvocation == null) {
      // TODO: Move this to an earlier UsageException instead ?
      if(usage != null && usage.commands.isNotEmpty) {
        print('Must specify a sub-command.\n');
        _printHelp(usage);
      }
      return;
    }

    var commandName = commandInvocation.name;
    var commandSymbol = new Symbol(dashesToCamelCase.encode(commandName));
    var classMirror = result.type;
    var methods = getInstanceMethods(classMirror);
    var commandMethod = methods[commandSymbol];
    var invocation = convertCommandInvocationToInvocation(commandInvocation, commandMethod, memberName: commandSymbol);
    var subResult = result.delegate(invocation);
    Usage subUsage;
    if(commandInvocation.subCommand != null) subUsage = usage.commands[commandInvocation.subCommand.name];
    _handleSubCommands(reflect(subResult), commandInvocation.subCommand, subUsage);
  }

}

class FunctionScript extends DeclarationScript {

  final Function _function;

  MethodMirror get _declaration =>
      (reflect(_function) as ClosureMirror).function;

  MethodMirror get _method => _declaration;

  FunctionScript(this._function) : super();

  _getTopCommandResult(Invocation invocation) => reflect(Function.apply(
      _function,
      invocation.positionalArguments,
      invocation.namedArguments));
}

class ClassScript extends DeclarationScript {

  Type _class;

  ClassMirror get _declaration => reflectClass(_class);

  MethodMirror get _method => getUnnamedConstructor(_declaration);

  ClassScript(this._class) : super();

  _getTopCommandResult(Invocation invocation) => _declaration.newInstance(
      const Symbol(''),
      invocation.positionalArguments,
      invocation.namedArguments);
}
