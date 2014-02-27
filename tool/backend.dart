
library backend;

import 'chrome_model.dart';
import 'overrides.dart';
import 'src/src_gen.dart';
import 'src/utils.dart';

/**
 * An abstract superclass for anything that wants to translate from an IDL model
 * into source code.
 */
abstract class Backend {
  final ChromeLibrary library;
  final Overrides overrides;

  Backend(this.library, this.overrides);

  factory Backend.createDefault(ChromeLibrary library, Overrides overrides, [DartGenerator generator]) {
    return new DefaultBackend(library, overrides, generator);
  }

  void generateAccessor();
  void generateContent(bool printClassDocs, Set createdFactories, Set createdClasses);

  String generate({String license, String sourceFileName});
}

class DefaultBackend extends Backend {
  /**
   * Used to be able to construct specific subclasses of a given type.
   */
  static final Map ALT_FACTORIES = {
    "DirectoryEntry": "CrDirectoryEntry",
    "DOMFileSystem": "CrFileSystem",
    "Entry": "CrEntry",
    "FileEntry": "ChromeFileEntry"
  };

  DartGenerator generator;

  final Set<String> _neededFactories = new Set<String>();

  DefaultBackend(ChromeLibrary library, Overrides overrides, [this.generator]): super(library, overrides) {
    if (generator == null) {
      generator = new DartGenerator();
    }
  }

  void generateAccessor() {
    String shortAccessorName = libraryName;
    if (shortAccessorName.contains('_')) {
      shortAccessorName = shortAccessorName.substring(shortAccessorName.indexOf('_') + 1);
    }

    // final ChromeI18N i18n = ChromeI18N._i18n == null ? null : new ChromeI18N._();
    generator.writeln();
    generator.writeDocs("Accessor for the `chrome.${library.name}` namespace.");
    generator.writeln("final ${className} ${shortAccessorName} = new ${className}._();");
  }

  String generate({String license, String sourceFileName}) {
    if (license != null) {
      generator.writeln(license);
      generator.writeln();
    }

    if (sourceFileName != null) {
      generator.writeln("/* This file has been generated from ${sourceFileName} - do not edit */");
    } else {
      generator.writeln("/* This file is auto-generated */");
    }
    generator.writeln();

    generator.writeDocs(library.documentation);
    generator.writeln("library chrome.${libraryName};");
    generator.writeln();

    library.imports.forEach((String str) {
      if (str.endsWith('.dart')) {
        generator.writeln("import '${str}';");
      } else {
        str = fromCamelCase(str.replaceAll('.', '_'));
        generator.writeln("import '${str}.dart';");
      }
    });
    generator.writeln("import '../src/common.dart';");

    generateAccessor();

    generateContent(false, new Set<String>(), new Set<String>());

    return generator.toString();
  }

  void generateContent(bool printClassDocs, Set createdFactories, Set createdClasses) {
    generator.writeln();
    if (printClassDocs) {
      generator.writeDocs(library.documentation);
    }
    _printClass();

    library.eventTypes.forEach(_printEventType);
    library.enumTypes.forEach(_printEnumType);
    library.types..where((t) => !createdClasses.contains(t.name)).forEach((t) {
      createdClasses.add(t.name);
      _printDeclaredType(t);
    });
    library.returnTypes.forEach(_printReturnType);

    if (_neededFactories.isNotEmpty) {
      generator.writeln();

      while (_neededFactories.isNotEmpty) {
        var factoryType = _neededFactories.first;
        _neededFactories.remove(factoryType);

        if (!createdFactories.contains(factoryType)) {
          _writeFactory(factoryType);
          createdFactories.add(factoryType);
        }
      }
    }

    overrides.classRenamesFor(library.name).forEach((List<String> renamePair) {
      generator.renameSymbol(renamePair[0], renamePair[1]);
    });
  }

  String get libraryName {
    return library.name.replaceAll('.', '_');
  }

  /**
   * Returns a class name like 'ChromeFooBar'.
   */
  String get className {
    var name = overrides.namespaceRename(library.name);
    if (name == null) {
      name = titleCase(toCamelCase(library.name));
    }

    return "Chrome${name}";
  }

  String get contextReference {
    return "_${library.name.replaceAll('.', '_')}";
  }

