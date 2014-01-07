library chrome_idl_parser;

import 'package:parsers/parsers.dart';

import 'chrome_idl_mapping.dart';

final reservedNames = ["enum", "callback", "optional", "object", "static",
                       "dictionary", "interface", "namespace"];

class ChromeIDLParser extends LanguageParsers {
  ChromeIDLParser() : super(reservedNames: reservedNames,
                      /**
                       * Dont handle comments, instead let the parser
                       * hande them with [docString]
                       */
                      commentStart: "",
                      commentEnd: "",
                      commentLine: "");

  Parser get namespaceIdentifier => identifier.sepBy(dot) | identifier;
  /**
   * Parse the namespace.
   */
  Parser get namespaceDeclaration =>
      copyrightSignature.maybe
      + docString
      + attributeDeclaration.maybe
      + reserved["namespace"]
      + namespaceIdentifier
      + braces(namespaceBody)
      + semi
      ^ idlNamespaceDeclarationMapping;

  /**
   * The body of the namespace. This could include function, type, event,
   * callback and enum declarations.
   */
  Parser get namespaceBody => _namespaceBody.many;

  Parser get _namespaceBody => functionDeclaration
                               | typeDeclaration
                               | eventDeclaration
                               | callbackDeclaration
                               | enumDeclaration;

  /**
   * Parse the interface Functions.
   */
  Parser get functionDeclaration =>
      (docString
      + attributeDeclaration.maybe
      + reserved["interface"]
      + symbol("Functions")
      + braces(methods)
      + semi ^ idlFunctionDeclarationMapping);

  Parser get methods => _methods.many;

  // TODO: merge _methods with _typeBody implementation
  Parser get _methods =>
      (docString
      + attributeDeclaration.maybe
      + reserved["static"]
      + fieldType
      + identifier
      + parens(fieldMethodParameters.sepBy(comma))
      + semi
      ^ idlMethodParameterMapping);

  /**
   * Parse the interface Events.
   */
  Parser get eventDeclaration =>
      (docString
      + attributeDeclaration.maybe
      + reserved["interface"]
      + symbol("Events")
      + braces(methods)
      + semi ^ idlEventDeclarationMapping);

  /**
   * Parse the dictionary definitions.
   */
  // Note: Also need to parse methods within a type declaration.
  // This happens in IDL such as app_window.idl.
  // What we should do is in the mapping method
  // check the runtime type and put seperate them
  // between methods and members.
  Parser get typeDeclaration =>
      docString
      + attributeDeclaration.maybe
      + reserved["dictionary"]
      + identifier
      + braces(typeBody)
      + semi ^ idlTypeDeclarationMapping;

  Parser get typeBody => _typeBody.many;

  Parser get _typeBody =>
      // [instanceOf=FileEntry] object entry;
      (docString + attributeDeclaration + reserved["object"] + identifier + semi
          ^ idlFieldAttributeBasedTypeMapping)
      |
      // LaunchItem[]? items; or DOMString type;
      (docString + attributeDeclaration.maybe + fieldType + symbol('?').maybe + identifier + semi
          ^ idlFieldBasedTypeMapping)
      |
      // static void resizeTo(long width, long height);
      // [nocompile] static Bounds getBounds();
      // Return type IDLMethod
      (docString
          + attributeDeclaration.maybe
          + reserved["static"]
          + fieldType
          + identifier
          + parens(fieldMethodParameters.sepBy(comma))
          + semi
          ^ idlMethodParameterMapping);

  Parser get fieldMethodParameters =>
      // [instanceOf=Entry] object entry
      (attributeDeclaration + reserved["object"] + identifier
        ^ (attribute, _, name) =>
            idlParameterAttributeBasedTypeMapping(name, attribute))
        |
        // GetResourcesCallback callback
        // TODO: we could use this to resolve the callback later on
        // via symbol table if needed.
        (fieldType + reserved["callback"] ^ (type, name) =>
            idlParameterMapping(name, type, false, true))
        |
        // optional ResultCallback callback
        (reserved["optional"] + fieldType + reserved["callback"]
            ^ (_, type, name) => idlParameterMapping(name, type, true, true))
        |
        // optional DOMString responseUrl
        (reserved["optional"] + fieldType + identifier
            ^ (_, type, name) => idlParameterMapping(name, type, true, false))
        |
        // DOMString responseUrl or DOMString[] urls
        (fieldType + identifier ^ (type, name) =>
            idlParameterMapping(name, type, false, false));

