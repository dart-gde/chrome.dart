
library chrome_model_test;

import 'package:unittest/unittest.dart';

import '../tool/chrome_model.dart';

void main() {
  group('chrome_model.ChromeType', chromeTypeTests);
  group('chrome_model.ChromeReturnType', chromeReturnTypeTests);
  group('chrome_model.ChromeProperty', chromePropertyTests);
  group('chrome_model.ChromeMethod', chromeMethodTests);
  group('chrome_model.ChromeLibrary', chromeLibraryTests);
  group('chrome_model.ChromeEvent', chromeEventTests);
  group('chrome_model.ChromeEnumType', chromeEnumTypeTests);
  group('chrome_model.ChromeEnumEntry', chromeEnumEntryTests);
  group('chrome_model.ChromeDeclaredType', chromeDeclaredTypeTests);
}

void chromeTypeTests() {
  test('isAny', () {
    ChromeType chromeType = new ChromeType(type: "var",
        refName: "SomeType");
    expect(chromeType.isAny, isTrue);
    expect(chromeType.isReferencedType, isTrue);
    expect(chromeType.toReturnString(), equals("SomeType"));
    expect(chromeType.toString(), equals("SomeType"));

    chromeType = new ChromeType(type: "var");
    expect(chromeType.isAny, isTrue);
    expect(chromeType.isReferencedType, isFalse);
    expect(chromeType.toReturnString(), equals("dynamic"));
    expect(chromeType.toString(), equals("var"));
  });

  test('isString', () {
    ChromeType chromeType = new ChromeType(type: "String");
    expect(chromeType.isString, isTrue);
  });

  test('isList', () {
    ChromeType chromeType = new ChromeType(type: "List");
    expect(chromeType.isString, isFalse);
    expect(chromeType.isList, isTrue);
    expect(chromeType.getReturnStringTypeParams(), equals(""));
    expect(chromeType.toReturnString(), equals("List"));
    expect(chromeType.toString(), equals("List"));
  });

  test('List<SomeType>', () {
    ChromeType chromeTypeList = new ChromeType(type: "List");
    ChromeType chromeTypeSomeType = new ChromeType(type: "var",
        refName: "SomeType");
    chromeTypeList.parameters.add(chromeTypeSomeType);
    expect(chromeTypeList.isString, isFalse);
    expect(chromeTypeList.isList, isTrue);
    expect(chromeTypeList.getReturnStringTypeParams(), equals("<SomeType>"));
    expect(chromeTypeList.toReturnString(), equals("List<SomeType>"));
    expect(chromeTypeList.toString(), equals("List<SomeType>"));
  });

  test('List<SomeType, SomeOtherType>', () {
    ChromeType chromeTypeList = new ChromeType(type: "List");
    ChromeType chromeTypeSomeType = new ChromeType(type: "var",
        refName: "SomeType");
    ChromeType chromeTypeSomeOtherType = new ChromeType(type: "var",
        refName: "SomeOtherType");
    chromeTypeList.parameters.add(chromeTypeSomeType);
    chromeTypeList.parameters.add(chromeTypeSomeOtherType);
    expect(chromeTypeList.isString, isFalse);
    expect(chromeTypeList.isList, isTrue);
    expect(chromeTypeList.getReturnStringTypeParams(),
        equals("<SomeType, SomeOtherType>"));
    expect(chromeTypeList.toReturnString(),
        equals("List<SomeType, SomeOtherType>"));
    expect(chromeTypeList.toString(), equals("List<SomeType, SomeOtherType>"));
  });

}

void chromeReturnTypeTests() {
  test('basic usage', () {
    ChromeReturnType chromeReturnType =
        new ChromeReturnType("awesomeness",
            <ChromeType>[ChromeType.JS_OBJECT, ChromeType.VAR]);
    expect(chromeReturnType.name, equals("awesomeness"));
    expect(chromeReturnType.params, hasLength(2));
    expect(chromeReturnType.params[0], equals(ChromeType.JS_OBJECT));
    expect(chromeReturnType.params[1], equals(ChromeType.VAR));
  });
}

void chromePropertyTests() {
  test('name with underscore', () {
    ChromeProperty chromeProperty =
        new ChromeProperty("_url", ChromeType.STRING);
    expect(chromeProperty.idlName, equals("_url"));
    expect(chromeProperty.name, equals("url"));
  });
}

