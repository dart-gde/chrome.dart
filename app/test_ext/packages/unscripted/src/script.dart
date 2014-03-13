
part of unscripted;

/// Declares a [Script] from [model].
///
/// The model is generally a closure of a method, which is annotated with
/// command-line metadata.  The model can also be a class (see below).
///
/// The method itself can be annotated as a [Command].
///
/// The method's parameters define the script's command-line parameters.
/// Named parameters with [bool] type or [Flag] metadata represent command-line
/// flags.  Other named parameters represent value-taking command-line options,
/// and can accept [Option] metadata.  Required positional parameters are
/// mapped to positional command-line parameters, and can use [Positional] metadata.
/// Optional positional parameters are not allowed.  However, [Rest] metadata
/// can be placed on the last positional parameter to represent all remaining
/// positional arguments passed to the script.
///
/// Any value-taking argument (option, positional, rest) can have a "parser".
/// This is a function which is responsible for validating and/or transforming
/// the string value passed on the command-line before it is passed to the
/// method.  Rest parsers are applied to each command-line value they receive.
/// If a parser throws an exception, it is `toString`ed and displayed to the
/// user
/// Parsers can be declared either via the `parser` field of the
/// appropriate metadata (see above), or by giving the method parameter a type
/// which has a static `parse` method that can be used as the parser.  For
/// example `int` parameters are parsed with `int.parse`.
///
/// Sub-commands can be added to the script by creating a class with instance
/// methods annotated as [SubCommand]s.  The model returns an instance of this
/// class and documents this in it's return type.  Most commonly the model is
/// a constructor of this class.  But since dart does
/// [not yet](http://dartbug.com/10659) have syntax for closurizing constructors,
/// the model can be a class literal, to indicate to that the unnamed
/// constructor of the class is the actual model.
///
/// Help flags ('--help' / '-h') are automatically included.  If the script has
/// sub-commands, a 'help' command is also included, which can be invoked bare,
/// 'help' as a synonym for '--help', or by specifying a sub-command e.g.
/// 'help sub-command'.
///
/// When the returned script is [executed][Script.execute], if the user
/// requested help for, or incorrectly invoked, the command or a sub-command,
/// then the help text is displayed, along with any specific error.  Otherwise,
/// the command-line arguments are valid, and are injected into the
/// corresponding method parameters.  If the model has sub-commands, then if a
/// sub-command was specified on the command-line, it is invoked with it's
/// corresponding command-line arguments, and so forth (recursively).  If a
/// model has sub-commands, but no sub-command was specified, this is treated
/// as an error, and the help text is displayed.
///
/// Basic example:
///
///     main(arguments) => declare(greet).execute(arguments);
///
///     // Optional command-line metadata:
///     @Command(help: 'Outputs a greeting')
///     @ArgExample('--salutation Welcome --exclaim Bob', help: 'enthusiastic')
///     greet(
///         @Rest(help: "Name(s) to greet")
///         List<String> who, // A rest parameter, must be last positional.
///         {String salutation : 'Hello', // An option, use `@Option(...)` for metadata.
///          bool exclaim : false}) { // A flag, use `@Flag(...)` for metadata.
///
///       print('$salutation ${who.join(' ')}${exclaim ? '!' : ''}');
///
///     }
///
/// Sub-command example:
///
///     main(arguments) => declare(Server).execute(arguments);
///
///     class Server {
///
///       final String configPath;
///
///       @Command(help: 'Manages a server')
///       Server({this.configPath: 'config.xml'});
///
///       @SubCommand(help: 'Start the server')
///       start({bool clean}) {
///         print('''
///     Starting the server.
///     Config path: $configPath''');
///       }
///
///       @SubCommand(help: 'Stop the server')
///       stop() {
///         print('Stopping the server.');
///       }
///
///     }
///
/// Commands and SubCommands can also be annotated with [ArgExample]s, to
/// document, in the help text, example arguments that they can receive.
///
/// Parameter and command names which are camelCased are mapped to their
/// dash-erized command-line equivalents.  For example, `fooBar` would map to
/// `foo-bar`.
Script declare(model) {
  if(model is Function) return new FunctionScript(model);
  if(model is Type) return new ClassScript(model);
  throw new ArgumentError('model must be a Type or Function');
}

/// Represents a command-line script.
///
/// The main way to interact with a script is to [execute] it.
abstract class Script {

  /// Executes this script.
  ///
  /// First, the [arguments] are parsed.  If the arguments were invalid *or*
  /// if help was requested, help text is printed and the method returns.
  /// Otherwise, script-specific logic is executed on the successfully parsed
  /// arguments.
  execute(List<String> arguments);

}