  void _printClass() {
    List sections = library.name.split('.');

    String name = overrides.overrideClass(className);

    generator.writeln("class ${name} extends ChromeApi {");
    generator.writeln("JsObject get ${contextReference} => chrome['${sections.join('\'][\'')}'];");
    library.events.forEach(_printEventDecl);
    generator.writeln();
    if (library.events.length == 0) {
       // There are no events, so don't print an empty code block
       generator.writeln("${name}._();");
    } else {
       generator.writeln("${name}._() {");
       generator.writeln("var getApi = () => ${contextReference};");
       library.events.forEach(_printEventAssign);
       generator.writeln("}");
    }
    generator.writeln();
    generator.writeln("bool get available => ${contextReference} != null;");

    library.filteredProperties.forEach((p) => _printPropertyRef(p, contextReference));
    library.methods.forEach(_printMethod);

    generator.writeln();
    generator.writeln('void _throwNotAvailable() {');
    generator.writeln('throw new UnsupportedError("\'chrome.${library.name}\' is not available");');
    generator.writeln("}");

    generator.writeln("}");
  }

  void _printPropertyRef(ChromeProperty property, String refString, [bool printSetter = false]) {
    String converter = getReturnConverter(property.type);
    String getterBody = "${refString}['${property.idlName}']";

    generator.writeln();
    generator.writeDocs(property.getDescription());
    generator.write("${property.type.toReturnString()} ");
    generator.write("get ${property.name} => ");
    generator.writeln("${converter.replaceFirst('%s', getterBody)};");

    if (printSetter) {
      // set periodInMinutes(double value) => jsProxy['periodInMinutes'] = value;
      generator.writeln("set ${property.name}(${property.type} value) => "
          "${getterBody} = ${getSetterConverter(property.type, 'value')};");
    }
  }

  /**
   * Print the given [method]. If [thisOverride] is not null, use that text to
   * represent the `this` object. It wil default to the chrome. namespace
   * reference (e.g., `_app_window`).
   */
  void _printMethod(ChromeMethod method, {String thisOverride, bool checkApi: true}) {
    if (thisOverride == null) {
      thisOverride = contextReference;
    }

    generator.writeln();
    generator.writeDocs(method.getDescription());
    generator.write("${method.returns.toReturnString()} ${method.name}(");
    generator.write(method.requiredParams.map((p) => "${p.toParamString(true)} ${p.name}").join(', '));
    if (method.optionalParams.isNotEmpty) {
      if (method.requiredParams.isNotEmpty) {
        generator.write(', ');
      }
      generator.write('[');
      generator.write(method.optionalParams.map((p) => "${p.toParamString(true)} ${p.name}").join(', '));
      generator.write(']');
    }
    generator.writeln(") {");
    if (checkApi) {
      generator.writeln('if (${contextReference} == null) _throwNotAvailable();');
      generator.writeln();
    }
    if (method.usesCallback) {
      ChromeType future = method.returns;
      var returnType = future.getReturnStringTypeParams();
      generator.write("var completer = new ChromeCompleter${returnType}.");
      if (future.parameters.length == 0) {
        generator.writeln("noArgs();");
      } else if (future.parameters.length == 1 && future.parameters.first.isCombinedReturnValue) {
        ChromeType param = future.parameters.first;
        generator.writeln("twoArgs(${param.refName}._create);");
      } else if (future.parameters.length == 1) {
        ChromeType param = future.parameters.first;
        var callbackConverter = getCallbackConverter(param);
        if (callbackConverter == null) {
          generator.writeln("oneArg();");
        } else {
          generator.writeln("oneArg(${callbackConverter});");
        }
      } else {
        throw new StateError('unsupported number of params(${future.parameters.length})');
      }
    }

    StringBuffer methodCall = new StringBuffer();
    methodCall.write("${thisOverride}.callMethod('${method.name}'");
    if (method.params.length > 0 || method.usesCallback) {
      methodCall.write(", [");
      List strParams = method.params.map(getParamConverter).toList();
      if (method.usesCallback) {
        strParams.add('completer.callback');
      }
      methodCall.write("${strParams.join(', ')}]");
    }
    methodCall.write(")");

    if (method.usesCallback || method.returns.isVoid) {
      generator.writeln("${methodCall};");
    } else {
      String returnConverter = getReturnConverter(method.returns);

      if (returnConverter.contains(',')) {
        generator.writeln("var ret = ${methodCall};");
        generator.writeln("return ret;");
      } else {
        String text = returnConverter.replaceFirst('%s', methodCall.toString());
        generator.writeln("return ${text};");
      }
    }

    if (method.usesCallback) {
      generator.writeln("return completer.future;");
    }
    generator.writeln("}");
  }

