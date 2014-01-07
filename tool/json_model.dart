
library model_json;

import 'chrome_model.dart';
import 'src/utils.dart';

abstract class JsonObject {
  final Map<String, dynamic> json;

  JsonObject(this.json);

  String get description => json['description'];

  bool _bool(String key) => json[key] == true || json[key] == 'true';
}

class JsonNamespace extends JsonObject {
  final List<JsonProperty> properties;
  final List<JsonFunction> functions;
  final List<JsonEvent> events;
  final List<JsonDeclaredType> types;

  JsonNamespace(json) :
    properties = JsonProperty.parse(json['properties']),
    functions = JsonFunction.parse(json['functions']),
    events = JsonEvent.parse(json['events']),
    types = JsonDeclaredType.parse(json['types']),
    super(json);

  String get namespace => json['namespace'];

  String toString() => "${runtimeType.toString()} ${namespace}";
}

class JsonProperty extends JsonObject {
  final String name;
  final JsonReturnType type;

  static List<JsonProperty> parse(Map m) {
    // TODO: add support for 'choices'. Example browserAction.setIcon has
    // parameters that could be multiple types.
    List<JsonProperty> properties = [];

    if (m != null) {
      for (String key in m.keys) {
        properties.add(new JsonProperty(key, new JsonReturnType(m[key])));
      }
    }

    return properties;
  }

  JsonProperty(this.name, this.type): super(null);

  String get description => type.description;
  bool get nodoc => type.nodoc;

  /// Returns whether this property itself defines properties.
  bool get isComplexProperty => type.properties.isNotEmpty;

  String getComplexClassName(String libName) {
    if (type.ref == null) {
      return '${titleCase(name)}${titleCase(libName)}';
    } else {
      return '${titleCase(name)}${type.ref}';
    }
  }

  String toString() => "${runtimeType.toString()} ${name}";
}

class JsonFunction extends JsonObject {
  final List<JsonParamType> parameters;
  final JsonReturnType returns;

  static List<JsonFunction> parse(List jsons) {
    return (jsons == null ? [] : jsons.map((j) => new JsonFunction(j)).toList());
  }

  JsonFunction(json) :
    parameters = JsonParamType.parse(json['parameters']),
    returns = json.containsKey('returns') ?
        new JsonReturnType(json['returns']) : null,
    super(json);

  String get name => json['name'];
  String get type => json['type'];
  bool get nocompile => _bool('nocompile');

  String toString() => "${runtimeType.toString()} ${name}()";
}

class JsonType extends JsonObject {
  final List<JsonParamType> parameters;
  final List<JsonProperty> properties;

  JsonType(json):
    this.parameters = JsonParamType.parse(json['parameters']),
    this.properties = JsonProperty.parse(json['properties']),
    super(json) {

    if (parameters.isEmpty && json.containsKey('items')) {
      parameters.add(new JsonType(json['items']));
    }
  }

  String get name => null;

  String get type => json['type'];
  String get ref => json[r'$ref'];
  String get isInstanceOf => json['isInstanceOf'];
  List<String> get enumOptions => json['enum'];
  bool get optional => _bool('optional');
  bool get nocompile => _bool('nocompile');
  bool get nodoc => _bool('nodoc');
  bool get isCallback => type == 'function' && (name == 'callback' || name == 'responseCallback');

  String toString() => "${runtimeType.toString()} ${type} (${ref})";
}

class JsonParamType extends JsonType {

  static List<JsonType> parse(List jsons) {
    return (jsons == null ? [] : jsons.map((j) => new JsonParamType(j)).toList());
  }

  JsonParamType(json): super(json);

  String get name => json['name'];

  // rare ones
  int get maxLength => json['maxLength'];
  dynamic get value => json['value'];

  String toString() => "${runtimeType.toString()} ${name}";
}

class JsonReturnType extends JsonParamType {

  JsonReturnType(json): super(json);
}

class JsonEvent extends JsonParamType {

  static List<JsonEvent> parse(List jsons) {
    return (jsons == null ? [] : jsons.map((j) => new JsonEvent(j)).toList());
  }

  JsonEvent(json): super(json);
}