void chromeMethodTests() {
  test('chrome method mixed optional and required with callback', () {
    ChromeMethod chromeMethod = new ChromeMethod();
    chromeMethod.name = "getType";

    ChromeType returns = new ChromeType(type: "Future", refName: "Map");
    ChromeType param1 = new ChromeType(type: "String");
    param1.optional = true;
    ChromeType param2 = new ChromeType(type: "String");
    param2.optional = false;

    chromeMethod.params.add(param1);
    chromeMethod.params.add(param2);
    chromeMethod.returns = returns;

    expect(chromeMethod.usesCallback, isTrue);
    expect(chromeMethod.requiredParams.toList(), hasLength(1));
    expect(chromeMethod.optionalParams.toList(), hasLength(1));
  });
}

void chromeLibraryTests() {
  test('basic', () {
    ChromeLibrary chromeLibrary = new ChromeLibrary("window");

    chromeLibrary.addImport("a");
    chromeLibrary.addImport("c");
    chromeLibrary.addImport("b");

    expect(chromeLibrary.imports[0], equals("a"));
    expect(chromeLibrary.imports[1], equals("b"));
    expect(chromeLibrary.imports[2], equals("c"));

    ChromeType chromeEventType = new ChromeType(type: "String");
    chromeEventType.name = "calcit";
    chromeLibrary.addEventType(chromeEventType);

    expect(chromeLibrary.eventTypes.any((e) => e.name == "calcit"), isTrue);

    ChromeProperty chromeProperty = new ChromeProperty("blah",
        ChromeType.STRING);
    chromeProperty.nodoc = false;
    chromeLibrary.properties.add(chromeProperty);

    expect(chromeLibrary.filteredProperties.toList()
        .any((e)=> e.name == "blah"), isTrue);

    ChromeEnumType enumType = new ChromeEnumType();
    enumType.name = "somevar";
    enumType.type = "var";
    enumType.refName = "somevar";
    chromeLibrary.enumTypes.add(enumType);
    expect(chromeLibrary.isEnumType(enumType), isTrue);
    expect(chromeLibrary.isEnumType(ChromeType.STRING), isFalse);
  });
}

void chromeEventTests() {
  test('calculateType one parameter', () {
    ChromeLibrary chromeLibrary = new ChromeLibrary('window');
    ChromeEvent chromeEvent = new ChromeEvent();
    ChromeType param = new ChromeType(type: "String");
    chromeEvent.parameters.add(param);
    ChromeType calculatedType = chromeEvent.calculateType(chromeLibrary);
    expect(calculatedType, equals(param));
  });

  test('calculateType two parameters', () {
    ChromeLibrary chromeLibrary = new ChromeLibrary('window');
    ChromeEvent chromeEvent = new ChromeEvent();
    chromeEvent.name = "openWindow";
    ChromeType param1 = new ChromeType(type: "String");
    param1.name = "param1";
    param1.optional = false;
    // TODO: test documentation better.
    param1.documentation = "";
    chromeEvent.parameters.add(param1);
    ChromeType param2 = new ChromeType(type: "String");
    param2.name = "param2";
    param2.optional = true;
    param2.documentation = "";
    chromeEvent.parameters.add(param2);

    ChromeType calculatedType = chromeEvent.calculateType(chromeLibrary);
    expect(calculatedType, isNotNull);
    expect(calculatedType.arity, equals(2));
    expect(calculatedType.name, equals("OpenWindowEvent"));
    expect(calculatedType.refName, equals("OpenWindowEvent"));
    expect(calculatedType.properties, hasLength(2));
    expect(calculatedType.properties.any((e)=> e.name == "param1"), isTrue);
    expect(calculatedType.properties.any((e)=> e.name == "param2"), isTrue);
  });
}

void chromeEnumTypeTests() {
  test('basic', () {
    ChromeEnumEntry chromeEnumEntry = new ChromeEnumEntry("NO_VALUE", "NODOC");
    ChromeEnumType enumType = new ChromeEnumType();
    enumType.name = "enumType";
    expect(chromeEnumEntry.name, equals("NO_VALUE"));
    expect(chromeEnumEntry.documentation, equals("NODOC"));
    enumType.values.add(chromeEnumEntry);
    expect(enumType.values.any((e) => e.name == "NO_VALUE"), isTrue);
    expect(enumType.values.any((e) => e.documentation == "NODOC"), isTrue);
  });
}

void chromeEnumEntryTests() {
  test('basic', () {
    ChromeEnumEntry chromeEnumEntry = new ChromeEnumEntry("NO_VALUE", "NODOC");
    expect(chromeEnumEntry.name, equals("NO_VALUE"));
    expect(chromeEnumEntry.documentation, equals("NODOC"));
  });
}

void chromeDeclaredTypeTests() {
  test("basic", () {
    ChromeDeclaredType chromeType = new ChromeDeclaredType();
    chromeType.type = "List";
    chromeType.refName = "List";
    expect(chromeType.isString, isFalse);
    expect(chromeType.isList, isTrue);
  });
}