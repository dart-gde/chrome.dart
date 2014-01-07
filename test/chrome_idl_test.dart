library chrome_idl_test;

import 'package:unittest/unittest.dart';

import '../tool/chrome_idl_parser.dart';
import '../tool/chrome_idl_model.dart';

ChromeIDLParser chromeIDLParser;

void main() {
  setUp(() {
    chromeIDLParser = new ChromeIDLParser();
  });

  group('ChromeIDLParser.docString.parse', chromeIDLParserDocStringTests);
  group('ChromeIDLParser.attributeDeclaration.parse',
      chromeIDLParserAttributeDeclarationTests);
  group('ChromeIDLParser.enumBody.parse', chromeIDLParserEnumBodyTests);
  group('ChromeIDLParser.enumDeclaration.parse',
      chromeIDLParserEnumDeclarationTests);
  group('ChromeIDLParser.callbackParameterType.parse',
      chromeIDLParserCallbackParameterTypeTests);
  group('ChromeIDLParser.callbackParameters.parse',
      chromeIDLParserCallbackParameterTests);
  group('ChromeIDLParser.callbackMethod.parse',
        chromeIDLParserCallbackMethodTests);
  group('ChromeIDLParser.callbackDeclaration.parse',
        chromeIDLParserCallbackDeclarationTests);
  group('ChromeIDLParser.fieldType.parse',
        chromeIDLParserFieldTypeTests);
  group('ChromeIDLParser.fieldMethodParameters.parse',
        chromeIDLParserFieldMethodParametersTests);
  group('ChromeIDLParser.typeBody.parse',
        chromeIDLParserTypeBodyTests);
  group('ChromeIDLParser.typeDeclaration.parse',
        chromeIDLParserTypeDeclarationTests);
  group('ChromeIDLParser.methods.parser', chromeIDLParserMethodsTests);
  group('ChromeIDLParser.functionDeclaration.parser',
      chromeIDLParserFunctionDeclarationTests);
  group('ChromeIDLParser.eventDeclaration.parser',
      chromeIDLParserEventDeclarationTests);
  group('ChromeIDLParser.namespaceDeclaration.parser',
      chromeIDLParserNamespaceDeclarationTests);

  group('ChromeIDLParser misc parsing tests', miscParsingTests);
}

void chromeIDLParserDocStringTests() {
  test('comment with **', () {

    var doc = chromeIDLParser.docString.parse("/** Some comment */");
    expect(doc.runtimeType.toString(), equals("List"));
    expect(doc.length, equals(1));
    expect(doc[0], equals(" Some comment "));
  });

  test('comment with ** multiline', () {

    var doc = chromeIDLParser.docString.parse("""
/**
 * Some comment
 *
 * Some comment information.
 * Some more comment information.
 *
 */""");
    expect(doc.runtimeType.toString(), equals("List"));
    expect(doc.length, equals(1));
    expect(doc[0], equals(
        '\n'
        ' * Some comment\n'
        ' *\n'
        ' * Some comment information.\n'
        ' * Some more comment information.\n'
        ' *\n'
        ' '));
  });

  test('comment with *', () {

    var doc = chromeIDLParser.docString.parse("/* Some comment */");
    expect(doc.runtimeType.toString(), equals("List"));
    expect(doc.length, equals(1));
    expect(doc[0], equals(" Some comment "));
  });

  test('comment with * multiline', () {

    var doc = chromeIDLParser.docString.parse("""
/*
 * Some comment
 *
 * Some comment information.
 * Some more comment information.
 *
 */""");
    expect(doc.runtimeType.toString(), equals("List"));
    expect(doc.length, equals(1));
    expect(doc[0], equals(
        '\n'
        ' * Some comment\n'
        ' *\n'
        ' * Some comment information.\n'
        ' * Some more comment information.\n'
        ' *\n'
        ' '));
  });

  test('comment with //', () {

    var doc = chromeIDLParser.docString.parse("// Some comment\n");
    expect(doc.runtimeType.toString(), equals("List"));
    expect(doc.length, equals(1));
    expect(doc[0], equals(" Some comment"));
  });

  test('comment with // multiline', () {

    var doc = chromeIDLParser.docString.parse("""
//
// Some comment
//
// Some comment information.
// Some more comment information.
//
//""");
    expect(doc.runtimeType.toString(), equals("List"));
    expect(doc.length, equals(6));
    expect(doc[0], equals(''));
    expect(doc[1], equals(' Some comment'));
    expect(doc[2], equals(''));
    expect(doc[3], equals(' Some comment information.'));
    expect(doc[4], equals(' Some more comment information.'));
    expect(doc[5], equals(''));
  });
}

void chromeIDLParserAttributeDeclarationTests() {
  test('attribute with [instanceOf=Window]', () {

    IDLAttributeDeclaration attributeDeclaration =
        chromeIDLParser.attributeDeclaration.parse("[instanceOf=Window]");

    expect(attributeDeclaration, isNotNull);
    List<IDLAttribute> attributes = attributeDeclaration.attributes;
    expect(attributes.length, equals(1));
    IDLAttribute attribute = attributes[0];
    expect(attribute, isNotNull);
    expect(attribute.attributeType, equals(IDLAttributeTypeEnum.INSTANCE_OF));
    expect(attribute.attributeValue, equals("Window"));
  });

  test('attribute with [nodoc]', () {

    IDLAttributeDeclaration attributeDeclaration =
        chromeIDLParser.attributeDeclaration.parse("[nodoc]");

    expect(attributeDeclaration, isNotNull);
    List<IDLAttribute> attributes = attributeDeclaration.attributes;
    expect(attributes.length, equals(1));
    IDLAttribute attribute = attributes[0];
    expect(attribute, isNotNull);
    expect(attribute.attributeType, equals(IDLAttributeTypeEnum.NODOC));
  });

  test('attribute with [legalValues=(16,32)]', () {

    IDLAttributeDeclaration attributeDeclaration =
        chromeIDLParser.attributeDeclaration.parse("[legalValues=(16,32)]");

    expect(attributeDeclaration, isNotNull);
    List<IDLAttribute> attributes = attributeDeclaration.attributes;
    expect(attributes.length, equals(1));
    IDLAttribute attribute = attributes[0];
    expect(attribute, isNotNull);
    expect(attribute.attributeType, equals(IDLAttributeTypeEnum.LEGAL_VALUES));
    expect(attribute.attributeValues.length, equals(2));
    expect(attribute.attributeValues[0], equals(16));
    expect(attribute.attributeValues[1], equals(32));
  });

  test('attribute with [nocompile, nodoc]', () {

    IDLAttributeDeclaration attributeDeclaration =
        chromeIDLParser.attributeDeclaration.parse("[nocompile, nodoc]");

    expect(attributeDeclaration, isNotNull);
    List<IDLAttribute> attributes = attributeDeclaration.attributes;
    expect(attributeDeclaration.attributes.length, equals(2));
    IDLAttribute attribute = attributes[0];
    expect(attribute.attributeType, equals(IDLAttributeTypeEnum.NOCOMPILE));
    attribute = attributes[1];
    expect(attribute.attributeType, equals(IDLAttributeTypeEnum.NODOC));
  });
}

void chromeIDLParserEnumBodyTests() {
  test('enum value with comments', () {

    IDLEnumValue enumValue = chromeIDLParser.enumBody.parse("""
// A comment about a value.
value
""");
    expect(enumValue, isNotNull);
    expect(enumValue.name, equals("value"));
    expect(enumValue.documentation.length, equals(1));
    expect(enumValue.documentation[0], equals(" A comment about a value."));
  });

  test('enum value with multiline comments', () {

    IDLEnumValue enumValue = chromeIDLParser.enumBody.parse("""
// A comment about a value.
// A second line of comments.
value
""");
    expect(enumValue, isNotNull);
    expect(enumValue.name, equals("value"));
    expect(enumValue.documentation.length, equals(2));
    expect(enumValue.documentation[0], equals(" A comment about a value."));
    expect(enumValue.documentation[1], equals(" A second line of comments."));
  });

  test('enum value without comments', () {

    IDLEnumValue enumValue = chromeIDLParser.enumBody.parse("value");
    expect(enumValue, isNotNull);
    expect(enumValue.name, equals("value"));
    expect(enumValue.documentation, isEmpty);
  });
}