class JsonDeclaredType extends JsonType {
  final List<JsonFunction> functions;

  static List<JsonDeclaredType> parse(List jsons) {
    return (jsons == null ? [] : jsons.map((j) => new JsonDeclaredType(j)).toList());
  }

  JsonDeclaredType(Map<String, dynamic> json) :
      this.functions = JsonFunction.parse(json['functions']),
      super(json);

  String get id => json['id'];

  String get name => id;

  String toString() => "${runtimeType.toString()} ${id}";
}

ChromeLibrary convert(JsonNamespace namespace) {
  return JsonConverter.convert(namespace);
}

class JsonConverter {
  final ChromeLibrary library;
  final List<JsonDeclaredType> addtionalDeclaredTypes = <JsonDeclaredType>[];

  static ChromeLibrary convert(JsonNamespace namespace) {
    var library = new ChromeLibrary(namespace.namespace);
    var converter = new JsonConverter._(library);

    return converter._convert(namespace);
  }

  JsonConverter._(this.library);

  ChromeLibrary _convert(JsonNamespace namespace) {
    library.documentation = convertHtmlToDartdoc(namespace.description);

    library.methods.addAll(namespace.functions.map(_convertMethod));
    library.properties.addAll(namespace.properties.map((p) => _convertProperty(p, true)));
    library.types.addAll(namespace.types.map(_convertDeclaredType));
    library.types.addAll(addtionalDeclaredTypes.map(_convertDeclaredType));
    library.events.addAll(namespace.events.map(_convertEvent));

    return library;
  }

  ChromeProperty _convertProperty(JsonProperty p, [bool onlyReturnType = false]) {
    ChromeProperty property = new ChromeProperty(p.name, _convertType(p.type));

    property.documentation = convertHtmlToDartdoc(p.description);
    property.nodoc = p.nodoc;

    if (p.isComplexProperty) {
      String className = p.getComplexClassName(toCamelCase(library.name));

      // define a new ChromeDeclaredType
      if (!library.hasDeclaredType(className)) {
        ChromeDeclaredType newType = new ChromeDeclaredType();
        newType.name = className;
        newType.noSetters = onlyReturnType;
        if (p.type.ref != null) {
          newType.superClassDef = p.type.ref;
        }
        newType.properties = property.type.properties;

        library.types.add(newType);
      }

      // replace the type w/ a ref to the new type
      property.type = new ChromeType(type: 'var', refName: className);
    }

    return property;
  }

  ChromeMethod _convertMethod(JsonFunction f) {
    ChromeMethod method = new ChromeMethod();

    method.name = f.name;
    method.documentation = convertHtmlToDartdoc(f.description);
    method.returns = _convertType(f.returns);
    method.params = f.parameters.map(
      (JsonParamType param) => _convertType(param, f)).toList();

    if (method.returns == null) {
      if (!f.parameters.isEmpty && f.parameters.last.isCallback) {
        ChromeType type = method.params.removeLast();

        method.returns = _convertToFuture(method, type);
      } else {
        method.returns = ChromeType.VOID;
      }
    } else if (!f.parameters.isEmpty && f.parameters.last.isCallback) {
      // TODO: there are 3 cases in the APIs where the return type is non-empty,
      // but the method returns it's value using a callback.

    }

    return method;
  }

  ChromeDeclaredType _convertDeclaredType(JsonDeclaredType t) {
    ChromeDeclaredType type = _convertType_(t, new ChromeDeclaredType());

    type.methods =  t.functions.map(_convertMethod).toList();

    int index = type.name.lastIndexOf('.');

    if (index != -1) {
      type.qualifier = type.name.substring(0, index);
      type.name = type.name.substring(index + 1);
    }

    return type;
  }

  ChromeEvent _convertEvent(JsonEvent e) {
    return _convertType_(e, new ChromeEvent());
  }

  ChromeType _convertType(JsonType t, [JsonFunction function]) {
    if (t == null) {
      return null;
    } else {
      return _convertType_(t, new ChromeType(), function);
    }
  }

