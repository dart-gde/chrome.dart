library chrome_idl_model;

// namespace
class IDLNamespaceDeclaration {
  /**
   * [name] of the declared namespace.
   */
  final String name;

  /**
   *
   */
  final IDLAttributeDeclaration attribute;
  final IDLFunctionDeclaration functionDeclaration;
  final List<IDLTypeDeclaration> typeDeclarations;
  final IDLEventDeclaration eventDeclaration;
  final List<IDLCallbackDeclaration> callbackDeclarations;
  final List<IDLEnumDeclaration> enumDeclarations;
  final String copyrightSignature;

  /**
   * Namespace documentation
   */
  final List<String> documentation;

  IDLNamespaceDeclaration(this.name, {this.functionDeclaration,
      this.typeDeclarations, this.eventDeclaration, this.callbackDeclarations,
      this.enumDeclarations, this.attribute, this.documentation,
      this.copyrightSignature});

  String toString() =>
      "IDLNamespaceDeclaration($name, $attribute, $documentation)";
}

// interface Functions
class IDLFunctionDeclaration {
  final String name = "Functions";
  final IDLAttributeDeclaration attribute;
  final List<IDLMethod> methods;
  final List<String> documentation;
  IDLFunctionDeclaration(this.methods, {this.attribute, this.documentation});
  String toString() =>
      "IDLFunctionDeclaration($name, $attribute, $methods, $documentation)";
}

// dictionary definition
class IDLTypeDeclaration {
  final String name;
  final IDLAttributeDeclaration attribute;
  final List<IDLField> members;
  final List<IDLMethod> methods;
  final List<String> documentation;

  IDLTypeDeclaration(this.name, this.members, {this.methods, this.attribute,
    this.documentation});

  String toString() =>
    "IDLTypeDeclaration($name, $members, $methods, $attribute, $documentation)";
}

// interface Events
class IDLEventDeclaration {
  final String name = "Events";
  final IDLAttributeDeclaration attribute;
  final List<IDLMethod> methods;
  final List<String> documentation;
  IDLEventDeclaration(this.methods, {this.attribute, this.documentation});
  String toString() =>
      "IDLEventDeclaration($name, $attribute, $methods, $documentation)";
}

/**
 * callback definition
 */
class IDLCallbackDeclaration {
  final String name;
  final List<IDLParameter> parameters;
  final List<String> documentation;

  IDLCallbackDeclaration(this.name, this.parameters, {this.documentation});

  String toString() =>
      "IDLCallbackDeclaration($name, $parameters, $documentation)";
}

/**
 * enum definition
 */
class IDLEnumDeclaration {
  final String name;
  final IDLAttributeDeclaration attribute;
  final List<IDLEnumValue> enums; // TODO: rename enumValue
  final List<String> documentation;

  IDLEnumDeclaration(this.name, this.enums, {this.attribute,
    this.documentation});

  String toString() =>
      "IDLEnumDeclaration($name, $enums, $attribute, $documentation)";
}

class IDLAttributeDeclaration {
  final List<IDLAttribute> attributes;
  IDLAttributeDeclaration(this.attributes);
  String toString() => "IDLAttributeDeclaration($attributes)";
}

class IDLMethod {
  final String name;
  final List<IDLParameter> parameters;
  final IDLType returnType;
  final List<String> documentation;
  final IDLAttributeDeclaration attribute;

  IDLMethod(this.name, this.returnType, this.parameters, {this.attribute,
    this.documentation});

  String toString() =>
      "IDLMethod($name, $returnType, $parameters, $attribute, $documentation})";
}

/**
 * Field
 */
class IDLField {
  final String name;
  final IDLType type;
  final bool isOptional;
  final IDLAttributeDeclaration attribute;
  final List<String> documentation;

  IDLField(this.name, this.type,
      {this.attribute, this.isOptional: false, this.documentation});

  String toString() =>
      "IDLField($name, $type, $attribute, $isOptional, $documentation)";
}

/**
 * Parameter
 */
class IDLParameter {
  final String name;
  final IDLType type;
  final bool isOptional;
  // TODO: rename all variable names of IDLAttributeDeclaration attribute
  // to IDLAttributeDeclaration attributeDeclaration.
  final IDLAttributeDeclaration attribute;

  // This is known by the convention used in chrome idl
  //   static void create(DOMString url, optional CreateWindowOptions options,
  //     optional CreateWindowCallback callback);
  final bool isCallback;

  IDLParameter(this.name, this.type,
      {this.attribute, this.isOptional: false, this.isCallback: false});

  String toString() =>
      "IDLParameter($name, $type, $attribute, $isOptional, $isCallback)";
}

/**
 * Enumeration of the different types of attributes used in the chrome apps
 * idls.
 */
class IDLAttributeTypeEnum {

  final String type;

  const IDLAttributeTypeEnum._(this.type);

  static const List<IDLAttributeTypeEnum> values = const [INSTANCE_OF,
    SUPPORTS_FILTER, NOINLINE_DOC, INLINE_DOC, NODOC, NOCOMPILE, LEGAL_VALUES,
    PERMISSIONS, MAX_LISTENERS];

  /**
   * Example:
   *
   *  [instanceOf=Window]
   */
  static const INSTANCE_OF = const IDLAttributeTypeEnum._("instanceOf");

  /**
   * Example:
   *
   *   [supportsFilters=true]
   */
  static const SUPPORTS_FILTER =
      const IDLAttributeTypeEnum._("supportsFilters");

  /**
   * Example:
   *
   *   [inline_doc]
   */
  static const INLINE_DOC = const IDLAttributeTypeEnum._("inline_doc");

  /**
   * Example:
   *
   *   [noinline_doc]
   */
  static const NOINLINE_DOC = const IDLAttributeTypeEnum._("noinline_doc");


  /**
   * Example:
   *
   *   [nodoc]
   */
  static const NODOC = const IDLAttributeTypeEnum._("nodoc");

  /**
   * Example:
   *
   *   [nocompile]
   *
   * also sometimes paired with [nocompile, nodoc]
   */
  static const NOCOMPILE = const IDLAttributeTypeEnum._("nocompile");

  /**
   * Example:
   *
   *   [legalValues=(16,32)]
   */
  static const LEGAL_VALUES = const IDLAttributeTypeEnum._("legalValues");

  /**
   * Example:
   *
   *   [permissions=downloads]
   */
  static const PERMISSIONS = const IDLAttributeTypeEnum._("permissions");

  /**
   * Example:
   *
   *   [maxListeners=1]
   */
  static const MAX_LISTENERS = const IDLAttributeTypeEnum._("maxListeners");
}

class IDLAttribute {
  /**
   * The type of attribute.
   */
  final IDLAttributeTypeEnum attributeType;
  /**
   * The possible value used on assignment to the attribute.
   */
  final String attributeValue;

  /**
   * The possible [List] of values used on assignment to the attribute.
   */
  final List attributeValues;

  IDLAttribute(this.attributeType, {this.attributeValue, this.attributeValues});

  String toString() =>
      "IDLAttribute($attributeType, $attributeValue, $attributeValues)";
}

class IDLEnumValue {
  final String name;
  final List<String> documentation;

  IDLEnumValue(this.name, {this.documentation});

  String toString() => "IDLEnumValue($name, $documentation)";
}

class IDLType {
  final String name;
  final bool isArray;
  IDLType(this.name, {this.isArray: false});
  String toString() => "IDLType($name, $isArray)";
}