void chromeIDLParserEnumDeclarationTests() {
  test('enum single line declaration', () {

    IDLEnumDeclaration enumDeclaration = chromeIDLParser.enumDeclaration
        .parse("enum Values {value1, value_2, VALUE};");
    expect(enumDeclaration, isNotNull);
    expect(enumDeclaration.name, equals("Values"));
    expect(enumDeclaration.documentation, isEmpty);
    expect(enumDeclaration.attribute, isNull);
    expect(enumDeclaration.enums.length, equals(3));
    expect(enumDeclaration.enums[0].name, equals("value1"));
    expect(enumDeclaration.enums[0].documentation, isEmpty);
    expect(enumDeclaration.enums[1].name, equals("value_2"));
    expect(enumDeclaration.enums[1].documentation, isEmpty);
    expect(enumDeclaration.enums[2].name, equals("VALUE"));
    expect(enumDeclaration.enums[2].documentation, isEmpty);
  });

  test('enum single line declaration with attribute', () {

    IDLEnumDeclaration enumDeclaration = chromeIDLParser.enumDeclaration
        .parse("[nodoc] enum Values {value1, value_2, VALUE};");
    expect(enumDeclaration, isNotNull);
    expect(enumDeclaration.name, equals("Values"));
    expect(enumDeclaration.documentation, isEmpty);
    expect(enumDeclaration.attribute, isNotNull);
    expect(enumDeclaration.attribute.attributes.length, equals(1));
    expect(enumDeclaration.attribute.attributes[0].attributeType,
        equals(IDLAttributeTypeEnum.NODOC));
    expect(enumDeclaration.enums.length, equals(3));
    expect(enumDeclaration.enums[0].name, equals("value1"));
    expect(enumDeclaration.enums[0].documentation, isEmpty);
    expect(enumDeclaration.enums[1].name, equals("value_2"));
    expect(enumDeclaration.enums[1].documentation, isEmpty);
    expect(enumDeclaration.enums[2].name, equals("VALUE"));
    expect(enumDeclaration.enums[2].documentation, isEmpty);
  });

  test('enum multiline with comments', () {

    IDLEnumDeclaration enumDeclaration = chromeIDLParser.enumDeclaration
        .parse("""
// Comments for Values
enum Values {

// Comments for value1
value1, 

// Comments for value_2
// Added second line for comment
value_2, 

// Comments for Values
VALUE};""");

    expect(enumDeclaration, isNotNull);
    expect(enumDeclaration.name, equals("Values"));
    expect(enumDeclaration.documentation.length, equals(1));
    expect(enumDeclaration.documentation[0], equals(" Comments for Values"));

    expect(enumDeclaration.enums.length, equals(3));
    expect(enumDeclaration.enums[0].name, equals("value1"));
    expect(enumDeclaration.enums[0].documentation.length, equals(1));
    expect(enumDeclaration.enums[0].documentation[0],
        equals(" Comments for value1"));
    expect(enumDeclaration.enums[1].name, equals("value_2"));
    expect(enumDeclaration.enums[1].documentation.length, equals(2));
    expect(enumDeclaration.enums[1].documentation[0],
        equals(" Comments for value_2"));
    expect(enumDeclaration.enums[1].documentation[1],
        equals(" Added second line for comment"));
    expect(enumDeclaration.enums[2].name, equals("VALUE"));
    expect(enumDeclaration.enums[2].documentation.length, equals(1));
    expect(enumDeclaration.enums[2].documentation[0],
        equals(" Comments for Values"));
  });

  test('enum multiline with comments attribute', () {

    IDLEnumDeclaration enumDeclaration = chromeIDLParser.enumDeclaration
        .parse("""
// Comments for Values
[nocompile, nodoc]
enum Values {

// Comments for value1
value1, 

// Comments for value_2
// Added second line for comment
value_2, 

// Comments for Values
VALUE};""");

    expect(enumDeclaration, isNotNull);

    expect(enumDeclaration.attribute, isNotNull);
    List<IDLAttribute> attributes = enumDeclaration.attribute.attributes;
    expect(attributes.length, equals(2));
    IDLAttribute attribute = attributes[0];
    expect(attribute.attributeType, equals(IDLAttributeTypeEnum.NOCOMPILE));
    attribute = attributes[1];
    expect(attribute.attributeType, equals(IDLAttributeTypeEnum.NODOC));

    expect(enumDeclaration.name, equals("Values"));
    expect(enumDeclaration.documentation.length, equals(1));
    expect(enumDeclaration.documentation[0], equals(" Comments for Values"));

    expect(enumDeclaration.enums.length, equals(3));
    expect(enumDeclaration.enums[0].name, equals("value1"));
    expect(enumDeclaration.enums[0].documentation.length, equals(1));
    expect(enumDeclaration.enums[0].documentation[0],
        equals(" Comments for value1"));
    expect(enumDeclaration.enums[1].name, equals("value_2"));
    expect(enumDeclaration.enums[1].documentation.length, equals(2));
    expect(enumDeclaration.enums[1].documentation[0],
        equals(" Comments for value_2"));
    expect(enumDeclaration.enums[1].documentation[1],
        equals(" Added second line for comment"));
    expect(enumDeclaration.enums[2].name, equals("VALUE"));
    expect(enumDeclaration.enums[2].documentation.length, equals(1));
    expect(enumDeclaration.enums[2].documentation[0],
        equals(" Comments for Values"));
  });
}

void chromeIDLParserCallbackParameterTypeTests() {
  test('callback parameter type with array', () {

    IDLType callbackParameterType = chromeIDLParser.callbackParameterType
        .parse("Device[]");
    expect(callbackParameterType, isNotNull);
    expect(callbackParameterType.name, equals("Device"));
    expect(callbackParameterType.isArray, isTrue);
  });

  test('callback parameter type without array', () {

    IDLType callbackParameterType = chromeIDLParser.callbackParameterType
        .parse("Device");
    expect(callbackParameterType, isNotNull);
    expect(callbackParameterType.name, equals("Device"));
    expect(callbackParameterType.isArray, isFalse);
  });
}

void chromeIDLParserCallbackParameterTests() {
  test('callback parameter with attribute', () {

    IDLParameter callbackParameter = chromeIDLParser.callbackParameters
        .parse("[instanceOf=Entry] object entry");

    expect(callbackParameter, isNotNull);
    expect(callbackParameter.name, equals("entry"));
    expect(callbackParameter.isCallback, isFalse);
    expect(callbackParameter.isOptional, isFalse);
    expect(callbackParameter.type.isArray, isFalse);
    expect(callbackParameter.type.name, equals("Entry"));
    expect(callbackParameter.attribute.attributes[0].attributeType,
        equals(IDLAttributeTypeEnum.INSTANCE_OF));
    expect(callbackParameter.attribute.attributes[0].attributeValue,
        equals("Entry"));
  });

  test('callback parameter with optional', () {

    IDLParameter callbackParameter = chromeIDLParser.callbackParameters
        .parse("optional DOMString responseUrl");

    expect(callbackParameter, isNotNull);
    expect(callbackParameter.name, equals("responseUrl"));
    expect(callbackParameter.attribute, isNull);
    expect(callbackParameter.isCallback, isFalse);
    expect(callbackParameter.isOptional, isTrue);
    expect(callbackParameter.type.isArray, isFalse);
    expect(callbackParameter.type.name, equals("DOMString"));
  });

  test('callback parameter with array', () {

    IDLParameter callbackParameter = chromeIDLParser.callbackParameters
        .parse("Device[] result");

    expect(callbackParameter, isNotNull);
    expect(callbackParameter.name, equals("result"));
    expect(callbackParameter.attribute, isNull);
    expect(callbackParameter.isCallback, isFalse);
    expect(callbackParameter.isOptional, isFalse);
    expect(callbackParameter.type.isArray, isTrue);
    expect(callbackParameter.type.name, equals("Device"));
  });

  test('callback parameter', () {

    IDLParameter callbackParameter = chromeIDLParser.callbackParameters
        .parse("Device device");

    expect(callbackParameter, isNotNull);
    expect(callbackParameter.name, equals("device"));
    expect(callbackParameter.attribute, isNull);
    expect(callbackParameter.isCallback, isFalse);
    expect(callbackParameter.isOptional, isFalse);
    expect(callbackParameter.type.isArray, isFalse);
    expect(callbackParameter.type.name, equals("Device"));
  });
}