  // TODO: refactor with callbackParameterType
  Parser get fieldType =>
      // Device[]
      (identifier + symbol('[') + symbol(']') ^ (name, __, ___) =>
          idlTypeMapping(name, true))
      |
      //static void getFileStatuses(object[] fileEntries,
      //                            GetFileStatusesCallback callback);
      (reserved["object"] + symbol('[') + symbol(']') ^ (name, __, ___) =>
          idlTypeMapping(name, true))
      |
      // Device
      (identifier ^ (name) => idlTypeMapping(name, false))
      |
      // object
      (reserved["object"] ^ (name) => idlTypeMapping(name, false));

  /**
   * Parse a callback definition.
   */
  Parser get callbackDeclaration =>
      docString
      + reserved["callback"]
      + identifier
      + symbol("=")
      + callbackMethod
      + semi ^ idlCallbackDeclarationMapping;

  Parser get callbackMethod =>
      // TODO: rename callbackParameters to callbackParameter?
      // NOTE: we used void as a symbol instead of a reserved keyword
      // for shortcut on other parsers. Proper parser should reserve
      // "void".
      // void (StorageUnitInfo[] info)
      symbol("void") + parens(callbackParameters.sepBy(comma))
      ^ (_, parameters) => parameters;

  Parser get callbackParameters =>
      // [instanceOf=Entry] object entry
      (attributeDeclaration + reserved["object"] + identifier
          ^ (attribute, __, name) =>
              idlParameterAttributeBasedTypeMapping(name, attribute))
      |
      (attributeDeclaration
      + reserved["optional"]
      + callbackParameterType
      + identifier
      ^ idlOptionalParameterAttributeRemapTypeMapping)
      |
      // optional DOMString responseUrl
      (reserved["optional"] + callbackParameterType + identifier
          ^ (_, type, name) => idlParameterMapping(name, type, true, false))
      |
      //  Device device or Device[] result
      (callbackParameterType + identifier
          ^ (type, name) => idlParameterMapping(name, type, false, false));

  Parser get callbackParameterType =>
      // Device[]
      (identifier + symbol('[') + symbol(']') ^ (name, __, ___) =>
          idlTypeMapping(name, true))
      |
      //static void getFileStatuses(object[] fileEntries,
      //                            GetFileStatusesCallback callback);
      (reserved["object"] + symbol('[') + symbol(']') ^ (name, __, ___) =>
          idlTypeMapping(name, true))
      |
      // Device
      (identifier ^ (name) => idlTypeMapping(name, false))
      |
      // object
      (reserved["object"] ^ (name) => idlTypeMapping(name, false));

  /**
   * Parse the enum declarations.
   */
  Parser get enumDeclaration =>
      docString
      + attributeDeclaration.maybe
      + reserved["enum"]
      + identifier
      + braces(enumBody.sepBy(comma))
      + semi
      ^ idlEnumDeclarationMapping;

  /**
   * Parse the enum values.
   */
  Parser get enumBody =>
      docString + identifier ^ idlEnumValueMapping;

  /**
   * Parse the attribute declaration.
   */
  Parser get attributeDeclaration =>
      brackets(attribute.sepBy(comma)) ^ idlAttributeDeclarationMapping;

  /**
   * Parse the attribute.
   */
  Parser get attribute =>
      // Attribute where name=value
      (identifier + symbol('=') + identifier
      ^ idlAttributeAssignedValueMapping)
      // Attribute where [maxListeners=1]
      | (identifier + symbol('=') + natural
      ^ (name, _, number) =>
          idlAttributeAssignedValueMapping(name, _, number.toString()))
      // Attribute where [name=(1,2)]
      | (identifier + symbol('=') + parens(intLiteral.sepBy(comma))
      ^ idlAttributeAssignedMultiValueMapping)
      // Attribute where [name]
      | (identifier ^ idlAttributeMapping);

  /**
   * Parser all documentation strings and spaces between.
   */
  Parser get docString => lexeme(_docString).many;
  Parser get _docString =>
        everythingBetween(string('//'), string('\n'))
      | everythingBetween(string('/**'), string('*/'))
      | everythingBetween(string('/*'), string('*/'));

  /**
   * Parse the copyright signature at the top of all idl files.
   */
  Parser get copyrightSignature =>
        everythingBetween(string('// Copyright'), string('LICENSE file.\n\n'))
      | everythingBetween(string('// Copyright'), string('LICENSE file.\n'));
}
