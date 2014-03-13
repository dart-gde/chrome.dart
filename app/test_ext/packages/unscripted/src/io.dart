
part of unscripted;

/// Represents a script input, either [stdin] or a file.
abstract class Input {

  /// Returns an input representing [stdin] if [arg] is '-',
  /// or a file if [arg] is a valid file path, else throws.
  static Input parse(String arg) => parseInput(arg);

  /// Returns the file path for files, `null` for [stdin].
  String get path;

  /// The full input text.
  String get text;

  /// The lines of the input, newlines are not retained.
  List<String> get lines;

  /// A stream of the input content.
  Stream<List<int>> get stream;
}

/// Represents a script output, either [stdout] or a file.
abstract class Output {

  /// Returns an output which represents [stdout] if [output] is '-',
  /// or a file if [output] is a valid file path, else throws.
  static Output parse(String arg) => parseOutput(arg);

  /// Returns the file path for files, `null` for [stdout].
  String get path;

  /// Either [stdout] itself, or the result of [File.openWrite] for files.
  IOSink get sink;
}