void chromeIDLParserCallbackMethodTests() {
  test('with no parameters', () {

    List<IDLParameter> parameters = chromeIDLParser.callbackMethod
        .parse("void()");

    expect(parameters, isNotNull);
    expect(parameters.length, equals(0));

    parameters = chromeIDLParser.callbackMethod.parse("void ()");

    expect(parameters, isNotNull);
    expect(parameters.length, equals(0));

  });

  test('with one parameter', () {

    List<IDLParameter> parameters = chromeIDLParser.callbackMethod
        .parse("void (long result)");

    expect(parameters, isNotNull);
    expect(parameters.length, equals(1));
    IDLParameter parameter = parameters[0];
    expect(parameter.name, equals("result"));
    expect(parameter.attribute, isNull);
    expect(parameter.isCallback, isFalse);
    expect(parameter.isOptional, isFalse);
    expect(parameter.type.isArray, isFalse);
    expect(parameter.type.name, equals("long"));
  });

  test('with multiple parameters', () {

    List<IDLParameter> parameters = chromeIDLParser.callbackMethod
        .parse("""void(OutputDeviceInfo[] outputInfo,
InputDeviceInfo[] inputInfo)""");

    expect(parameters, isNotNull);
    expect(parameters.length, equals(2));
    IDLParameter parameter = parameters[0];
    expect(parameter.name, equals("outputInfo"));
    expect(parameter.attribute, isNull);
    expect(parameter.isCallback, isFalse);
    expect(parameter.isOptional, isFalse);
    expect(parameter.type.isArray, isTrue);
    expect(parameter.type.name, equals("OutputDeviceInfo"));

    parameter = parameters[1];
    expect(parameter.name, equals("inputInfo"));
    expect(parameter.attribute, isNull);
    expect(parameter.isCallback, isFalse);
    expect(parameter.isOptional, isFalse);
    expect(parameter.type.isArray, isTrue);
    expect(parameter.type.name, equals("InputDeviceInfo"));
  });

  test('with mixed type parameters', () {

    List<IDLParameter> parameters = chromeIDLParser.callbackMethod.parse(
"""void (optional ArrayBuffer result, bool success, DOMString[] codes)""");

    expect(parameters, isNotNull);
    expect(parameters.length, equals(3));
    IDLParameter parameter = parameters[0];
    expect(parameter.name, equals("result"));
    expect(parameter.attribute, isNull);
    expect(parameter.isCallback, isFalse);
    expect(parameter.isOptional, isTrue);
    expect(parameter.type.isArray, isFalse);
    expect(parameter.type.name, equals("ArrayBuffer"));

    parameter = parameters[1];
    expect(parameter.name, equals("success"));
    expect(parameter.attribute, isNull);
    expect(parameter.isCallback, isFalse);
    expect(parameter.isOptional, isFalse);
    expect(parameter.type.isArray, isFalse);
    expect(parameter.type.name, equals("bool"));

    parameter = parameters[2];
    expect(parameter.name, equals("codes"));
    expect(parameter.attribute, isNull);
    expect(parameter.isCallback, isFalse);
    expect(parameter.isOptional, isFalse);
    expect(parameter.type.isArray, isTrue);
    expect(parameter.type.name, equals("DOMString"));
  });
}

void chromeIDLParserCallbackDeclarationTests() {
  test('single line', () {

    IDLCallbackDeclaration callbackDeclaration =
        chromeIDLParser.callbackDeclaration.parse(""" 
callback GetAuthTokenCallback = void (optional DOMString token);
""");

    expect(callbackDeclaration.name, equals("GetAuthTokenCallback"));
    expect(callbackDeclaration.documentation, isEmpty);
    expect(callbackDeclaration.parameters.length, equals(1));
    expect(callbackDeclaration.parameters[0].name, equals("token"));
    expect(callbackDeclaration.parameters[0].type.name, equals("DOMString"));
    expect(callbackDeclaration.parameters[0].isOptional, isTrue);
    expect(callbackDeclaration.parameters[0].isCallback, isFalse);
    expect(callbackDeclaration.parameters[0].attribute, isNull);
  });

  test('single line with comments', () {

    IDLCallbackDeclaration callbackDeclaration =
        chromeIDLParser.callbackDeclaration.parse(""" 
// Some comment.
callback EntryCallback = void ([instanceOf=Entry] object entry);
""");

    expect(callbackDeclaration.name, equals("EntryCallback"));
    expect(callbackDeclaration.documentation.length, equals(1));
    expect(callbackDeclaration.documentation[0], equals(" Some comment."));
    expect(callbackDeclaration.parameters.length, equals(1));
    expect(callbackDeclaration.parameters[0].name, equals("entry"));
    expect(callbackDeclaration.parameters[0].type.name, equals("Entry"));
    expect(callbackDeclaration.parameters[0].isOptional, isFalse);
    expect(callbackDeclaration.parameters[0].isCallback, isFalse);
    expect(callbackDeclaration.parameters[0].attribute, isNotNull);
    expect(callbackDeclaration.parameters[0].attribute.attributes.length,
        equals(1));
    IDLAttribute attribute =
        callbackDeclaration.parameters[0].attribute.attributes[0];
    expect(attribute.attributeType, equals(IDLAttributeTypeEnum.INSTANCE_OF));
    expect(attribute.attributeValue, equals("Entry"));
  });

  test('multiline', () {

    List<IDLCallbackDeclaration> callbackDeclarations =
        chromeIDLParser.callbackDeclaration.many.parse(""" 
callback GetAuthTokenCallback = void (optional DOMString token);
callback EntryCallback = void ([instanceOf=Entry] object entry);
""");

    expect(callbackDeclarations, isNotNull);
    expect(callbackDeclarations.length, equals(2));
    IDLCallbackDeclaration callbackDeclaration = callbackDeclarations[0];
    expect(callbackDeclaration.name, equals("GetAuthTokenCallback"));
    expect(callbackDeclaration.documentation, isEmpty);
    expect(callbackDeclaration.parameters.length, equals(1));
    expect(callbackDeclaration.parameters[0].name, equals("token"));
    expect(callbackDeclaration.parameters[0].type.name, equals("DOMString"));
    expect(callbackDeclaration.parameters[0].isOptional, isTrue);
    expect(callbackDeclaration.parameters[0].isCallback, isFalse);
    expect(callbackDeclaration.parameters[0].attribute, isNull);

    callbackDeclaration = callbackDeclarations[1];
    expect(callbackDeclaration.name, equals("EntryCallback"));
    expect(callbackDeclaration.documentation, isEmpty);
    expect(callbackDeclaration.parameters.length, equals(1));
    expect(callbackDeclaration.parameters[0].name, equals("entry"));
    expect(callbackDeclaration.parameters[0].type.name, equals("Entry"));
    expect(callbackDeclaration.parameters[0].isOptional, isFalse);
    expect(callbackDeclaration.parameters[0].isCallback, isFalse);
    expect(callbackDeclaration.parameters[0].attribute, isNotNull);
    expect(callbackDeclaration.parameters[0].attribute.attributes.length,
        equals(1));
    IDLAttribute attribute =
        callbackDeclaration.parameters[0].attribute.attributes[0];
    expect(attribute.attributeType, equals(IDLAttributeTypeEnum.INSTANCE_OF));
    expect(attribute.attributeValue, equals("Entry"));
  });

  test('multiline with comments', () {

    List<IDLCallbackDeclaration> callbackDeclarations =
        chromeIDLParser.callbackDeclaration.many.parse("""
// Some comment.
callback GetAuthTokenCallback = void (optional DOMString token);
/* Another comment. */
callback EntryCallback = void ([instanceOf=Entry] object entry);
""");

    expect(callbackDeclarations, isNotNull);
    expect(callbackDeclarations.length, equals(2));
    IDLCallbackDeclaration callbackDeclaration = callbackDeclarations[0];
    expect(callbackDeclaration.name, equals("GetAuthTokenCallback"));
    expect(callbackDeclaration.documentation.length, equals(1));
    expect(callbackDeclaration.parameters.length, equals(1));
    expect(callbackDeclaration.documentation[0], equals(" Some comment."));
    expect(callbackDeclaration.parameters[0].name, equals("token"));
    expect(callbackDeclaration.parameters[0].type.name, equals("DOMString"));
    expect(callbackDeclaration.parameters[0].isOptional, isTrue);
    expect(callbackDeclaration.parameters[0].isCallback, isFalse);
    expect(callbackDeclaration.parameters[0].attribute, isNull);

    callbackDeclaration = callbackDeclarations[1];
    expect(callbackDeclaration.name, equals("EntryCallback"));
    expect(callbackDeclaration.documentation.length, equals(1));
    expect(callbackDeclaration.documentation[0], equals(" Another comment. "));
    expect(callbackDeclaration.parameters.length, equals(1));
    expect(callbackDeclaration.parameters[0].name, equals("entry"));
    expect(callbackDeclaration.parameters[0].type.name, equals("Entry"));
    expect(callbackDeclaration.parameters[0].isOptional, isFalse);
    expect(callbackDeclaration.parameters[0].isCallback, isFalse);
    expect(callbackDeclaration.parameters[0].attribute, isNotNull);
    expect(callbackDeclaration.parameters[0].attribute.attributes.length,
        equals(1));
    IDLAttribute attribute =
        callbackDeclaration.parameters[0].attribute.attributes[0];
    expect(attribute.attributeType, equals(IDLAttributeTypeEnum.INSTANCE_OF));
    expect(attribute.attributeValue, equals("Entry"));
  });
}

