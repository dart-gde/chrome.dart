
part of unscripted;

/// An annotation which marks named method parameters as command line options.
///
/// See the corresponding method parameters to [ArgParser.addOption]
/// for descriptions of the fields.
class Option extends Help {
  final String abbr;
  /// Either a `List<String>` of allowed values, or `Map<String, String>` of
  /// allowed values to help text.
  final allowed;
  final bool allowMultiple;
  final bool hide;
  final defaultsTo;
  /// A function which validates and/or transforms the raw command-line String
  /// value into a form accepted by the [Script].  It should throw to indicate
  /// that the argument is invalid.
  final Function parser;

  const Option({
      String help,
      parser(String arg),
      this.abbr,
      this.allowed,
      this.allowMultiple,
      this.hide,
      this.defaultsTo})
      : this.parser = parser,
        super(help: help);
}

/// An annotation which marks named method parameters as command line flags.
///
/// See the corresponding method parameters to [ArgParser.addFlag]
/// for descriptions of the fields.
class Flag extends Option {
  final bool negatable;

  const Flag({
      String help,
      String abbr,
      defaultsTo,
      bool hide,
      bool negatable})
      : this.negatable = negatable == null ? false : negatable,
        super(help: help, abbr: abbr, defaultsTo: defaultsTo, hide: hide);
}

/// An annotation which gives example arguments that can be passed to a
/// [Command] or [SubCommand].
class ArgExample extends Help {

  /// The example arguments.
  ///
  /// Note:  This should not include the name of the command or sub-command
  /// itself, just the arguments.
  final String example;

  const ArgExample(this.example, {String help}) : super(help: help);
}

/// An annotation which marks required positional parameters as
/// positional command line parameters.
class Positional extends Help {

  /// The name to identify the parameter with in usage text.  By
  /// default the name of the dart parameter is used converted from camelCase
  /// to dash-erized.
  final String name;

  /// A function which validates and/or transforms the raw command-line String
  /// value into a form accepted by the [Script].  It should throw to indicate
  /// that the argument is invalid.
  final Function parser;

  const Positional({String help, parser(String arg), this.name})
      : this.parser = parser,
      super(help: help);
}

/// An annotation which marks the last positional parameter of a method
/// as a rest argument.  If the parameter has a type annotation,
/// it should be `List` or `List<String>`.
class Rest extends Positional {

  /// The minimum amount of arguments that should be passed to the rest
  /// parameter to avoid an error being thrown.
  final bool required;

  const Rest({String name, String help, parser(String arg), this.required: false})
      : super(name: name, parser: parser, help: help);
}

/// An annotation which marks a class as representing a script command.
class Command extends BaseCommand {
  final CallStyle callStyle;

  const Command({String help, this.callStyle}) : super(help: help);
}

/// An annotation which marks an instance method of a [Command] as a
/// sub-command.
class SubCommand extends BaseCommand {
  const SubCommand({String help}) : super(help: help);
}
