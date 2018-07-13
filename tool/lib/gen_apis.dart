
library gen_apis;

import 'dart:io';
import 'dart:convert';
import 'package:logging/logging.dart' as logging;
import 'package:path/path.dart' as pathos;

import 'gen_api.dart';
import 'overrides.dart';
import '../src/src_gen.dart';
import '../src/utils.dart';

// TODO: parse _api_features.json and add permissions info to the dartdoc for
// the libraries

void main() {
  DateTime startTime = new DateTime.now();

  logging.Logger.root.onRecord.listen((logging.LogRecord record) {
    print(record.message);
  });

  new GenApis().generate();

  Duration elapsed = new DateTime.now().difference(startTime);
  print("generated in ${elapsed.inMilliseconds}ms.");
}

final logging.Logger _logger = new logging.Logger('GenApis');

class GenApis {
  final String outDirPath;
  final Directory idlDir;
  final File apisFile;
  final File overridesFile;

  GenApis() :
    outDirPath = pathos.join(pathos.current, 'lib'),
    apisFile = new File('meta/apis.json'),
    overridesFile = new File('meta/overrides.json'),
    idlDir = new Directory('idl') {

    if (!idlDir.existsSync()) {
      throw new Exception('${idlDir.path} not found');
    }
  }

  void generate() {
    _logger.info("reading ${apisFile.path}...");

    var apisInfo = jsonDecode(apisFile.readAsStringSync());

    _generateApi('app', apisInfo['packaged_app'], includeAppSrc: true);
    _generateApi('ext', apisInfo['extension'], alreadyWritten: apisInfo['packaged_app']);

    // Generate orphaned libraries.
    _logger.info("writing loose libraries...");
    Overrides overrides = new Overrides.fromFile(overridesFile);

    for (String libName in apisInfo['other']) {
      _generateFile(overrides, libName);
    }
  }

  void _generateApi(String name, List<String> libraryNames,
                    {List<String> alreadyWritten, bool includeAppSrc: false,
                     String licence}) {
    File libFile = new File(pathos.join(outDirPath, "chrome_${name}.dart"));

    DartGenerator generator = new DartGenerator();

    if (licence != null) {
      generator.writeln(licence);
      generator.writeln();
    }
    generator.writeln("/* This file has been generated - do not edit */");
    generator.writeln();

    generator.writeDocs('A library to expose the Chrome ${name} APIs.');
    generator.writeln("library chrome_${name};");
    generator.writeln();

    Map<String, List<String>> combinedLibraries = {};

    for (String libName in libraryNames) {
      if (libName.contains('.')) {
        _combine(combinedLibraries, libName);
      }
    }

    List<String> exportFiles = [];
    exportFiles.addAll(combinedLibraries.keys);
    exportFiles.addAll(libraryNames.where((name) => !_isCombined(combinedLibraries, name)));
    exportFiles.sort();

    for (String name in exportFiles) {
      generator.writeln("export 'gen/${_convertJSLibNameToFileName(name)}.dart';");
    }

    generator.writeln();
    generator.writeln("export 'src/common_exp.dart';");

    if (includeAppSrc) {
      generator.writeln("export 'src/files_exp.dart';");
    }

    libFile.writeAsStringSync(generator.toString());
    _logger.info('wrote ${libFile.path}');

    if (alreadyWritten != null) {
      libraryNames.removeWhere((e) => alreadyWritten.contains(e));
    }

    Overrides overrides = new Overrides.fromFile(overridesFile);

    for (String shortName in combinedLibraries.keys) {
      _generateCombinedFile(overrides, shortName, combinedLibraries[shortName]);
    }

    for (String libName in libraryNames) {
      if (!_isCombined(combinedLibraries, libName)) {
        _generateFile(overrides, libName);
      }
    }
  }