void chromeIDLParserFieldTypeTests() {
  test('field type with array', () {

    IDLType fieldType = chromeIDLParser.fieldType
        .parse("Device[]");
    expect(fieldType, isNotNull);
    expect(fieldType.name, equals("Device"));
    expect(fieldType.isArray, isTrue);
  });

  test('field type without array', () {

    IDLType fieldType = chromeIDLParser.fieldType
        .parse("Device");
    expect(fieldType, isNotNull);
    expect(fieldType.name, equals("Device"));
    expect(fieldType.isArray, isFalse);
  });
}

void chromeIDLParserFieldMethodParametersTests() {
  test('with attribute', () {

    IDLParameter fieldMethodParameter = chromeIDLParser.fieldMethodParameters
        .parse("[instanceOf=Entry] object entry");

    expect(fieldMethodParameter, isNotNull);
    expect(fieldMethodParameter.name, equals("entry"));
    expect(fieldMethodParameter.isCallback, isFalse);
    expect(fieldMethodParameter.isOptional, isFalse);
    expect(fieldMethodParameter.type.isArray, isFalse);
    expect(fieldMethodParameter.type.name, equals("Entry"));
    expect(fieldMethodParameter.attribute.attributes[0].attributeType,
        equals(IDLAttributeTypeEnum.INSTANCE_OF));
    expect(fieldMethodParameter.attribute.attributes[0].attributeValue,
        equals("Entry"));
  });

  test('without attribute', () {

    IDLParameter fieldMethodParameter = chromeIDLParser.fieldMethodParameters
        .parse("DOMString responseUrl");

    expect(fieldMethodParameter, isNotNull);
    expect(fieldMethodParameter.name, equals("responseUrl"));
    expect(fieldMethodParameter.attribute, isNull);
    expect(fieldMethodParameter.isCallback, isFalse);
    expect(fieldMethodParameter.isOptional, isFalse);
    expect(fieldMethodParameter.type.isArray, isFalse);
    expect(fieldMethodParameter.type.name, equals("DOMString"));
  });

  test('array type without attribute', () {

    IDLParameter fieldMethodParameter = chromeIDLParser.fieldMethodParameters
        .parse("DOMString[] urls");

    expect(fieldMethodParameter, isNotNull);
    expect(fieldMethodParameter.name, equals("urls"));
    expect(fieldMethodParameter.attribute, isNull);
    expect(fieldMethodParameter.isCallback, isFalse);
    expect(fieldMethodParameter.isOptional, isFalse);
    expect(fieldMethodParameter.type.isArray, isTrue);
    expect(fieldMethodParameter.type.name, equals("DOMString"));
  });
}

void chromeIDLParserTypeBodyTests() {


  test('field with attribute', () {
    List<IDLField> typeField = chromeIDLParser.typeBody
        .parse("[instanceOf=FileEntry] object entry;");
    expect(typeField, isNotNull);
    expect(typeField.length, 1);
    expect(typeField[0].name, equals("entry"));
    expect(typeField[0].type.name, equals("FileEntry"));
    expect(typeField[0].type.isArray, isFalse);
    expect(typeField[0].isOptional, isFalse);
    expect(typeField[0].attribute.attributes[0].attributeType,
        equals(IDLAttributeTypeEnum.INSTANCE_OF));
    expect(typeField[0].attribute.attributes[0].attributeValue,
        equals("FileEntry"));
  });
  test('field with optional', () {
    List<IDLField> typeField = chromeIDLParser.typeBody
        .parse("DOMString? entry;");
    expect(typeField, isNotNull);
    expect(typeField.length, 1);
    expect(typeField[0].name, equals("entry"));
    expect(typeField[0].type.name, equals("DOMString"));
    expect(typeField[0].type.isArray, isFalse);
    expect(typeField[0].isOptional, isTrue);
  });

  test('field without optional', () {
    List<IDLField> typeField = chromeIDLParser.typeBody
        .parse("DOMString entry;");
    expect(typeField, isNotNull);
    expect(typeField.length, 1);
    expect(typeField[0].name, equals("entry"));
    expect(typeField[0].type.name, equals("DOMString"));
    expect(typeField[0].type.isArray, isFalse);
    expect(typeField[0].isOptional, isFalse);
  });

  test('field array with optional', () {
    List<IDLField> typeField = chromeIDLParser.typeBody
        .parse("DOMString[]? entry;");
    expect(typeField, isNotNull);
    expect(typeField.length, 1);
    expect(typeField[0].name, equals("entry"));
    expect(typeField[0].type.name, equals("DOMString"));
    expect(typeField[0].type.isArray, isTrue);
    expect(typeField[0].isOptional, isTrue);
  });

  test('field array without optional', () {
    List<IDLField> typeField = chromeIDLParser.typeBody
        .parse("DOMString[] entry;");
    expect(typeField, isNotNull);
    expect(typeField.length, 1);
    expect(typeField[0].name, equals("entry"));
    expect(typeField[0].type.name, equals("DOMString"));
    expect(typeField[0].type.isArray, isTrue);
    expect(typeField[0].isOptional, isFalse);
  });

  test('field void method no parameters', () {
    List<IDLMethod> typeFieldMethod = chromeIDLParser.typeBody
        .parse("static void size();");
    expect(typeFieldMethod, isNotNull);
    expect(typeFieldMethod.length, 1);
    expect(typeFieldMethod[0].name, equals("size"));
    expect(typeFieldMethod[0].parameters, isEmpty);
    expect(typeFieldMethod[0].attribute, isNull);
    expect(typeFieldMethod[0].returnType.name, equals("void"));
    expect(typeFieldMethod[0].returnType.isArray, isFalse);
    expect(typeFieldMethod[0].documentation, isEmpty);
  });

  test('field void method with multiple parameters', () {
    List<IDLMethod> typeFieldMethod = chromeIDLParser.typeBody
        .parse("static Sizes[] resizeTo(long width, long height);");
    expect(typeFieldMethod, isNotNull);
    expect(typeFieldMethod.length, 1);
    expect(typeFieldMethod[0].name, equals("resizeTo"));
    expect(typeFieldMethod[0].parameters.length, 2);
    IDLParameter parameter = typeFieldMethod[0].parameters[0];
    expect(parameter.name, equals("width"));
    expect(parameter.type.name, equals("long"));
    parameter = typeFieldMethod[0].parameters[1];
    expect(parameter.name, equals("height"));
    expect(parameter.type.name, equals("long"));
    expect(typeFieldMethod[0].attribute, isNull);
    expect(typeFieldMethod[0].returnType.name, equals("Sizes"));
    expect(typeFieldMethod[0].returnType.isArray, isTrue);
    expect(typeFieldMethod[0].documentation, isEmpty);
  });

  test('field void method with attribute', () {
    List<IDLMethod> typeFieldMethod = chromeIDLParser.typeBody
        .parse("[nodoc] static void size();");
    expect(typeFieldMethod, isNotNull);
    expect(typeFieldMethod.length, 1);
    expect(typeFieldMethod[0].name, equals("size"));
    expect(typeFieldMethod[0].parameters, isEmpty);
    expect(typeFieldMethod[0].attribute.attributes.length, equals(1));
    IDLAttribute attribute = typeFieldMethod[0].attribute.attributes[0];
    expect(attribute.attributeType, IDLAttributeTypeEnum.NODOC);
    expect(typeFieldMethod[0].returnType.name, equals("void"));
    expect(typeFieldMethod[0].returnType.isArray, isFalse);
    expect(typeFieldMethod[0].documentation, isEmpty);
  });

  test('field type returned method with no parameters', () {
    List<IDLMethod> typeFieldMethod = chromeIDLParser.typeBody
        .parse("static Bounds getBounds();");
    expect(typeFieldMethod, isNotNull);
    expect(typeFieldMethod.length, 1);
    expect(typeFieldMethod[0].name, equals("getBounds"));
    expect(typeFieldMethod[0].parameters, isEmpty);
    expect(typeFieldMethod[0].attribute, isNull);
    expect(typeFieldMethod[0].returnType.name, equals("Bounds"));
    expect(typeFieldMethod[0].returnType.isArray, isFalse);
    expect(typeFieldMethod[0].documentation, isEmpty);
  });

  test('field type returned method with mixed parameters', () {
    List types = chromeIDLParser.typeBody
        .parse(""" 
// Some comments
static Bounds getBounds();

// Some other comments
// Multiline
[nodoc] static void size();

static Sizes[] resizeTo(long width, long height);

DOMString[] entry1;

DOMString[]? entry2;

DOMString? entry3;

DOMString entry4;
""");
    expect(types, isNotNull);
    expect(types[0].runtimeType.toString(), equals("IDLMethod"));
    expect(types[0].documentation.length, equals(1));
    expect(types[1].runtimeType.toString(), equals("IDLMethod"));
    expect(types[1].documentation.length, equals(2));
    expect(types[2].runtimeType.toString(), equals("IDLMethod"));
    expect(types[3].runtimeType.toString(), equals("IDLField"));
    expect(types[4].runtimeType.toString(), equals("IDLField"));
    expect(types[5].runtimeType.toString(), equals("IDLField"));
    expect(types[6].runtimeType.toString(), equals("IDLField"));
  });
}