  void _printEventDecl(ChromeEvent event) {
     ChromeType type = event.calculateType(library);
     String typeName = type == null ? null : type.toReturnString();

     generator.writeln();
     generator.writeDocs(event.documentation);

     if (type != null) {
       generator.writeln("Stream<${typeName}> get ${event.name} => _${event.name}.stream;");
     } else {
       generator.writeln("Stream get ${event.name} => _${event.name}.stream;");
     }
     if (type != null) {
       generator.writeln("ChromeStreamController<${typeName}> _${event.name};");
     } else {
       generator.writeln("ChromeStreamController _${event.name};");
     }
  }

  void _printEventAssign(ChromeEvent event) {
     ChromeType type = event.calculateType(library);
     String typeName = type == null ? null : type.toReturnString();

     if (type != null) {
       generator.write("_${event.name} = ");
       String converter = getCallbackConverter(type);
       if (converter == null) converter = 'selfConverter';

       String argCallArity = ['noArgs', 'oneArg', 'twoArgs', 'threeArgs'][type.arity];
       generator.writeln("new ChromeStreamController<${typeName}>.${argCallArity}("
           "getApi, '${event.name}', ${converter});");
     } else {
       generator.writeln("_${event.name} = new ChromeStreamController.noArgs("
           "getApi, '${event.name}');");
     }
  }

  void _printEventType(ChromeType type) {
    // We do class renames in a lexical basis for the entire compilation unit.
    String className = type.name; //overrides.className(library.name, type.name);

    var props = type.filteredProperties.toList();

    generator.writeln();
    generator.writeDocs(type.documentation);
    generator.writeln("class ${className} {");
    bool first = true;
    props.forEach((ChromeProperty property) {
      if (!first) generator.writeln();
      first = false;
      generator.writeDocs(property.getDescription());
      generator.writeln("final ${property.type.toReturnString()} ${property.name};");
    });
    generator.writeln();
    String params = props.map((p) => 'this.${p.name}').join(', ');
    generator.writeln("${className}(${params});");
    generator.writeln("}");
  }

  void _printEnumType(ChromeEnumType type) {
    generator.writeln();
    generator.writeDocs(type.documentation);
    generator.writeln("class ${type.name} extends ChromeEnum {");

    var constNames = new List<String>();

    type.values.forEach((ChromeEnumEntry entry) {
      generator.writeDocs(entry.documentation);

      var constName = fromCamelCase(entry.name).toUpperCase();
      constNames.add(constName);

      generator.writeln("static const ${type.name} ${constName} "
          "= const ${type.name}._('${entry.name}');");
    });

    generator.writeln();
    String str = constNames.join(', ');
    generator.writeln("static const List<${type.name}> VALUES = const[${str}];");

    generator.writeln();
    generator.writeln("const ${type.name}._(String str): super(str);");

    generator.writeln("}");
  }

  void _printDeclaredType(ChromeDeclaredType type) {
    if (overrides.suppressClass(library.name, type.name)) {
      return;
    }

    String className = type.name;
    className = overrides.overrideClass(className);

    List<ChromeProperty> props =
        type.filteredProperties.toList(growable: false);

    String superName = type.superClassDef != null ? type.superClassDef : 'ChromeObject';

    generator.writeln();
    generator.writeDocs(type.documentation);
    generator.writeln("class ${className} extends ${superName} {");
    if (props.isNotEmpty && !type.noSetters) {
      generator.write("${className}({");
      generator.write(props.map((p) => "${p.type} ${p.name}").join(', '));
      generator.writeln('}) {');
      props.forEach((ChromeProperty p) {
        generator.writeln("if (${p.name} != null) this.${p.name} = ${p.name};");
      });
      generator.writeln('}');
    } else {
      generator.writeln("${className}();");
    }
    generator.writeln("${className}.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);");

    if (library.name != 'proxy') {
      props.forEach((p) => _printPropertyRef(p, 'jsProxy', !type.noSetters));
    } else {
      props.forEach((p) => _printPropertyRef(p, 'this.jsProxy', !type.noSetters));
    }

    type.methods.forEach((m) => _printMethod(
        m, thisOverride: 'jsProxy', checkApi: false));

    generator.writeln("}");
  }

