import 'dart:io';

import 'package:args/args.dart';
import 'package:logging/logging.dart' as logging;

import 'backend.dart';
import 'chrome_model.dart';
import 'json_model.dart' as json_model;
import 'json_parser.dart' as json_parser;
import 'chrome_idl_parser.dart' as chrome_idl_parser;
import 'chrome_idl_convert.dart' as chrome_idl_convert;
import 'chrome_idl_model.dart' as chrome_idl_model;
import 'overrides.dart';
import 'src/src_gen.dart';
import 'src/utils.dart';

void main(List<String> args) {
  ArgParser parser = _createArgsParser();
  ArgResults results = parser.parse(args);

  if (results['help'] || results.rest.length != 1) {
    _printUsage(parser);
    return;
  }

  if (results['out'] == null) {
    print("You must provide a value for 'out'.");
    _printUsage(parser);
    return;
  }

  Overrides overrides;

  if (results['overrides'] != null) {
    var overridesFile = new File(results['overrides']);
    overrides = new Overrides.fromFile(overridesFile);
  } else {
    overrides = new Overrides();
  }

  logging.Logger.root.onRecord.listen((logging.LogRecord record) {
    print(record.message);
  });

  GenApiFile generator = new GenApiFile(new File(results.rest.first),
      overrides: overrides);
  generator.generate(new File(results['out']));
}

class GenApiFile {
  final File inFile;
  final Overrides overrides;

  ChromeLibrary _chromeLib;
  Backend _backend;

  GenApiFile(this.inFile, {Overrides overrides, DartGenerator generator}) :
      this.overrides = (overrides == null) ? new Overrides() : overrides {
    if (!inFile.path.endsWith(".json") && !inFile.path.endsWith(".idl")) {
      throw new Exception('format not understood: ${inFile.path}');
    }

    if (inFile.path.endsWith(".json")) {
      json_model.JsonNamespace namespace = json_parser.parse(
          inFile.readAsStringSync());
      _chromeLib = json_model.convert(namespace);
    } else if (inFile.path.endsWith(".idl")) {
      chrome_idl_parser.ChromeIDLParser chromeIdlParser =
          new chrome_idl_parser.ChromeIDLParser();
      chrome_idl_model.IDLNamespaceDeclaration idlNamespaceDeclaration =
          chromeIdlParser.namespaceDeclaration.parse(inFile.readAsStringSync());
      _chromeLib = chrome_idl_convert.convert(idlNamespaceDeclaration);
    } else {
      throw new ArgumentError('file type unsupported: ${inFile}');
    }

    _backend = new Backend.createDefault(_chromeLib, overrides, generator);
  }

  void generate(File outFile) {
    _logger.info("parsing ${inFile.path}...");

    String fileName = getFileName(inFile);

    outFile.parent.createSync();

    outFile.writeAsStringSync(_backend.generate(sourceFileName: fileName));
  }

  void generateAccessor() {
    _backend.generateAccessor();
  }

  List<String> getImports() {
    return _chromeLib.imports;
  }

  void generateContent(bool printClassDocs, Set createdFactories, Set createdClasses) {
    _backend.generateContent(printClassDocs, createdFactories, createdClasses);
  }
}

// args handling

ArgParser _createArgsParser() {
  ArgParser parser = new ArgParser();
  parser.addFlag('help',
      abbr: 'h',
      negatable: false,
      help: 'show command help');
  parser.addOption(
      'out',
      abbr: 'o',
      help: 'Path to the destination file. Required.');

  parser.addOption(
      'overrides',
      help: 'Path to on overrides json file.');
  return parser;
}

void _printUsage(ArgParser parser) {
  print('usage: dart gen_api <options> path/to/idl_or_json_file');
  print('');
  print('where <options> is one or more of:');
  print(parser.getUsage().replaceAll('\n\n', '\n'));
}

final logging.Logger _logger = new logging.Logger('GenApi');