void chromeIDLParserTypeDeclarationTests() {
  test('dictionary with no members or methods', () {
    IDLTypeDeclaration typeDeclaration = chromeIDLParser.typeDeclaration
        .parse("""// Options for the getServices function.
  dictionary GetServicesOptions {
  };
""");

    expect(typeDeclaration, isNotNull);
    expect(typeDeclaration.name, equals("GetServicesOptions"));
    expect(typeDeclaration.documentation.length, equals(1));
    expect(typeDeclaration.members, isEmpty);
    expect(typeDeclaration.methods, isEmpty);
    expect(typeDeclaration.attribute, isNull);
  });

  test('dictionary with one member', () {
    IDLTypeDeclaration typeDeclaration = chromeIDLParser.typeDeclaration
        .parse("""// Options for the getServices function.
dictionary GetServicesOptions {
  // The address of the remote device that the data should be associated
  // with. |deviceAddress| should be in the format 'XX:XX:XX:XX:XX:XX'.
  DOMString deviceAddress;
};
""");

    expect(typeDeclaration, isNotNull);
    expect(typeDeclaration.name, equals("GetServicesOptions"));
    expect(typeDeclaration.documentation.length, equals(1));
    expect(typeDeclaration.members.length, equals(1));
    expect(typeDeclaration.members[0].documentation.length, equals(2));
    expect(typeDeclaration.members[0].name, equals("deviceAddress"));
    expect(typeDeclaration.members[0].type.name, equals("DOMString"));
    expect(typeDeclaration.methods, isEmpty);
    expect(typeDeclaration.attribute, isNull);
  });

  test('dictionary with one method', () {
    IDLTypeDeclaration typeDeclaration = chromeIDLParser.typeDeclaration
        .parse("""// Options for the getServices function.
  dictionary GetServicesOptions {
    static Device getDevice();
  };
""");

    expect(typeDeclaration, isNotNull);
    expect(typeDeclaration.name, equals("GetServicesOptions"));
    expect(typeDeclaration.documentation.length, equals(1));
    expect(typeDeclaration.members, isEmpty);
    expect(typeDeclaration.methods.length, equals(1));
    expect(typeDeclaration.methods[0].documentation, isEmpty);
    expect(typeDeclaration.methods[0].name, equals("getDevice"));
    expect(typeDeclaration.methods[0].returnType.name, equals("Device"));
  });

  test('dictionary with multiple members', () {
    IDLTypeDeclaration typeDeclaration = chromeIDLParser.typeDeclaration
        .parse("""// Options for the getDevices function. If |profile| is not provided, all
// devices known to the system are returned.
  dictionary GetDevicesOptions {
    // Only devices providing |profile| will be returned.
    Profile? profile;

    // Called for each matching device.  Note that a service discovery request
    DeviceCallback deviceCallback;
  };
""");

    expect(typeDeclaration, isNotNull);
    expect(typeDeclaration.name, equals("GetDevicesOptions"));
    expect(typeDeclaration.documentation.length, equals(2));
    expect(typeDeclaration.methods, isEmpty);
    expect(typeDeclaration.members.length, equals(2));
    expect(typeDeclaration.members[0].name, equals("profile"));
    expect(typeDeclaration.members[0].type.name, equals("Profile"));
    expect(typeDeclaration.members[0].isOptional, isTrue);

    expect(typeDeclaration.members[1].name, equals("deviceCallback"));
    expect(typeDeclaration.members[1].type.name, equals("DeviceCallback"));
    expect(typeDeclaration.members[1].isOptional, isFalse);
  });

  test('dictionary with multiple methods', () {
    IDLTypeDeclaration typeDeclaration = chromeIDLParser.typeDeclaration
        .parse("""[noinline_doc] dictionary AppWindow {
    // Focus the window.
    static void focus();

    // Fullscreens the window.
    static void fullscreen();


    static boolean isFullscreen();
};
""");

    expect(typeDeclaration, isNotNull);
    expect(typeDeclaration.name, equals("AppWindow"));
    expect(typeDeclaration.attribute.attributes[0].attributeType,
        equals(IDLAttributeTypeEnum.NOINLINE_DOC));
    expect(typeDeclaration.documentation, isEmpty);
    expect(typeDeclaration.members, isEmpty);
    expect(typeDeclaration.methods.length, equals(3));
    expect(typeDeclaration.methods[0].name, equals("focus"));
    expect(typeDeclaration.methods[0].returnType.name, equals("void"));

    expect(typeDeclaration.methods[1].name, equals("fullscreen"));
    expect(typeDeclaration.methods[1].returnType.name, equals("void"));

    expect(typeDeclaration.methods[2].name, equals("isFullscreen"));
    expect(typeDeclaration.methods[2].returnType.name, equals("boolean"));
  });

  test('dictionary with attribute, members, methods', () {
    IDLTypeDeclaration typeDeclaration = chromeIDLParser.typeDeclaration
        .parse("""[noinline_doc] dictionary AppWindow {
    // Focus the window.
    static void focus();

    // Move the window to the position (|left|, |top|).
    static void moveTo(long left, long top);

    // Resize the window to |width|x|height| pixels in size.
    static void resizeTo(long width, long height);

    // Draw attention to the window.
    static void drawAttention();

    // Get the window's bounds as a \$ref:Bounds object.
    [nocompile] static Bounds getBounds();

    // Set the window's bounds.
    static void setBounds(Bounds bounds);

    // Set the app icon for the window (experimental).
    [nodoc] static void setIcon(DOMString icon_url);

    // The JavaScript 'window' object for the created child.
    [instanceOf=Window] object contentWindow;

    // Type of window to create.
    [nodoc] WindowType? type;
    // The connection is made to |profile|.
    Profile profile;
  };
""");

    expect(typeDeclaration, isNotNull);
    expect(typeDeclaration.name, equals("AppWindow"));
    expect(typeDeclaration.attribute.attributes[0].attributeType,
        equals(IDLAttributeTypeEnum.NOINLINE_DOC));
    expect(typeDeclaration.documentation, isEmpty);
    expect(typeDeclaration.members.length, equals(3));
    expect(typeDeclaration.methods.length, equals(7));
  });
}

void chromeIDLParserMethodsTests() {
  test('simple method defined', () {
    List<IDLMethod> methods = chromeIDLParser.methods
        .parse("static Sizes[] resizeTo(long width, long height);");

    expect(methods, isNotNull);
    expect(methods.length, 1);
    expect(methods[0].name, equals("resizeTo"));
    expect(methods[0].parameters.length, 2);
    IDLParameter parameter = methods[0].parameters[0];
    expect(parameter.name, equals("width"));
    expect(parameter.type.name, equals("long"));
    parameter = methods[0].parameters[1];
    expect(parameter.name, equals("height"));
    expect(parameter.type.name, equals("long"));
    expect(methods[0].attribute, isNull);
    expect(methods[0].returnType.name, equals("Sizes"));
    expect(methods[0].returnType.isArray, isTrue);
    expect(methods[0].documentation, isEmpty);

  });
}

