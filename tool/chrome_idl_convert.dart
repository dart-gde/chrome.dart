library chrome_idl_convert;

import "chrome_idl_model.dart";
import 'chrome_model.dart';
import 'src/utils.dart';

// TODO: style nit, use .. notation more.

/**
 * Convert [IDLNamespaceDeclaration] -> [ChromeLibrary]
 */
ChromeLibrary convert(IDLNamespaceDeclaration namespace) =>
    new IDLConverter().convert(namespace);

class IDLConverter {
  IDLNamespaceDeclaration namespace;
  ChromeLibrary library;

  ChromeLibrary convert(IDLNamespaceDeclaration namespace) {
    this.namespace = namespace;

    library = new ChromeLibrary(namespace.name);

    library.documentation =
        _cleanDocComments(namespace.documentation.join('\n'));

    if (namespace.typeDeclarations != null) {
      library.types.addAll(
          namespace.typeDeclarations.map(_convertTypeDeclaration));
    }

    if (namespace.functionDeclaration != null) {
      library.methods.addAll(
          namespace.functionDeclaration.methods.map(_convertMethod));
    }

    if (namespace.eventDeclaration != null) {
      library.events.addAll(
          namespace.eventDeclaration.methods.map(_convertEvent));
    }

    if (namespace.enumDeclarations != null) {
      library.enumTypes.addAll(
          namespace.enumDeclarations.map(_convertEnum));
    }

    return library;
  }


  ChromeDeclaredType _convertTypeDeclaration(IDLTypeDeclaration typeDeclaration) {
    ChromeDeclaredType chromeDeclaredType = new ChromeDeclaredType();

    chromeDeclaredType.name = typeDeclaration.name;
    chromeDeclaredType.documentation =
        _cleanDocComments(typeDeclaration.documentation.join('\n'));
    chromeDeclaredType.properties =
        typeDeclaration.members.map(_convertProperty).toList();
    chromeDeclaredType.methods =
        typeDeclaration.methods.map(_convertMethod).toList();

    int index = chromeDeclaredType.name.lastIndexOf('.');

    if (index != -1) {
      chromeDeclaredType.qualifier = chromeDeclaredType.name.substring(0, index);
      chromeDeclaredType.name = chromeDeclaredType.name.substring(index + 1);
    }

    return chromeDeclaredType;
  }

  ChromeProperty _convertProperty(IDLField member) {
    ChromeProperty property = new ChromeProperty(member.name,
        _convertType(member.type));
    return property;
  }

  ChromeMethod _convertMethod(IDLMethod idlMethod) {
    ChromeMethod chromeMethod = new ChromeMethod();
    chromeMethod.name = idlMethod.name;
    chromeMethod.documentation =
        _cleanDocComments(idlMethod.documentation.join('\n'));
    chromeMethod.returns = _convertType(idlMethod.returnType);
    chromeMethod.params = idlMethod.parameters.map(_convertParameter).toList();

    if (!idlMethod.parameters.isEmpty &&
        idlMethod.parameters.last.isCallback) {
      ChromeType chromeType = chromeMethod.params.removeLast();
      chromeMethod.returns = _convertToFuture(chromeMethod, chromeType);
    } else {
      if (chromeMethod.returns == null) {
        chromeMethod.returns = ChromeType.VOID;
      }
    }


    return chromeMethod;
  }

  ChromeType _convertToFuture(ChromeMethod method, ChromeType chromeType) {
    ChromeType future = new ChromeType();
    future.type = "Future";

    List<ChromeType> params = chromeType.parameters;

    IDLCallbackDeclaration callback = namespace.callbackDeclarations.firstWhere(
        (c) => c.name == chromeType.refName, orElse: () => null);

    if (callback != null) {
      params = callback.parameters.map(_convertParameter).toList();
    }

    if (params.length == 1) {
      future.parameters.add(params.first);
      future.documentation = _cleanDocComments(callback.documentation.join('\n'));
    } else if (params.length == 2) {
      ChromeType type = new ChromeType(type: 'var',
          refName: "${titleCase(method.name)}Result");

      type.combinedReturnValue = true;
      type.parameters.addAll(params);

      library.returnTypes.add(new ChromeReturnType(type.refName, params));

      future.parameters.add(type);
      future.documentation =
          params.map((p) => "[${p.name}] ${p.documentation}").join('\n');
    } else if (params.length > 2) {
      throw new UnsupportedError(
          "unable to convert ${params.length} return values into a single return");
    }

    return future;
  }

  ChromeEvent _convertEvent(IDLMethod idlMethod) {
    ChromeEvent chromeEvent = new ChromeEvent();
    chromeEvent.name = idlMethod.name;
    chromeEvent.type = ChromeType.VAR.type;
    chromeEvent.parameters =
        idlMethod.parameters.map(_convertParameter).toList();
    return chromeEvent;
  }

