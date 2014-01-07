/* This file has been generated from commands.json - do not edit */

/**
 * Use the commands API to add keyboard shortcuts that trigger actions in your
 * extension, for example, an action to open the browser action or send a
 * command to the extension.
 */
library chrome.commands;

import '../src/common.dart';

/**
 * Accessor for the `chrome.commands` namespace.
 */
final ChromeCommands commands = new ChromeCommands._();

class ChromeCommands extends ChromeApi {
  static final JsObject _commands = chrome['commands'];

  ChromeCommands._();

  bool get available => _commands != null;

  /**
   * Returns all the registered extension commands for this extension and their
   * shortcut (if active).
   */
  Future<List<Command>> getAll() {
    if (_commands == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<Command>>.oneArg((e) => listify(e, _createCommand));
    _commands.callMethod('getAll', [completer.callback]);
    return completer.future;
  }

  /**
   * Fired when a registered command is activated using a keyboard shortcut.
   */
  Stream<String> get onCommand => _onCommand.stream;

  final ChromeStreamController<String> _onCommand =
      new ChromeStreamController<String>.oneArg(_commands, 'onCommand', selfConverter);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.commands' is not available");
  }
}

class Command extends ChromeObject {
  Command({String name, String description, String shortcut}) {
    if (name != null) this.name = name;
    if (description != null) this.description = description;
    if (shortcut != null) this.shortcut = shortcut;
  }
  Command.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The name of the Extension Command
   */
  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  /**
   * The Extension Command description
   */
  String get description => jsProxy['description'];
  set description(String value) => jsProxy['description'] = value;

  /**
   * The shortcut active for this command, or blank if not active.
   */
  String get shortcut => jsProxy['shortcut'];
  set shortcut(String value) => jsProxy['shortcut'] = value;
}

Command _createCommand(JsObject jsProxy) => jsProxy == null ? null : new Command.fromProxy(jsProxy);