void chromeIDLParserFunctionDeclarationTests() {
  test('test Functions declaration single function', () {
    IDLFunctionDeclaration functionDeclaration = chromeIDLParser.functionDeclaration
        .parse("""interface Functions {
    // Gets resources required to render the API.
    //
    static void getResources(GetResourcesCallback callback);
  };
""");

    expect(functionDeclaration, isNotNull);
    expect(functionDeclaration.name, equals("Functions"));
    expect(functionDeclaration.methods.length, equals(1));
    expect(functionDeclaration.methods[0].name, equals("getResources"));
  });

  test('test Functions parameters are callbacks', () {
    IDLFunctionDeclaration functionDeclaration = chromeIDLParser.functionDeclaration
        .parse("""interface Functions {
    // Get the media galleries configured in this user agent. If none are
    // configured or available, the callback will receive an empty array.
    static void getMediaFileSystems(optional MediaFileSystemsDetails details,
                                    MediaFileSystemsCallback callback);

    // Get metadata about a specific media file system.
    [nocompile] static MediaFileSystemMetadata getMediaFileSystemMetadata(
        [instanceOf=DOMFileSystem] object mediaFileSystem);
  };
""");

    expect(functionDeclaration, isNotNull);
    expect(functionDeclaration.name, equals("Functions"));
    expect(functionDeclaration.methods.length, equals(2));
    expect(functionDeclaration.methods[0].name, equals("getMediaFileSystems"));
    expect(functionDeclaration.methods[0].parameters, hasLength(2));
    expect(functionDeclaration.methods[0].parameters[0].name,
        equals("details"));
    expect(functionDeclaration.methods[0].parameters[0].type.name,
        equals("MediaFileSystemsDetails"));
    expect(functionDeclaration.methods[0].parameters[1].type.name,
        equals("MediaFileSystemsCallback"));
    expect(functionDeclaration.methods[0].parameters[1].name,
        equals("callback"));
    expect(functionDeclaration.methods[0].parameters[1].isCallback,
        isTrue);
    expect(functionDeclaration.methods[1].parameters[0].name,
        equals("mediaFileSystem"));
    expect(functionDeclaration.methods[1].parameters[0].type.name,
        equals("DOMFileSystem"));
  });
}

void chromeIDLParserEventDeclarationTests() {
  test('test Events declaration single event', () {
    IDLEventDeclaration eventDeclaration = chromeIDLParser.eventDeclaration
        .parse("""interface Events {
    // Fired when a web flow dialog should be displayed.
    static void onWebFlowRequest(DOMString key, DOMString url, DOMString mode);
  };
""");

    expect(eventDeclaration, isNotNull);
    expect(eventDeclaration.name, equals("Events"));
    expect(eventDeclaration.methods.length, equals(1));
    expect(eventDeclaration.methods[0].name, equals("onWebFlowRequest"));
    expect(eventDeclaration.methods[0].parameters.length, equals(3));
  });
}