  ChromeType _convertParameter(IDLParameter parameter) {
    ChromeType param;

    if (parameter.type.isArray) {
      var idlType = parameter.type;
      ChromeType elementType = new ChromeType(type: idlToDartType(idlType),
          refName: idlToDartRefName(idlType));
      param = new ChromeType(type: "List");
      param.parameters.add(elementType);
      param.name = parameter.name;
    } else {
      param = new ChromeType(type: idlToDartType(parameter.type),
          refName: idlToDartRefName(parameter.type));
      param.name = parameter.name;
    }

    library.addImport(getImportForClass(param.refName));
    param.optional = parameter.isOptional;
    return param;
  }

  ChromeEnumType _convertEnum(IDLEnumDeclaration idlEnumDeclaration) {
    ChromeEnumType chromeEnumType = new ChromeEnumType();
    chromeEnumType.name = idlEnumDeclaration.name;
    chromeEnumType.documentation =
        _cleanDocComments(idlEnumDeclaration.documentation.join('\n'));
    idlEnumDeclaration.enums.forEach((IDLEnumValue value) {
      ChromeEnumEntry chromeEnumEntry = new ChromeEnumEntry();
      chromeEnumEntry.name = value.name;
      // This fixes an odd value for the chrome.Recipient._INTERFACE enum (#124).
      if (chromeEnumEntry.name == '_interface') {
        chromeEnumEntry.name = 'interface';
      }
      chromeEnumType.values.add(chromeEnumEntry);
    });
    return chromeEnumType;
  }

  ChromeType _convertType(IDLType idlType) {
    if (idlType == null) {
      return null;
    } else if (idlType.name == "void") {
      return ChromeType.VOID;
    } else if (idlType.isArray) {
      ChromeType chromeType = new ChromeType(type: "List");
      ChromeType elementType = new ChromeType(type: idlToDartType(idlType),
          refName: idlToDartRefName(idlType));
      chromeType.parameters.add(elementType);
      library.addImport(getImportForClass(chromeType.refName));
      return chromeType;
    } else {
      ChromeType chromeType = new ChromeType();
      chromeType.type = idlToDartType(idlType);
      chromeType.refName = idlToDartRefName(idlType);
      library.addImport(getImportForClass(chromeType.refName));
      return chromeType;
    }
  }

  final TYPE_MAP = {
                    'DOMString': 'String',
                    'boolean': 'bool',
                    'double': 'num',
                    'long': 'int'
  };

  String idlToDartType(IDLType type) {
    if (TYPE_MAP.containsKey(type.name)) {
      return TYPE_MAP[type.name];
    } else {
      // NOTE:
      return 'var';
    }
  }

  String idlToDartRefName(IDLType type) {
    if (TYPE_MAP.containsKey(type.name)) {
      return null;
    } else if (type.name == 'object') {
      return null;
    } else {
      return type.name;
    }
  }

  String _cleanDocComments(String str) {
    if (str == null) {
      return null;
    }

    str = str.trim();

    if (str.isEmpty) {
      return null;
    }

    str = str.replaceAll('\n ', ' ');
    str = str.replaceAll(new RegExp('\n+'), '\n\n');
    str = str.replaceAll(new RegExp('(\n )+'), '\n');

    str = str.replaceAll('<br>', '\n\n');

    // |foo| ==> [foo]
    str = str.replaceAllMapped(
        new RegExp(r"\|([\.\w]*)\|\s*:"),
        (Match m) => "\n[${m.group(1)}]:");
    str = str.replaceAll(new RegExp('\n\s?(\n\s?)+'), '\n\n');

    // |width|x|height| ==> [width]x[height]
    str = str.replaceAllMapped(
        new RegExp(r"\|(\w+)\|"),
        (Match m) => "[${m.group(1)}]");

    // $ref:runtime.onConnect ==> [runtime.onConnect]
    str = str.replaceAllMapped(
        new RegExp(r"\$ref:([\.\w]*\w)"),
        (Match m) => "[${m.group(1)}]");

    str = str.replaceAll('<code>', '`');
    str = str.replaceAll('</code>', '`');

    str = str.replaceAll('<em>', '_');
    str = str.replaceAll('</em>', '_');

    str = str.replaceAll('<strong>', '*');
    str = str.replaceAll('</strong>', '*');

    str = str.replaceAll('<var>', '[');
    str = str.replaceAll('</var>', ']');

    str = str.replaceAll('&mdash;', '-');

    // convert whitespace newline ==> newline
    str = str.replaceAll(new RegExp(' \n'), '\n');
    str = str.replaceAll(new RegExp('  +'), ' ');

    str = str.replaceAll('TODO(', 'todo(');

    return str.replaceAll('/*', '/');
  }
}