  void _generateCombinedFile(Overrides overrides, String shortName, List<String> libNames) {
    Directory genDir = new Directory(pathos.join(outDirPath, 'gen'));
    if (!genDir.existsSync()) {
      genDir.createSync();
    }

    String fileName = _convertJSLibNameToFileName(shortName);
    File outFile = new File(pathos.join(outDirPath, 'gen', "${fileName}.dart"));
    File patchFile = new File(pathos.join(outDirPath, 'gen', "${fileName}_patch.dart"));

    DartGenerator generator = new DartGenerator();

    Iterable<GenApiFile> apis = libNames.map((String name) {
      String fileName = _convertJSLibNameToFileName(name);
      String locateName = fileName.replaceFirst("devtools_", "devtools/");

      File definitionFile = _locateDefinitionFile(locateName);
      if (definitionFile == null) {
        throw new UnsupportedError("Unable to locate idl or json file for '${locateName}'.");
      }

      if (definitionFile.path.endsWith('.json')) {
        return new GenApiFile(
            definitionFile, overrides: overrides, generator: generator);
      } else {
        return new GenApiFile(
            definitionFile, overrides: overrides, generator: generator);
      }
    });

    generator.writeln("/* This file has been generated - do not edit */");
    generator.writeln();

    generator.writeln('library chrome.${shortName};');
    generator.writeln();

    generator.writeln("import '../src/common.dart';");
    Set<String> imports = new Set();
    apis.forEach((api) => imports.addAll(api.getImports()));
    imports.forEach((String str) {
      if (str.endsWith('.dart')) {
        generator.writeln("import '${str}';");
      } else {
        str = fromCamelCase(str.replaceAll('.', '_'));
        generator.writeln("import '${str}.dart';");
      }
    });
    generator.writeln();

    if (patchFile.existsSync()) {
      generator.writeln("part '${fileName}_patch.dart';");
      generator.writeln();
    }

    // create the combined reference
    String className = 'Chrome${titleCase(shortName)}';

    generator.writeln("final ${className} ${shortName} = new ${className}._();");
    generator.writeln();

    generator.writeln("class ${className} {");
    generator.writeln("${className}._();");
    apis.forEach((api) => api.generateAccessor());
    generator.writeln("}");
    var createdFactories = new Set<String>();
    var createdClasses = new Set<String>();
    apis.forEach((api) => api.generateContent(true, createdFactories, createdClasses));

    outFile.writeAsStringSync(generator.toString());
  }

  void _generateFile(Overrides overrides, String jsLibName) {
    String fileName = _convertJSLibNameToFileName(jsLibName);

    File definitionFile = _locateDefinitionFile(fileName);
    if (definitionFile == null) {
      throw new UnsupportedError("Unable to locate idl or json file for '${fileName}'.");
    }

    File outFile = new File(pathos.join(outDirPath, 'gen', "${fileName}.dart"));

    if (definitionFile.path.endsWith('.json')) {
      GenApiFile apiGen = new GenApiFile(definitionFile, overrides: overrides);
      apiGen.generate(outFile);
    } else {
      GenApiFile apiGen = new GenApiFile(definitionFile, overrides: overrides);
      apiGen.generate(outFile);
    }
  }

  void _combine(Map<String, List<String>> combinedLibraries, String libName) {
    String combinedName = libName.substring(0, libName.indexOf('.'));

    if (!combinedLibraries.containsKey(combinedName)) {
      combinedLibraries[combinedName] = [];
    }

    combinedLibraries[combinedName].add(libName);
  }

  bool _isCombined(Map<String, List<String>> combinedLibraries, String libName) {
    return libName.contains('.');
  }

  String _convertJSLibNameToFileName(String jsLibName) {
    //jsLibName = jsLibName.replaceAll('devtools.', 'devtools_');
    jsLibName = jsLibName.replaceAll('.', '_');

    jsLibName = jsLibName.replaceAllMapped(
        new RegExp(r"[A-Z]"),
        (Match m) => "_${m.group(0).toLowerCase()}");

    return jsLibName;
  }

  File _locateDefinitionFile(String name) {
    File file = new File("${idlDir.path}/chrome/${name}.json");
    if (file.existsSync()) return file;

    file = new File("${idlDir.path}/chrome/${name}.idl");
    if (file.existsSync()) return file;

    file = new File("${idlDir.path}/extensions/${name}.json");
    if (file.existsSync()) return file;

    file = new File("${idlDir.path}/extensions/${name}.idl");
    if (file.existsSync()) return file;

    return null;
  }
}