void chromeIDLParserNamespaceBodyTests() {
  test('single dictionary in body', () {
    List namespaceBody = chromeIDLParser.namespaceBody
        .parse("""
      dictionary AdapterState {
    // The address of the adapter, in the format 'XX:XX:XX:XX:XX:XX'.
    DOMString address;

    // The human-readable name of the adapter.
    DOMString name;

    // Indicates whether or not the adapter has power.
    boolean powered;

    // Indicates whether or not the adapter is available (i.e. enabled).
    boolean available;

    // Indicates whether or not the adapter is currently discovering.
    boolean discovering;
  };
""");

    expect(namespaceBody, isNotNull);
    expect(namespaceBody.length, equals(1));
    expect(namespaceBody[0] is IDLTypeDeclaration, isTrue);
    expect(namespaceBody[0].name, equals("AdapterState"));
    expect((namespaceBody[0] as IDLTypeDeclaration).members.length, equals(5));
  });

  test('multiple dictionary in body', () {
    List namespaceBody = chromeIDLParser.namespaceBody
        .parse("""dictionary AdapterState {
    // The address of the adapter, in the format 'XX:XX:XX:XX:XX:XX'.
    DOMString address;

    // The human-readable name of the adapter.
    DOMString name;

    // Indicates whether or not the adapter has power.
    boolean powered;

    // Indicates whether or not the adapter is available (i.e. enabled).
    boolean available;

    // Indicates whether or not the adapter is currently discovering.
    boolean discovering;
  };

  dictionary Device {
    // The address of the device, in the format 'XX:XX:XX:XX:XX:XX'.
    DOMString address;

    // The human-readable name of the device.
    DOMString? name;

    // Indicates whether or not the device is paired with the system.
    boolean? paired;

    // Indicates whether the device is currently connected to the system.
    boolean? connected;
  };
};
""");

    expect(namespaceBody, isNotNull);
    expect(namespaceBody.length, equals(2));
    expect(namespaceBody[0] is IDLTypeDeclaration, isTrue);
    expect(namespaceBody[0].name, equals("AdapterState"));
    expect((namespaceBody[0] as IDLTypeDeclaration).members.length, equals(5));
    expect(namespaceBody[1] is IDLTypeDeclaration, isTrue);
    expect(namespaceBody[1].name, equals("AdapterState"));
    expect((namespaceBody[1] as IDLTypeDeclaration).members.length, equals(4));
  });

  test('single interface in body', () {
    List namespaceBody = chromeIDLParser.namespaceBody
        .parse("""
  // These functions all report failures via chrome.runtime.lastError.
  interface Functions {
    // Registers the JavaScript application as an implementation for the given
    // Profile; if a channel or PSM is specified, the profile will be exported
    // in the host's SDP and GATT tables and advertised to other devices.
    static void addProfile(Profile profile, ResultCallback callback);
};
""");

    expect(namespaceBody, isNotNull);
    expect(namespaceBody.length, equals(1));
    expect(namespaceBody[0] is IDLFunctionDeclaration, isTrue);
    expect(namespaceBody[0].name, equals("Functions"));
    expect((namespaceBody[0] as IDLFunctionDeclaration).methods.length, equals(1));
  });

  test('multiple interface in body', () {
    List namespaceBody = chromeIDLParser.namespaceBody
        .parse("""
  // These functions all report failures via chrome.runtime.lastError.
  interface Functions {
    // Registers the JavaScript application as an implementation for the given
    // Profile; if a channel or PSM is specified, the profile will be exported
    // in the host's SDP and GATT tables and advertised to other devices.
    static void addProfile(Profile profile, ResultCallback callback);
  };


  interface Events {
    // Fired when the state of the Bluetooth adapter changes.
    // |state| : The new state of the adapter.
    static void onAdapterStateChanged(AdapterState state);

    // Fired when a connection has been made for a registered profile.
    // |socket| : The socket for the connection.
    static void onConnection(Socket socket);
  };
""");

    expect(namespaceBody, isNotNull);
    expect(namespaceBody.length, equals(2));
    expect(namespaceBody[0] is IDLFunctionDeclaration, isTrue);
    expect(namespaceBody[0].name, equals("Functions"));
    expect((namespaceBody[0] as IDLFunctionDeclaration).methods.length, equals(1));
    expect(namespaceBody[1] is IDLEventDeclaration, isTrue);
    expect(namespaceBody[1].name, equals("Events"));
    expect((namespaceBody[1] as IDLEventDeclaration).methods.length, equals(2));
  });

  test('single enum in body', () {
    List namespaceBody = chromeIDLParser.namespaceBody
        .parse("""
  enum SocketType {
    tcp,
    udp
  };
""");

    expect(namespaceBody, isNotNull);
    expect(namespaceBody.length, equals(1));
    expect(namespaceBody[0] is IDLEnumDeclaration, isTrue);
    expect(namespaceBody[0].name, equals("SocketType"));
    expect((namespaceBody[0] as IDLEnumDeclaration).enums.length, equals(2));
  });

  test('multiple enum in body', () {
    List namespaceBody = chromeIDLParser.namespaceBody
        .parse("""
  enum DataBit { sevenbit, eightbit };
  enum ParityBit { noparity, oddparity, evenparity };
  enum StopBit { onestopbit, twostopbit };
""");

    expect(namespaceBody, isNotNull);
    expect(namespaceBody.length, equals(3));
    expect(namespaceBody[0] is IDLEnumDeclaration, isTrue);
    expect(namespaceBody[0].name, equals("DataBit"));
    expect((namespaceBody[0] as IDLEnumDeclaration).enums.length, equals(2));

    expect(namespaceBody[1] is IDLEnumDeclaration, isTrue);
    expect(namespaceBody[1].name, equals("ParityBit"));
    expect((namespaceBody[1] as IDLEnumDeclaration).enums.length, equals(3));

    expect(namespaceBody[2] is IDLEnumDeclaration, isTrue);
    expect(namespaceBody[2].name, equals("StopBit"));
    expect((namespaceBody[2] as IDLEnumDeclaration).enums.length, equals(2));
  });

  test('single callback in body', () {
    List namespaceBody = chromeIDLParser.namespaceBody
        .parse("""
callback OpenCallback = void (OpenInfo openInfo);
""");

    expect(namespaceBody, isNotNull);
    expect(namespaceBody.length, equals(1));
    expect(namespaceBody[0] is IDLCallbackDeclaration, isTrue);
    expect(namespaceBody[0].name, equals("OpenCallback"));
    expect((namespaceBody[0] as IDLCallbackDeclaration).parameters.length,
        equals(2));
  });

  test('multiple callback in body', () {
    List namespaceBody = chromeIDLParser.namespaceBody
        .parse("""
  callback OpenCallback = void (OpenInfo openInfo);

  // Returns true if operation was successful.
  callback CloseCallback = void (boolean result);
""");

    expect(namespaceBody, isNotNull);
    expect(namespaceBody.length, equals(1));
    expect(namespaceBody[0] is IDLCallbackDeclaration, isTrue);
    expect(namespaceBody[0].name, equals("OpenCallback"));
    expect((namespaceBody[0] as IDLCallbackDeclaration).parameters.length,
        equals(1));

    expect(namespaceBody[1] is IDLCallbackDeclaration, isTrue);
    expect(namespaceBody[1].name, equals("CloseCallback"));
    expect((namespaceBody[1] as IDLCallbackDeclaration).parameters.length,
        equals(1));
  });

  test('mixed body', () {
    List namespaceBody = chromeIDLParser.namespaceBody
        .parse("""
  callback GetPortsCallback = void (DOMString[] ports);

  enum DataBit { sevenbit, eightbit };
  enum ParityBit { noparity, oddparity, evenparity };
  enum StopBit { onestopbit, twostopbit };

  dictionary OpenOptions {
    // The requested bitrate of the connection to be opened. For compatibility
    // with the widest range of hardware, this number should match one of
    // commonly-available bitrates, such as 110, 300, 1200, 2400, 4800, 9600,
    // 14400, 19200, 38400, 57600, 115200. There is no guarantee, of course,
    // that the device connected to the serial port will support the requested
    // bitrate, even if the port itself supports that bitrate. <code>9600</code>
    // will be passed by default.
    long? bitrate;
    // <code>"eightbit"</code> will be passed by default.
    DataBit? dataBit;
    // <code>"noparity"</code> will be passed by default.
    ParityBit? parityBit;
    // <code>"onestopbit"</code> will be passed by default.
    StopBit? stopBit;
  };

  dictionary OpenInfo {
    // The id of the opened connection.
    long connectionId;
  };

  callback OpenCallback = void (OpenInfo openInfo);

  // Returns true if operation was successful.
  callback CloseCallback = void (boolean result);

  dictionary ReadInfo {
    // The number of bytes received, or a negative number if an error occurred.
    // This number will be smaller than the number of bytes requested in the
    // original read call if the call would need to block to read that number
    // of bytes.
    long bytesRead;

    // The data received.
    ArrayBuffer data;
  };

  callback ReadCallback = void (ReadInfo readInfo);

  dictionary WriteInfo {
    // The number of bytes written.
    long bytesWritten;
  };

  callback WriteCallback = void (WriteInfo writeInfo);

  // Returns true if operation was successful.
  callback FlushCallback = void (boolean result);

  // Boolean true = mark signal (negative serial voltage).
  // Boolean false = space signal (positive serial voltage).
  //
  // For SetControlSignals, include the sendable signals that you wish to
  // change. Signals not included in the dictionary will be left unchanged.
  //
  // GetControlSignals includes all receivable signals.
  dictionary ControlSignalOptions {
    // Serial control signals that your machine can send. Missing fields will
    // be set to false.
    boolean? dtr;
    boolean? rts;

    // Serial control signals that your machine can receive. If a get operation
    // fails, success will be false, and these fields will be absent.
    //
    // DCD (Data Carrier Detect) is equivalent to RLSD (Receive Line Signal
    // Detect) on some platforms.
    boolean? dcd;
    boolean? cts;
  };

  // Returns a snapshot of current control signals.
  callback GetControlSignalsCallback = void (ControlSignalOptions options);

  // Returns true if operation was successful.
  callback SetControlSignalsCallback = void (boolean result);

  interface Functions {
    // Returns names of valid ports on this machine, each of which is likely to
    // be valid to pass as the port argument to open(). The list is regenerated
    // each time this method is called, as port validity is dynamic.
    //
    // |callback| : Called with the list of ports.
    static void getPorts(GetPortsCallback callback);

    // Opens a connection to the given serial port.
    // |port| : The name of the serial port to open.
    // |options| : Connection options.
    // |callback| : Called when the connection has been opened.
    static void open(DOMString port,
                     optional OpenOptions options,
                     OpenCallback callback);

    // Closes an open connection.
    // |connectionId| : The id of the opened connection.
    // |callback| : Called when the connection has been closed.
    static void close(long connectionId,
                      CloseCallback callback);

    // Reads a byte from the given connection.
    // |connectionId| : The id of the connection.
    // |bytesToRead| : The number of bytes to read.
    // |callback| : Called when all the requested bytes have been read or
    //              when the read blocks.
    static void read(long connectionId,
                     long bytesToRead,
                     ReadCallback callback);

    // Writes a string to the given connection.
    // |connectionId| : The id of the connection.
    // |data| : The string to write.
    // |callback| : Called when the string has been written.
    static void write(long connectionId,
                      ArrayBuffer data,
                      WriteCallback callback);

    // Flushes all bytes in the given connection's input and output buffers.
    // |connectionId| : The id of the connection.
    // |callback| : Called when the flush is complete.
    static void flush(long connectionId,
                      FlushCallback callback);

    static void getControlSignals(long connectionId,
                                  GetControlSignalsCallback callback);

    static void setControlSignals(long connectionId,
                                  ControlSignalOptions options,
                                  SetControlSignalsCallback callback);
  };
""");

    expect(namespaceBody, isNotNull);
    expect(namespaceBody.length, equals(17));
  });
}