  void _printReturnType(ChromeReturnType type) {
    String className = type.name;

    String methodName =
        className.substring(0, 1).toLowerCase() + className.substring(1);
    if (methodName.endsWith('Result')) {
      methodName =   methodName.substring(0, methodName.length - 6);
    }

    generator.writeln();
    generator.writeDocs('The return type for [${methodName}].');
    generator.writeln("class ${className} {");
    generator.write("static ${className} _create(");
    generator.write(type.params.map((p) => p.name).join(', '));
    generator.writeln(") {");
    generator.write("return new ${className}._(");
    generator.write(type.params.map((ChromeType p) {
      String converter = getReturnConverter(p);
      return converter.replaceFirst('%s', p.name);
    }).join(', '));
    generator.writeln(");");
    generator.writeln("}");
    generator.writeln();
    type.params.forEach((ChromeType p) {
      generator.writeln("${p.toReturnString()} ${p.name};");
    });
    generator.writeln();
    generator.write("${className}._(");
    generator.write(type.params.map((p) => "this.${p.name}").join(', '));
    generator.writeln(");");
    generator.writeln("}");
  }

  void _writeFactory(String creator) {
    String creatorTemplate = null;

    var type = library.eventTypes.firstWhere((e) => e.name == creator, orElse: () => null);

    if (type != null) {
      Iterable<ChromeProperty> props = type.filteredProperties;

      String createParams = props.map((p) => '${getJSType(p.type)} ${p.name}').join(', ');
      generator.writeln("${creator} _create$creator(${createParams}) =>");
      String cvtParams = props.map((ChromeProperty p) {
        String cvt = getCallbackConverter(p.type);
        if (cvt == null) {
          return p.name;
        } else {
          return "${cvt}(${p.name})";
        }
      }).join(', ');
      generator.writeln("    new ${creator}(${cvtParams});");
      return;
    }

    var enumType = library.enumTypes.firstWhere((e) => e.name == creator, orElse: () => null);

    if (enumType != null) {
      creatorTemplate = "%s _create%s(String value) => %s.VALUES.singleWhere((ChromeEnum e) => e.value == value);";
    } else if (creator == 'ArrayBuffer') {
      creatorTemplate = "%s _create%s(/*JsObject*/ jsProxy) => jsProxy == null ? null : new %t.fromProxy(jsProxy);";
    } else {
      creatorTemplate = "%s _create%s(JsObject jsProxy) => jsProxy == null ? null : new %t.fromProxy(jsProxy);";
    }

    String altCreator =
        ALT_FACTORIES.containsKey(creator) ? ALT_FACTORIES[creator] : creator;

    generator.writeln(
        creatorTemplate.replaceAll('%s', creator).replaceAll('%t', altCreator));
  }

  /**
   * Return the name of the incoming JS type.
   */
  static String getJSType(ChromeType type) {
    if (type.isPrimitive) {
      return type.type;
    } else {
      return 'JsObject';
    }
  }

  String getCallbackConverter(ChromeType param) {
    if (param.isString || param.isInt || param.isBool) {
      return null;
    } else if (param.isList) {
      var firstParamCallbackConverter = getCallbackConverter(param.parameters.first);
      if (firstParamCallbackConverter == null) {
        // if the elements are identity converters
        return "listify";
      } else {
        // we need to call listify with a map() param
        return "(e) => listify(e, ${firstParamCallbackConverter})";
      }
    } else if (param.isMap) {
      return 'mapify';
    } else if (param.isReferencedType) {
      _neededFactories.add(param.refName);
      return '_create${param.refName}';
    } else {
      return null;
    }
  }

  String getReturnConverter(ChromeType param) {
    if (param.isString || param.isInt || param.isBool) {
      return '%s';
    } else if (param.isList) {
      var firstParamCallbackConverter = getCallbackConverter(param.parameters.first);
      if (firstParamCallbackConverter == null) {
        // if the elements are identity converters
        return "listify(%s)";
      } else {
        // else, call listify with a map() param
        return "listify(%s, ${firstParamCallbackConverter})";
      }
    } else if (param.isMap) {
      return 'mapify(%s)';
    } else if (param.isReferencedType) {
      _neededFactories.add(param.refName);
      return '_create${param.refName}(%s)';
    } else {
      return '%s';
    }
  }

  String getParamConverter(ChromeType param) {
    return getSetterConverter(param, param.name);
  }

  String getSetterConverter(ChromeType param, String name) {
    if (param.isMap || param.isList) {
      return "jsify(${name})";
    } else if (library.isEnumType(param)) {
      return "jsify(${name})";
    } else if (param.isPrimitive) {
      return name;
    } else {
      return "jsify(${name})";
    }
  }
}