  ChromeType _convertToFuture(ChromeMethod method, ChromeType chromeType) {
    ChromeType future = new ChromeType();
    future.type = "Future";

    List<ChromeType> params = chromeType.parameters;

    if (params.length == 1) {
      future.parameters.add(params.first);
      future.documentation = params.first.documentation;
    } else if (params.length == 2) {
      ChromeType type = new ChromeType(
          type: 'var', refName: "${titleCase(method.name)}Result");
      type.combinedReturnValue = true;
      type.parameters.addAll(params);

      library.returnTypes.add(new ChromeReturnType(type.refName, params));

      future.parameters.add(type);
      future.documentation = params.map(
          (p) => "[${p.name}] ${p.documentation}").join('\n');
    } else if (params.length > 2) {
      throw new UnsupportedError(
          "unable to convert ${params.length} return values into a single return");
    }

    return future;
  }

  ChromeType _convertType_(JsonType t, ChromeType type, [JsonFunction function]) {
    type.name = t.name;
    type.documentation = convertHtmlToDartdoc(t.description);

    if (t.type == 'string') {
      type.type = "String";
    } else if (t.type == 'integer') {
      type.type = "int";
    } else if (t.type == 'boolean') {
      type.type = "bool";
    } else if (_isImplicitInt(t)) {
      type.type = 'int';
    } else if (t.type == 'array') {
      // {type: array, items: {type: string}
      type.type = 'List';
    } else if (t.type == 'object' && t.isInstanceOf == null) {
      type.type = "Map";
      Map<String, dynamic> additionalProps = t.json['additionalProperties'];
      if (additionalProps != null && additionalProps['type'] == 'any') {
        assert(t.parameters.isEmpty);
        type.parameters = [ChromeType.STRING, ChromeType.VAR];
      } else if (function != null) {

        String name = "${titleCase(toCamelCase(library.name))}"
                      "${titleCase(function.name)}Params";

        JsonDeclaredType declaredType = new JsonDeclaredType({
          'id': name
        });

        type.type = declaredType.id;
        declaredType.properties.addAll(t.properties);
        addtionalDeclaredTypes.add(declaredType);

      }

//      // create documentation from the type's properties
//      if (t.properties.isNotEmpty) {
//        String propertyDocs = t.properties.map((p) {
//          if (p.description != null) {
//            return "`${p.name}` ${convertHtmlToDartdoc(p.description)}";
//          } else {
//            return "`${p.name}`";
//          }
//        }).join("\n\n");
//
//        if (type.documentation != null) {
//          type.documentation = "${type.documentation}\n\n${propertyDocs}";
//        } else {
//          type.documentation = propertyDocs;
//        }
//      }

    } else if (t.type == 'object' && t.isInstanceOf != null) {
      type.type = "var";
      type.refName = t.isInstanceOf;
      library.addImport(getImportForClass(type.refName));
    } else if (t.ref != null) {
      type.type = "var";

      Pair<String, String> names = parseQualifiedName(t.ref);

      if (names.first != null) {
        library.addImport(names.first);
      }

      type.refName = names.last;
    } else {
      type.type = "var";
    }

    type.optional = t.optional;

    if (t.parameters.isNotEmpty) {
      type.parameters = t.parameters.map(_convertType).toList();
    }
    type.properties = t.properties.map(_convertProperty).toList();
    type.enumOptions = t.enumOptions;

    if (type.hasEnums) {
      String enumStr = type.enumOptions.map((e) => "`${e}`").join(', ');
      type.appendDocs("enum of ${enumStr}");
    }

    return type;
  }
}

bool _isImplicitInt(JsonType t) {
  if (t is JsonParamType) {
    return _isInt(t.value) || _isInt(t.maxLength);
  } else {
    return false;
  }
}

bool _isInt(var val) {
  if (val is num) {
    num n = val as num;

    if (val.toInt().toDouble() == val.toDouble()) {
      return true;
    }
  }

  return false;
}

Pair<String, String> parseQualifiedName(String str) {
  int index = str.lastIndexOf('.');

  if (index != -1) {
    // devtools.inspectedWindow.Resource
    String qualifier = str.substring(0, index);
    String name = str.substring(index + 1);

    return new Pair(qualifier, name);
  } else {
    return new Pair(null, str);
  }
}
