
/**
 * A set of model classes used to represent Chrome libraries, classes, and
 * methods.
 */
library chrome_model;

import 'src/utils.dart';

abstract class ChromeElement {
  String documentation;

  String get name;

  void appendDocs(String str) {
    if (documentation != null) {
      documentation = "${documentation}\n${str}";
    } else {
      documentation = str;
    }
  }
}

class ChromeLibrary extends ChromeElement {
  /// This is straight from the json/idl namespace name. I.e., app.window,
  /// system.display, terminalPrivate, devtools.inspectedWindow.
  final String name;

  ChromeLibrary(this.name);

  final List<ChromeProperty> properties = [];
  final List<ChromeMethod> methods = [];
  final List<ChromeEvent> events = [];
  /// Synthetic classes used to represent multi-return stream events.
  final List<ChromeType> eventTypes = [];
  final List<ChromeEnumType> enumTypes = [];
  final List<ChromeDeclaredType> types = [];
  final List<ChromeReturnType> returnTypes = [];
  final List<String> imports = [];

  bool hasDeclaredType(String name) => types.any((t) => t.name == name);

  void addImport(String str) {
    if (str != null && str != name && !imports.contains(str) && !str.startsWith('devtools')) {
      imports.add(str);
      imports.sort();
    }
  }

  void addEventType(ChromeType type) {
    if (!eventTypes.any((e) => type.name == e.name)) {
      eventTypes.add(type);
    }
  }

  Iterable<ChromeProperty> get filteredProperties => properties.where((p) => !p.nodoc);

  bool isEnumType(ChromeType refType) {
    if (!refType.isAny) return false;

    return enumTypes.any((t) => t.name == refType.refName);
  }

  String toString() => name;
}

class ChromeProperty extends ChromeElement {
  String name;
  /// This is generally always [name], except in the case where the idl name
  /// starts with an underscore.
  String idlName;

  ChromeType type;

  bool nodoc = false;

  ChromeProperty(this.name, this.type) {
    idlName = name;
    if (name.startsWith('_')) {
      name = name.substring(1);
    }
  }

  String getDescription() {
    if (documentation == null) {
      return type.documentation;
    } else if (type.documentation == null) {
      return documentation;
    } else {
      if (type.documentation.startsWith(documentation)) {
        return type.documentation;
      } else {
        return "${documentation}\n\n${type.documentation}";
      }
    }
  }

  String toString() => name;
}

class ChromeMethod extends ChromeElement {
  ChromeType returns;
  String name;
  List<ChromeType> params = [];

  bool get usesCallback => returns.isFuture;

  // We depend on all required params being defined before any optional ones.
  Iterable<ChromeType> get requiredParams => params.where((p) => !p.optional);
  Iterable<ChromeType> get optionalParams => params.where((p) => p.optional);

  String getDescription() {
    if (documentation == null) {
      return documentation;
    }

    StringBuffer buf = new StringBuffer(documentation);
    buf.write('\n');

    params.forEach((p) {
      if (p.documentation != null) {
        buf.write('\n');
        buf.write("[${p.name}] ${p.documentation}\n");
      }
    });

    if (returns.documentation != null) {
      buf.write("\nReturns:\n${returns.documentation}");
    }

    return buf.toString();
  }

  String toString() => "${name}()";
}

class ChromeEvent extends ChromeType {

  ChromeType calculateType(ChromeLibrary library) {
    if (parameters.length == 1) {
      return parameters[0];
    } else if (parameters.length > 1) {
      String typeName = /*titleCase(library.name) +*/ titleCase(name) + 'Event';

      ChromeType newType = new ChromeType(type: ChromeType.VAR.type);
      newType.name = typeName;
      newType.refName = typeName;
      newType.documentation = documentation;
      newType.properties = parameters.map((ChromeType t) {
        ChromeProperty p = new ChromeProperty(t.name, t);
        p.documentation = t.documentation;
        if (t.optional) {
          p.documentation = _appendDocs(p.documentation, '`optional`');
        }
        return p;
      }).toList();
      newType.arity = parameters.length;

      library.addEventType(newType);

      return newType;
    } else {
      return null;
    }
  }

  String toString() => name;
}

class ChromeDeclaredType extends ChromeType {
  /// For a class like 'declarativeWebRequest.EditRequestCookie', this
  /// represents the 'declarativeWebRequest' part.
  String qualifier;
  String superClassDef;
  bool noSetters = false;
  List<ChromeMethod> methods = [];

  String toString() => name;
}

/**
 * This class is used to represent a multiple value return from a method.
 */
class ChromeReturnType {
  final String name;
  final List<ChromeType> params;

  ChromeReturnType(this.name, this.params);

  String toString() => name;
}

class ChromeEnumType extends ChromeType {
  /// The list of values entries for enum types.
  List<ChromeEnumEntry> values = [];

  String toString() => name;
}

class ChromeEnumEntry extends ChromeElement {
  String name;

  ChromeEnumEntry([this.name, String documentation]) {
    this.documentation = documentation;
  }

  String toString() => name;
}

class ChromeType extends ChromeElement {
  static final ChromeType VAR = new ChromeType(type: 'var');
  static final ChromeType VOID = new ChromeType(type: 'void');
  static final ChromeType JS_OBJECT = new ChromeType(type: 'JsObject');
  static final ChromeType STRING = new ChromeType(type: 'String');

  String name;
  String type;
  String refName;
  bool optional;
  // TODO(adam): why have a getter for this value if its public?
  // merge with isCombinedReturnValue
  bool combinedReturnValue = false;

  /// Only used when this type represents a stream event type. This is the
  /// number of JS callback parameters.
  int arity = 1;
  List<ChromeType> parameters = [];
  List<ChromeProperty> properties = [];
  List<String> enumOptions;

  ChromeType({this.type, this.refName});

  bool get isAny => type == 'var';
  bool get isReferencedType => isAny && refName != null;
  bool get isVoid => type == 'void';
  bool get isFuture => type == 'Future';
  /// This is used to return two or more values from a function.
  bool get isCombinedReturnValue => combinedReturnValue;
  bool get isList => type == 'List';
  bool get isMap => type == 'Map';
  bool get isString => type == 'String';
  bool get isInt => type == 'int';
  bool get isBool => type == 'bool';
  bool get isPrimitive => isString || isBool || isInt;
  bool get hasEnums => enumOptions != null;

  Iterable<ChromeProperty> get filteredProperties => properties.where((p) => !p.nodoc);

  String toParamString([bool useDynamic = false]) {
    if (isAny && !isReferencedType) {
      return useDynamic ? 'dynamic' : type;
    } else if (parameters.isEmpty) {
      return refName != null ? refName : type;
    } else {
      return "${type}<${parameters.map((t) => t.toParamString(true)).join(', ')}>";
    }
  }

  String toReturnString() {
    if (isReferencedType) {
      return refName;
    } else if (isAny) {
      return 'dynamic';
    } else {
      return type + getReturnStringTypeParams();
    }
  }

  String getReturnStringTypeParams() {
    if (parameters.isEmpty) return '';
    return "<${parameters.map((t) => t.toReturnString()).join(', ')}>";
  }

  String toString() => toParamString();
}

String _appendDocs(String docs, String append) {
  if (docs == null) {
    return append;
  }

  return "${docs}\n${append}";
}
