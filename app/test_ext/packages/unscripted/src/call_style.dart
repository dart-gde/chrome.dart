
part of unscripted;

/// How the command is called on the command line.
class CallStyle {

  final String _name;

  /// Called with the dart executable.
  /// Example:
  ///     dart foo.dart ...
  static const CallStyle NORMAL = const CallStyle._('NORMAL');
  /// Called without the dart executable, such as by including a shebang
  /// at the beginning of the script.
  /// Example:
  ///     foo.dart ...
  static const CallStyle SHEBANG = const CallStyle._('SHEBANG');
  /// Called without the '.dart' file extension, similar to a shell command.
  /// Example:
  ///     foo ...
  static const CallStyle SHELL = const CallStyle._('SHELL');

  const CallStyle._(this._name);

}