void chromeIDLParserNamespaceDeclarationTests() {
  test('complete namespace test', () {
    IDLNamespaceDeclaration namespaceDeclaration = chromeIDLParser
        .namespaceDeclaration.parse("""// Copyright (c) 2012 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Use the <code>chrome.syncFileSystem</code> API to save and synchronize data
// on Google Drive. This API is NOT for accessing arbitrary user docs stored in
// Google Drive. It provides app-specific syncable storage for offline and
// caching usage so that the same data can be available across different
// clients. Read <a href="app_storage.html">Manage Data</a> for more on using
// this API.
namespace syncFileSystem {
  enum SyncAction {
    added, updated, deleted
  };

  enum ServiceStatus {
    // The sync service is being initialized (e.g. restoring data from the
    // database, checking connectivity and authenticating to the service etc).
    initializing,

    // The sync service is up and running.
    running,

    // The sync service is not synchronizing files because the remote service
    // needs to be authenticated by the user to proceed.
    authentication_required,

    // The sync service is not synchronizing files because the remote service
    // is (temporarily) unavailable due to some recoverable errors, e.g.
    // network is offline, the remote service is down or not
    // reachable etc. More details should be given by |description| parameter
    // in OnServiceInfoUpdated (which could contain service-specific details).
    temporary_unavailable,

    // The sync service is disabled and the content will never sync.
    // (E.g. this could happen when the user has no account on
    // the remote service or the sync service has had an unrecoverable
    // error.)
    disabled
  };

  enum FileStatus {
    // Not conflicting and has no pending local changes.
    synced,

    // Has one or more pending local changes that haven't been synchronized.
    pending,

    // File conflicts with remote version and must be resolved manually.
    conflicting
  };

  enum SyncDirection {
    local_to_remote, remote_to_local
  };

  enum ConflictResolutionPolicy {
    last_write_win, manual
  };

  dictionary FileInfo {
    // <code>fileEntry</code> for the target file whose status has changed.
    // Contains name and path information of synchronized file.
    // On file deletion,
    // <code>fileEntry</code> information will still be available
    // but file will no longer exist.
    [instanceOf=Entry] object fileEntry;

    // Resulting file status after \$ref:onFileStatusChanged event.
    // The status value can be <code>'synced'</code>,
    // <code>'pending'</code> or <code>'conflicting'</code>.
    FileStatus status;

    // Sync action taken to fire \$ref:onFileStatusChanged event.
    // The action value can be
    // <code>'added'</code>, <code>'updated'</code> or <code>'deleted'</code>.
    // Only applies if status is <code>'synced'</code>.
    SyncAction? action;

    // Sync direction for the \$ref:onFileStatusChanged event.
    // Sync direction value can be
    // <code>'local_to_remote'</code> or <code>'remote_to_local'</code>.
    // Only applies if status is <code>'synced'</code>.
    SyncDirection? direction;
  };

  dictionary FileStatusInfo {
    // One of the Entry's originally given to getFileStatuses.
    [instanceOf=Entry] object fileEntry;

    // The status value can be <code>'synced'</code>,
    // <code>'pending'</code> or <code>'conflicting'</code>.
    FileStatus status;

    // Optional error that is only returned if there was a problem retrieving
    // the FileStatus for the given file.
    DOMString? error;
  };

  dictionary StorageInfo {
    long usageBytes;
    long quotaBytes;
  };

  dictionary ServiceInfo {
    ServiceStatus state;
    DOMString description;
  };

  // A callback type for requestFileSystem.
  callback GetFileSystemCallback =
      void ([instanceOf=DOMFileSystem] object fileSystem);

  // A callback type for getUsageAndQuota.
  callback QuotaAndUsageCallback = void (StorageInfo info);

  // Returns true if operation was successful.
  callback DeleteFileSystemCallback = void (boolean result);

  // A callback type for getFileStatus.
  callback GetFileStatusCallback = void (FileStatus status);

  // A callback type for getFileStatuses.
  callback GetFileStatusesCallback = void (FileStatusInfo[] status);

  // A callback type for getServiceStatus.
  callback GetServiceStatusCallback = void (ServiceStatus status);

  // A callback type for getConflictResolutionPolicy.
  callback GetConflictResolutionPolicyCallback =
      void (ConflictResolutionPolicy policy);

  // A generic result callback to indicate success or failure.
  callback ResultCallback = void ();

  interface Functions {
    // Returns a syncable filesystem backed by Google Drive.
    // The returned <code>DOMFileSystem</code> instance can be operated on
    // in the same way as the Temporary and Persistant file systems (see
    // <a href="http://www.w3.org/TR/file-system-api/">http://www.w3.org/TR/file-system-api/</a>).
    // Calling this multiple times from
    // the same app will return the same handle to the same file system.
    static void requestFileSystem(GetFileSystemCallback callback);

    // Sets the default conflict resolution policy
    // for the <code>'syncable'</code> file storage for the app.
    // By default it is set to <code>'last_write_win'</code>.
    // When conflict resolution policy is set to <code>'last_write_win'</code>
    // conflicts for existing files are automatically resolved next time
    // the file is updated.
    // |callback| can be optionally given to know if the request has
    // succeeded or not.
    static void setConflictResolutionPolicy(
        ConflictResolutionPolicy policy,
        optional ResultCallback callback);

    // Gets the current conflict resolution policy.
    static void getConflictResolutionPolicy(
        GetConflictResolutionPolicyCallback callback);

    // Returns the current usage and quota in bytes
    // for the <code>'syncable'</code> file storage for the app.
    static void getUsageAndQuota([instanceOf=DOMFileSystem] object fileSystem,
                                 QuotaAndUsageCallback callback);

    // Returns the \$ref:FileStatus for the given <code>fileEntry</code>.
    // The status value can be <code>'synced'</code>,
    // <code>'pending'</code> or <code>'conflicting'</code>.
    // Note that <code>'conflicting'</code> state only happens when
    // the service's conflict resolution policy is set to <code>'manual'</code>.
    static void getFileStatus([instanceOf=Entry] object fileEntry,
                              GetFileStatusCallback callback);

    // Returns each \$ref:FileStatus for the given <code>fileEntry</code> array.
    // Typically called with the result from dirReader.readEntries().
    static void getFileStatuses(object[] fileEntries,
                                GetFileStatusesCallback callback);

    // Returns the current sync backend status.
    static void getServiceStatus(GetServiceStatusCallback callback);
  };

  interface Events {
    // Fired when an error or other status change has happened in the
    // sync backend (for example, when the sync is temporarily disabled due to
    // network or authentication error).
    static void onServiceStatusChanged(ServiceInfo detail);

    // Fired when a file has been updated by the background sync service.
    static void onFileStatusChanged(FileInfo detail);
  };

};""");

    expect(namespaceDeclaration, isNotNull);
    expect(namespaceDeclaration.name, equals("syncFileSystem"));
  });
}

void miscParsingTests() {

  test('object used in dictionary', () {
    String testData = """dictionary MediaStreamConstraint {
    object mandatory;
};
""";

    var result = chromeIDLParser.typeDeclaration
      .parse(testData);

    expect(result, isNotNull);
  });

  test('object used in callback definition', () {
    String testData =
        """callback GetAllCallback = void (object notifications); """;

    IDLCallbackDeclaration callbackDeclaration =
        chromeIDLParser.callbackDeclaration.parse(testData);

    expect(callbackDeclaration, isNotNull);
    expect(callbackDeclaration.name, equals("GetAllCallback"));
    expect(callbackDeclaration.documentation, isEmpty);
    expect(callbackDeclaration.parameters.length, equals(1));
    expect(callbackDeclaration.parameters[0].name, equals("notifications"));
    expect(callbackDeclaration.parameters[0].type.name, equals("object"));
    expect(callbackDeclaration.parameters[0].isOptional, isFalse);
    expect(callbackDeclaration.parameters[0].isCallback, isFalse);
    expect(callbackDeclaration.parameters[0].attribute, isNull);

  });

  test('optional object array with type attribute defined instanceOf callback', () {
    String testData = """callback MediaFileSystemsCallback =
      void ([instanceOf=DOMFileSystem] optional object[] mediaFileSystems);""";

    IDLCallbackDeclaration callbackDeclaration =
        chromeIDLParser.callbackDeclaration.parse(testData);

    expect(callbackDeclaration, isNotNull);
    expect(callbackDeclaration.name, equals("MediaFileSystemsCallback"));
    expect(callbackDeclaration.documentation, isEmpty);
    List<IDLParameter> parameters = callbackDeclaration.parameters;
    expect(parameters.length, equals(1));
    expect(parameters[0].name, equals("mediaFileSystems"));
    expect(parameters[0].type.name, equals("DOMFileSystem"));
    expect(parameters[0].isOptional, isTrue);
    expect(parameters[0].isCallback, isFalse);
    expect(parameters[0].attribute, isNotNull);
  });

  test('object optional by ? with attribute defined instanceOf', () {
    String testData = """dictionary AttachedFile {
    DOMString name;
    [instanceOf=Blob] object? data;
  }; 
""";

    var result = chromeIDLParser.typeDeclaration
      .parse(testData);

    expect(result, isNotNull);
  });

  test('attribute with name=1', () {
    String testData = """[maxListeners=1] static void onDeterminingFilename(
DownloadItem downloadItem, SuggestFilenameCallback suggest); 
""";

    var result = chromeIDLParser.methods
      .parse(testData);

    expect(result, isNotNull);
    expect(result, hasLength(1));
  });

  test('object passed as method parameter', () {
    String testData = """interface Functions {
[nocompile, nodoc] static void initializeAppWindow(object state);
  };""";

    var result = chromeIDLParser.functionDeclaration
        .parse(testData);

    expect(result, isNotNull);
  });


  test('object as parameter for callback', () {
    String testData = """callback GetStringsCallback = void (object result);""";

    IDLCallbackDeclaration callbackDeclaration =
        chromeIDLParser.callbackDeclaration.parse(testData);

    expect(callbackDeclaration, isNotNull);
  });
}


