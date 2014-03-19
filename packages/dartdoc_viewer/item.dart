// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library category_item;

import 'dart:async';
import 'dart:convert';

import 'package:dartdoc_viewer/data.dart';
import 'package:dartdoc_viewer/read_yaml.dart';
import 'package:polymer/polymer.dart';
import 'package:yaml/yaml.dart';
import 'package:dartdoc_viewer/location.dart';
import 'package:dartdoc_viewer/search.dart' show searchIndex;
import 'package:collection/equality.dart';

// TODO(tmandel): Don't hardcode in a path if it can be avoided.
@reflectable const docsPath = 'docs/';

_returnNull() => null;

/**
 * Abstract class for anything that holds values and can be displayed.
 */
@reflectable class Container extends ChangeNotifier {
  final String name;
  @reflectable @observable String get comment => __$comment; String __$comment = '<span></span>'; @reflectable set comment(String value) { __$comment = notifyPropertyChange(#comment, __$comment, value); }
  bool get hasComment => !hasNoComment;
  bool get hasNoComment =>
      comment == '<span></span>' || comment == '<div></div>';

  Container(this.name, [comment]) : __$comment = comment;

  String toString() => "$runtimeType($name)";
}

/** Wraps a comment in span element to make it a single HTML Element. */
String _wrapComment(String comment) =>
    comment == null ? '<div></div>' : '<div>$comment</div>';

/**
 * A [Container] that contains other [Container]s to be displayed.
 */
@reflectable class Category extends Container {
  List<Container> content = [];
  Set<String> memberNames = new Set<String>();
  int inheritedCounter = 0;
  int memberCounter = 0;

  Item memberNamed(String name, {orElse : _returnNull}) =>
      content.firstWhere((x) => x.name == name, orElse: orElse);

  Category.forClasses(List<Map> classes, String name,
      {bool isAbstract: false}) : super(name) {
    if (classes != null) {
      classes.forEach((clazz) =>
        content.add(new Class.forPlaceholder(clazz['qualifiedName'],
            clazz['preview'])));
    }
  }

  Category.forVariables(Map variables, Map getters, Map setters)
      : super('Properties') {
    if (variables != null) {
      variables.keys.forEach((key) {
        memberNames.add(key);
        memberCounter++;
        content.add(new Variable(variables[key]));
      });
    }
    if (getters != null) {
      getters.keys.forEach((key) {
        memberNames.add(key);
        memberCounter++;
        content.add(new Variable(getters[key], isGetter: true));
      });
    }
    if (setters != null) {
      setters.keys.forEach((key) {
        memberNames.add(key);
        memberCounter++;
        content.add(new Variable(setters[key], isSetter: true));
      });
    }
  }

  /// Used to create lists of instance variables or methods by filtering.
  /// In normal usage [members] to contain all methods or all variables, rather
  /// than a mixture.
  Category.forInstanceMembers(List members, name) : super(name) {
    for (var member in members) {
      if (!member.isStatic) {
        memberNames.add(member.name);
        memberCounter++;
        if (member.isInherited) inheritedCounter++;
        content.add(member);
      }
    }
  }

  /// Used to create lists of static variables or methods by filtering.
  ///. In normal usage [members] to contain all methods or all variables, rather
  /// than a mixture.
  Category.forStaticMembers(List members, name) : super(name) {
    for (var member in members) {
      if (member.isStatic) {
        memberNames.add(member.name);
        memberCounter++;
        content.add(member);
      }
    }
  }

  Category.forFunctions(Map yaml, String name, {bool isConstructor: false,
      String className: '', bool isOperator: false, Class owner})
        : super(name) {
    if (yaml != null) {
      yaml.keys.forEach((key) {
        memberNames.add(key);
        memberCounter++;
        content.add(new Method(yaml[key], isConstructor: isConstructor,
            className: className, isOperator: isOperator, owner: owner));
      });
    }
  }

  Category.forTypedefs(Map yaml) : super ('Typedefs') {
    if (yaml != null) {
      yaml.keys.forEach((key) => content.add(new Typedef(yaml[key])));
    }
  }

  /// Adds [item] to [destination] if [item] has not yet been defined within
  /// [destination] and handles inherited comments.
  void addInheritedItem(Class clazz, Item item) {
    if (!memberNames.contains(item.name)) {
      memberCounter++;
      inheritedCounter++;
      content.add(item);
    } else {
      var member = content.firstWhere((innerItem) =>
          innerItem.name == item.name);
      member.addInheritedComment(item);
    }
  }

  bool get hasNonInherited => inheritedCounter < memberCounter;

  List filteredContent(Filter filter) {
    if (filter.shouldShowEverything) return content;
    return content.where((c) => filter.shouldShow(c)).toList();
  }
}

/**
 * Filters [Item]s according to visibility settings, primarily
 * inheritance.
 */
class Filter {
  bool showInherited = true;
  bool showObjectMembers = false;

  bool get shouldShowEverything => showInherited && showObjectMembers;

  bool shouldShow(Item item) {
    if (!item.isInherited) return true;
    var itemWeKnowCanBeInherited = item;
    if (itemWeKnowCanBeInherited.inheritedFrom.startsWith('dart-core.Object')) {
      return showInherited && showObjectMembers;
    } else {
      return showInherited;
    }
  }
}

/**
 * A [Container] synonymous with a page.
 */
@reflectable class Item extends Container {
  /// A list of [Item]s representing the path to this [Item].
  List<Item> path = [];
  @observable final String qualifiedName;
  Item _owner;

  Item(String name, this.qualifiedName, [String comment])
      : super(name, comment);

  /// [Item]'s name with its properties appended for user visible Strings.
  @observable String get decoratedName => name;

  /// [Item]'s name with its properties properly appended for anchor linking.
  @observable String get hashDecoratedName => name;

  /// Adds this [Item] to [pageIndex] and updates all necessary members.
  void addToHierarchy() {
    pageIndex[qualifiedName] = this;
  }

  /// Loads this [Item]'s data and populates all fields.
  Future load() => new Future.value(this);

  /// Adds the comment from [item] to [this].
  void addInheritedComment(Item item) {}

  /// Denotes whether this [Item] is inherited from another [Item] or not.
  @observable bool get isInherited => false;

  /// Creates a link for the href attribute of an [AnchorElement].
  String get linkHref => Uri.encodeFull(qualifiedName);

  /// [linkHref] but with the leading # separator.
  String get prefixedLinkHref => locationPrefixed(linkHref);

  /// The [DocsLocation] for our URI.
  DocsLocation get location => new DocsLocation(qualifiedName);

  /// The link to an anchor within a larger page, if appropriate. So
  /// e.g. instead of `dart-core.Object.toString`,
  /// `dart-core.Object@id_toString`
  DocsLocation get anchorHrefLocation {
    var basic = localLocation;
    var parent = basic.parentLocation;
    if (parent.isEmpty) return parent;
    parent.anchor = parent.toHash(hashDecoratedName);
    return parent;
  }

  /// A location based on the actual page we're in, rather than our inherited
  /// location. e.g. `dart-async.Future.noSuchMethod` rather than
  /// the original method location of `dart-core.Object.noSuchMethod`.
  /// For non-inherited items, this will just be the [location].
  DocsLocation get localLocation => location;

  String get anchorHref => Uri.encodeFull(anchorHrefLocation.withAnchor);

  /// [anchorHref] but with the leading # separator.
  String get prefixedAnchorHref => locationPrefixed(anchorHref);

  bool get isLoaded => true;

  Item memberNamed(String name, {Function orElse : _returnNull}) => _returnNull();

  Item get owner => _owner == null ?
      _owner = pageIndex[location.parentQualifiedName] : _owner;

  /// Return true if [possibleOwner] is anywhere in our chain of owners.
  bool isOwnedBy(Item possibleOwner) {
    if (owner == null || possibleOwner == null) return false;
    if (owner == possibleOwner) return true;
    return owner.isOwnedBy(possibleOwner);
  }

  /// Return the first item in our chain of parents (including ourselves) which
  /// can serve as a page. For most things that's this item itself, but
  /// some, e.g. Variable, cannot.
  Item get firstItemUsableAsPage => this;

  Home get home => owner == null ? null : owner.home;
}

/// Sorts each inner [List] by qualified names.
@reflectable void _sort(List<List<Item>> items) {
  items.forEach((item) {
    item.sort((Item a, Item b) =>
      _compareLibraryNames(a.decoratedName, b.decoratedName));
  });
}

int _compareLibraryNames(String a, String b) {
  var aIsDart = a.startsWith("dart");
  var bIsDart = b.startsWith("dart");
  if (aIsDart == bIsDart) return a.compareTo(b);
  return aIsDart ? -1 : 1;
}


/**
 * An [Item] containing all of the [Library] and [Placeholder] objects.
 */
@reflectable class Home extends Item {
  Item get home => this;
  Home owner;

  /// All libraries being viewed from the homepage.
  List<Item> libraries = [];

  DocsLocation get anchorHrefLocation =>
      new DocsLocation(name == null ? 'home' : name);

  static _nameFromYaml(Map yaml) {
    var package = yaml['packageName'];
    return package == null ? 'home' : package;
  }

  /// The constructor parses the [yaml] input and constructs
  /// [Placeholder] objects to display before loading libraries.
  Home(Map yaml) : super(_nameFromYaml(yaml), _nameFromYaml(yaml),
      _wrapComment(yaml['introduction'])) {

    // TODO(alanknight): Fix complicated, recursive constructor.
    var libraryList = yaml['libraries'];
    var packages = new Map();
    if (isTopLevelHome) {
      libraryList.forEach((each) =>
         packages.putIfAbsent(each['packageName'], () => []).add(each));
    }

    var directLibraries = isTopLevelHome ? packages[''] : libraryList;
    for (Map library in directLibraries) {
      var libraryName = library['name'];
      var newLibrary = new Library.forPlaceholder(library)..home = this;
      this.libraries.add(newLibrary);
      pageIndex[newLibrary.qualifiedName] = newLibrary;
    };
    packages
        ..remove('')
        ..forEach((packageName, libraries) {
          var main = libraries.firstWhere(
              (each) => each['name'] == packageName,
              orElse: () => libraries.first);
          var package = new Home({
              'libraries' : libraries,
              'packageName' : packageName
          });
          package.owner = this;
          this.libraries.add(package);
        });

    _sort([this.libraries]);
    makeMainLibrarySpecial(yaml);
    pageIndex[qualifiedName] = this;
    if (isTopLevelHome) pageIndex[''] = this;
  }

  bool get isTopLevelHome => name == 'home';

  /// Find the main library for a package and put it first in the list,
  /// and get the README for the package from it. The main library is assumed
  /// to be the one that has the same name as the package. If there is no
  /// such library, pick the first one in the (alphabetical) list and get
  /// the README from it.
  void makeMainLibrarySpecial(yaml) {
    var mainLib = libraries.firstWhere((each) => each.name == name,
        orElse: () => libraries.isEmpty ? null : libraries.first);
    if (mainLib != null) {
      libraries..remove(mainLib)..insert(0, mainLib);
      var libs = yaml['libraries'];
      var main = libs.firstWhere((each) => each['name'] == mainLib.name);
      var intro = main['packageIntro'];
      if (intro != null && !intro.isEmpty) {
        comment = _wrapComment(intro);
      }
    }
  }

  Item memberNamed(String name, {Function orElse : _returnNull}) {
    return libraries.firstWhere(
        (each) => each.name == name || each.decoratedName == name,
        orElse: orElse);
  }
}

/// Runs through the member structure and creates path information.
@reflectable void buildHierarchy(Item page, Item previous) {
  if (page.path.isEmpty) {
    page.path
        ..addAll(previous.path)
        ..add(page);
  }
  page.addToHierarchy();
}

/**
 * An [Item] that is lazily loaded.
 */
@reflectable abstract class LazyItem extends Item {
  bool isLoaded = false;
  final String previewComment;

  LazyItem(String qualifiedName, String name, this.previewComment,
      [String comment])
      : super(name, qualifiedName, comment);

  /// Loads this [Item]'s data and populates all fields.
  Future load() {
    if (isLoaded) return new Future.value(this);
    var location = '$docsPath$qualifiedName.' + (isYaml ? 'yaml' : 'json');
    var data = retrieveFileContents(location);
    return data.then((response) {
      var yaml = isYaml ? loadYaml(response) : JSON.decode(response);
      loadValues(yaml);
      buildHierarchy(this, this);
      return new Future.value(this);
    });
  }

  /// Populates all of this [Item]'s fields.
  void loadValues(Map yaml);
}

/**
 * An [Item] that describes a single Dart library.
 */
@reflectable class Library extends LazyItem {
  Category classes;
  Category errors;
  Category typedefs;
  Category variables;
  Category functions;
  Category operators;
  Home home;

  /// Creates a [Library] placeholder object with null fields.
  Library.forPlaceholder(Map map)
      : super(map['qualifiedName'], map['name'], map['preview']);

  /// Normal constructor for testing.
  Library(Map yaml) : super(yaml['qualifiedName'], yaml['name'], '') {
    loadValues(yaml);
    buildHierarchy(this, this);
  }

  void addToHierarchy() {
    super.addToHierarchy();
    for (var category in [classes, typedefs, errors, functions]) {
      for (var clazz in category.content) {
        buildHierarchy(clazz, this);
      }
    }
  }

  void loadValues(Map yaml) {
    this.comment = _wrapComment(yaml['comment']);
    var classes, exceptions, typedefs;
    var allClasses = yaml['classes'];
    if (allClasses != null) {
      classes = allClasses['class'];
      exceptions = allClasses['error'];
      typedefs = allClasses['typedef'];
    }
    this.typedefs = new Category.forTypedefs(typedefs);
    errors = new Category.forClasses(exceptions, 'Exceptions');
    this.classes = new Category.forClasses(classes, 'Classes');
    var setters, getters, methods, operators;
    var allFunctions = yaml['functions'];
    if (allFunctions != null) {
      setters = allFunctions['setters'];
      getters = allFunctions['getters'];
      methods = allFunctions['methods'];
      operators = allFunctions['operators'];
    }
    variables = new Category.forVariables(yaml['variables'], getters, setters);
    functions = new Category.forFunctions(methods, 'Functions');
    this.operators = new Category.forFunctions(operators, 'Operators',
        isOperator: true);
    _sort([this.classes.content, this.errors.content,
           this.typedefs.content, this.variables.content,
           this.functions.content, this.operators.content]);
    isLoaded = true;
  }

  String get decoratedName {
    return isDartLibrary ?
        name.replaceAll('-dom-', '-').replaceAll('-', ':') :
        name.replaceAll('-', '.');
  }

  bool get isDartLibrary => home != null && home.isTopLevelHome;

  Item memberNamed(String name, {Function orElse : _returnNull}) {
    if (name == null || !isLoaded) return orElse();
    for (var category in
        [classes, functions, variables, operators, typedefs, errors]) {
      var member = category.memberNamed(name, orElse: _returnNull);
      if (member != null) return member;
    }
    return orElse();
  }
}

/**
 * An [Item] that describes a single Dart class.
 */
@reflectable class Class extends LazyItem {
  Category functions;
  Category variables;
  Category constructs;
  Category operators;
  LinkableType superClass;
  bool isAbstract;
  AnnotationGroup annotations;
  List<LinkableType> interfaces = [];
  List<LinkableType> subclasses = [];
  List<String> generics = [];

  Category _instanceVariables;
  Category _staticVariables;
  Category _instanceFunctions;
  Category _staticFunctions;

  void flushCaches() {
    _instanceVariables = null;
    _staticVariables = null;
    _instanceFunctions = null;
    _staticFunctions = null;
  }

  Category get constructors => constructs;
  Category get instanceVariables {
    if (_instanceVariables == null) {
      _instanceVariables = new Category.forInstanceMembers(variables.content,
          "Properties");
    }
    return _instanceVariables;
  }
  Category get staticVariables {
    if (_staticVariables == null) {
      _staticVariables = new Category.forStaticMembers(variables.content,
          "Static properties");
    }
    return _staticVariables;
  }
  Category get instanceFunctions {
    if (_instanceFunctions == null) {
      _instanceFunctions = new Category.forInstanceMembers(functions.content,
          "Methods");
    }
    return _instanceFunctions;
  }
  Category get staticFunctions {
    if (_staticFunctions == null) {
      _staticFunctions = new Category.forStaticMembers(functions.content,
          "Static methods");
    }
    return _staticFunctions;
  }

  List<Category> get categories => [constructors, operators,
      instanceFunctions, staticFunctions, instanceVariables, staticVariables];

  /// Creates a [Class] placeholder object with null fields.
  Class.forPlaceholder(String location, String previewComment)
      : super(location, new DocsLocation(location).memberName, previewComment) {
    operators = new Category.forFunctions(null, 'placeholder');
    variables = new Category.forVariables(null, null, null);
    constructs = new Category.forFunctions(null, 'placeholder');
    functions = new Category.forFunctions(null, 'placeholder');
  }

  /// Normal constructor for testing.
  Class(Map yaml) : super(yaml['qualifiedName'], yaml['name'], '') {
    loadValues(yaml);
  }

  /// The link to an anchor within a larger page, if appropriate. For classes
  /// we link directly to their page instead.
  DocsLocation get anchorHrefLocation => location;

  void addToHierarchy() {
    super.addToHierarchy();
    if (isLoaded) {
      [functions, constructs, operators].forEach((category) {
        category.content.forEach((clazz) {
          buildHierarchy(clazz, this);
        });
      });
    }
  }

  void loadValues(Map yaml) {
    flushCaches();
    comment = _wrapComment(yaml['comment']);
    isAbstract = _boolFor('isAbstract', yaml);
    superClass = new LinkableType(yaml['superclass']);
    subclasses = yaml['subclass'] == null ? [] :
      yaml['subclass'].map((item) => new LinkableType(item)).toList();
    annotations = new AnnotationGroup(yaml['annotations']);
    interfaces = yaml['implements'] == null ? [] :
        yaml['implements'].map((item) => new LinkableType(item)).toList();
    var genericValues = yaml['generics'];
    if (genericValues != null) {
      genericValues.keys.forEach((generic) => generics.add(generic));
    }
    var setters, getters, methods, operates, constructors;
    var allMethods = yaml['methods'];
    if (allMethods != null) {
      setters = allMethods['setters'];
      getters = allMethods['getters'];
      methods = allMethods['methods'];
      operates = allMethods['operators'];
      constructors = allMethods['constructors'];
    }
    variables = new Category.forVariables(yaml['variables'], getters, setters);
    functions = new Category.forFunctions(methods, 'Methods', className: name,
        owner: this);
    operators = new Category.forFunctions(operates, 'Operators',
        isOperator: true, className: name, owner: this);
    constructs = new Category.forFunctions(constructors, 'Constructors',
        isConstructor: true, className: name, owner: this);
    var inheritedMethods = yaml['inheritedMethods'];
    var inheritedVariables = yaml['inheritedVariables'];
    if (inheritedMethods != null) {
      setters = inheritedMethods['setters'];
      getters = inheritedMethods['getters'];
      methods = inheritedMethods['methods'];
      operates = inheritedMethods['operators'];
    }
    _addVariable(inheritedVariables);
    _addVariable(setters, isSetter: true);
    _addVariable(getters, isGetter: true);
    _addMethod(methods);
    _addMethod(operates, isOperator: true);
    _sort([this.functions.content, this.variables.content,
           this.constructs.content, this.operators.content]);
    isLoaded = true;
  }

  /// Adds an inherited variable to [variables] if not present.
  void _addVariable(Map items, {isSetter: false, isGetter: false}) {
    if (items != null) {
      items.values.forEach((item) {
        var object = new Variable(item, isSetter: isSetter,
            isGetter: isGetter, inheritedFrom: item['inheritedFrom'],
            commentFrom: item['commentFrom'], owner: this);
        variables.addInheritedItem(this, object);
      });
    }
  }

  /// Adds an inherited method to the correct [Category] if not present.
  void _addMethod(Map items, {isOperator: false}) {
    if (items != null) {
      items.values.forEach((item) {
        var object = new Method(item, isOperator: isOperator,
            inheritedFrom: item['inheritedFrom'],
            commentFrom: item['commentFrom'], className: name, owner: this);
        var location = isOperator ? this.operators : this.functions;
        location.addInheritedItem(this, object);
      });
    }
  }

  String get nameWithGeneric {
    var out = new StringBuffer();
    out.write(name);
    if (generics.isNotEmpty) {
      // Use a non-breaking space character, not &nbsp; because this will
      // get escaped.
      out.writeAll(["<", generics.join(",\u{00A0}"), ">"]);
    }
    return out.toString();
  }

  Item memberNamed(String name, {Function orElse : _returnNull}) {
    if (name == null) return orElse();
    for (var category in
        [annotations, constructs, functions, operators, variables]) {
      var member =  category == null ? null :
          category.memberNamed(name, orElse: _returnNull);
      if (member != null) return member;
    }
    return orElse();
  }

}

/**
 * A collection of [Annotation]s.
 */
@reflectable class AnnotationGroup {
  List<String> supportedBrowsers = [];
  List<Annotation> annotations = [];
  String domName;

  Item memberNamed(String name, {Function orElse : _returnNull}) =>
    annotations.firstWhere((a) => a.qualifiedName == name, orElse: orElse);

  AnnotationGroup(List annotes) {
    var set = new Set();
    if (annotes != null) {
      annotes.forEach((annotation) {
        if (annotation['name'].endsWith('.SupportedBrowser')) {
          supportedBrowsers.add(annotation['parameters'].toList().join(' '));
        } else if (annotation['name'].endsWith('.DomName')) {
          domName = annotation['parameters'].first;
        } else {
          set.add(new Annotation(annotation));
        }
      });
    annotations = set.toList()
        ..sort((a, b) => a.shortName.compareTo(b.shortName));
    }
  }
}

/**
 * A single annotation to an [Item].
 */
@reflectable class Annotation {
  String qualifiedName;
  LinkableType link;
  List<String> parameters;

  Annotation(Map yaml) {
    qualifiedName = yaml['name'];
    link = new LinkableType(qualifiedName);
    parameters = yaml['parameters'] == null ? [] : yaml['parameters'];
  }

  /// Hash by XORing together our name and parameters.
  get hashCode => parameters.fold(
      qualifiedName.hashCode, (a, param) => a ^ param.hashCode);

  operator ==(other) => qualifiedName == other.qualifiedName &&
      const ListEquality().equals(parameters, other.parameters);

  get shortName => new DocsLocation(qualifiedName).lastName;

  toString() => 'Annotation($shortName)';
}

/**
 * An [Item] that describes a Dart member with parameters.
 */
@reflectable class Parameterized extends Item {
  List<Parameter> parameters;

  Parameterized(String name, String qualifiedName, [String comment])
      : super(name, qualifiedName, comment);

  /// Creates [Parameter] objects for each parameter to this method.
  List<Parameter> getParameters(Map parameters) {
    var values = <Parameter>[];
    if (parameters != null) {
      parameters.forEach((name, data) {
        values.add(new Parameter(name, data, this));
      });
    }
    return values;
  }

  Parameter parameterNamed(String name) =>
      parameters.firstWhere((x) => x.name == name, orElse: () => null);

  Item memberNamed(String name, {Function orElse : _returnNull}) {
    var result = parameterNamed(name);
    return result == null ? orElse() : result;
  }
}

/**
 * An [Item] that describes a single Dart typedef.
 */
@reflectable class Typedef extends Parameterized {
  final LinkableType type;
  final AnnotationGroup annotations;
  final String previewComment;

  Typedef(Map yaml)
      : type = new LinkableType(yaml['return']),
        annotations = new AnnotationGroup(yaml['annotations']),
        previewComment = yaml['preview'],
        super(yaml['name'], yaml['qualifiedName'],
            _wrapComment(yaml['comment'])) {
    parameters = getParameters(yaml['parameters']);
  }
}

/**
 * An [Item] that describes a single Dart method.
 */
@reflectable class Method extends Parameterized {
  bool isStatic;
  bool isAbstract;
  bool isConstant;
  bool isConstructor;
  String inheritedFrom;
  String commentFrom;
  String className;
  bool isOperator;
  AnnotationGroup annotations;
  NestedType type;

  Method(Map yaml, {this.isConstructor: false, this.className: '',
      this.isOperator: false, this.inheritedFrom: '',
      String commentFrom: '', owner: null})
        : super(yaml['name'], yaml['qualifiedName'],
            _wrapComment(yaml['comment'])) {
    isStatic = _boolFor('static', yaml);
    isAbstract = _boolFor('abstract', yaml);
    isConstant = _boolFor('constant', yaml);
    commentFrom = commentFrom == '' ? yaml['commentFrom'] : commentFrom;
    type = new NestedType(yaml['return'].first);
    parameters = getParameters(yaml['parameters']);
    annotations = new AnnotationGroup(yaml['annotations']);
    _owner = owner;
  }

  void addToHierarchy() {}

  void addInheritedComment(item) {
    if (hasNoComment) {
      comment = item.comment;
      commentFrom = item.commentFrom;
    }
  }

  bool get isInherited => inheritedFrom != '' && inheritedFrom != null;

  String get decoratedName => isConstructor ?
      (name != '' ? '$className.$name' : className) : name;

  /// [Item]'s name with its properties properly appended for anchor linking.
  /// Overridden to allow for different behavior for constructor "methods"
  /// (we append the className in case the constructor is unnamed).
  String get hashDecoratedName => isConstructor ?
      '$className$CONSTRUCTOR_SEPARATOR$name' : name;

  get linkHref => anchorHref;

  /// A location based on the actual page we're in, rather than our inherited
  /// location.
  DocsLocation get localLocation {
    if (!isInherited || owner == null) return location;
    return owner.location..subMemberName = name;
  }

  // Helper to determine if this method is actually an unnamed constructor.
  bool get isUnnamedConstructor => isConstructor && name == '';

  String toString() => decoratedName;
}

/**
 * A single parameter to a [Method].
 */
@reflectable class Parameter extends Item {

  final bool isOptional;
  final bool isNamed;
  final bool hasDefault;
  final NestedType type;
  final String defaultValue;
  final AnnotationGroup annotations;

  Parameter(String name, Map yaml, [Item owner])
      : isOptional = _boolFor('optional', yaml),
        isNamed = _boolFor('named', yaml),
        hasDefault = _boolFor('default', yaml),
        type = new NestedType(yaml['type'].first),
        defaultValue = yaml['value'],
        annotations = new AnnotationGroup(yaml['annotations']),
        super(name, null) {
    _owner = owner;
  }

  String get decoratedName => '$name$decoration';

  String get decoration {
    if (hasDefault) {
      return isNamed ? ': $defaultValue' : '=$defaultValue';
    }
    return '';
  }

  /// Return true if [possibleOwner] is anywhere in our chain of owners.
  bool isOwnedBy(Item possibleOwner) {
    if (owner == null || possibleOwner == null) return false;
    if (owner == possibleOwner) return true;
    return owner.isOwnedBy(possibleOwner);
  }

  // For a method parameter we use the special anchor @method,parameter
  // because the parameter name may not be unique on the page
  DocsLocation get anchorHrefLocation {
    if (owner == null) return null;

    var ownerLocation = owner.anchorHrefLocation;
    var ownerAnchor = ownerLocation.anchor;
    ownerLocation.anchor = ownerAnchor == null ?
        hashDecoratedName : "$ownerAnchor$hashDecoratedName";
    return ownerLocation;
  }

  String get hashDecoratedName => "$PARAMETER_SEPARATOR$name";

  String get anchorHref => anchorHrefLocation.withAnchor;

  /// Return the first item in our chain of parents (including ourselves) which
  /// can serve as a page. For most things that's this item itself, but
  /// some, e.g. Variable, cannot.
  Item get firstItemUsableAsPage => owner;

  String toString() => "Parameter named $name in $owner";
}

/**
 * A [Container] that describes a single Dart variable.
 */
@reflectable class Variable extends Parameterized {

  final bool isFinal;
  final bool isStatic;
  final bool isAbstract;
  final bool isConstant;
  final bool isGetter;
  final bool isSetter;
  final String inheritedFrom;
  final AnnotationGroup annotations;
  String commentFrom;
  Parameter setterParameter;
  NestedType type;

  Variable(Map yaml, {this.isGetter: false, this.isSetter: false,
      this.inheritedFrom: '', String commentFrom: '', Item owner})
      : isFinal = _boolFor('final', yaml),
        isStatic = _boolFor('static', yaml),
        isConstant = _boolFor('constant', yaml),
        isAbstract = _boolFor('abstract', yaml),
        annotations = new AnnotationGroup(yaml['annotations']),
        super(yaml['name'], yaml['qualifiedName'],
            _wrapComment(yaml['comment'])) {
    this.commentFrom = commentFrom == '' ? yaml['commentFrom'] : commentFrom;
    _owner = owner;
    if (isGetter) {
      type = new NestedType(yaml['return'].first);
    } else if (isSetter) {
      type = new NestedType(yaml['return'].first);
      var parameters = yaml['parameters'];
      var parameterName = parameters.keys.first;
      setterParameter = new Parameter(parameterName,
          parameters[parameterName], this);
    } else {
      type = new NestedType(yaml['type'].first);
    }
  }

  void addInheritedComment(Item item) {
    if (hasNoComment) {
      comment = item.comment;
      if (item is Variable) commentFrom = item.commentFrom;
    }
  }

  bool get isInherited => inheritedFrom != '' && inheritedFrom != null;

  void addToHierarchy() {
    if (inheritedFrom != '') super.addToHierarchy();
  }

  /// A location based on the actual page we're in, rather than our inherited
  /// location, since the qualified name refers to the original.
  DocsLocation get localLocation {
    if (!isInherited || owner == null) return location;
    return owner.location..subMemberName = name;
  }

  List<Parameter> get parameters => setterParameter == null ?
      const [] : [setterParameter];

  /// Return the first item in our chain of parents (including ourselves) which
  /// can serve as a page. For most things that's this item itself, but
  /// some, e.g. Variable, cannot.
  Item get firstItemUsableAsPage => owner;
}

/**
 * A Dart type that potentially contains generic parameters.
 */
@reflectable class NestedType {
  final LinkableType outer;
  final List<NestedType> inner;

  factory NestedType(Map yaml) {
    LinkableType outer;
    var inner = <NestedType>[];
    if (yaml == null) {
      outer = new LinkableType('void');
    } else {
      outer = new LinkableType(yaml['outer']);
      var innerMap = yaml['inner'];
      if (innerMap != null)
      innerMap.forEach((element) => inner.add(new NestedType(element)));
    }
    return new NestedType._(outer, inner);
  }

  NestedType._(this.outer, this.inner);

  bool get isDynamic => outer.isDynamic;

  String toString() => 'NestedType: ${outer.qualifiedName}';
}

/**
 * A Dart type that should link to other [Item]s.
 */
@reflectable class LinkableType {
  /// The resolved qualified name of the type this [LinkableType] represents.
  final DocsLocation loc;

  /// The constructor resolves the library name by finding the correct library
  /// from [libraryNames] and changing [type] to match.
  LinkableType(String type) : this.loc = new DocsLocation(type);

  bool get isDocumented => searchIndex.map.containsKey(qualifiedName);

  /// The simple name for this type.
  String get simpleType => loc.locationWithoutAnchor.name;

  String get location => loc.withoutAnchor;

  String get qualifiedName => location;

  bool get isDynamic => simpleType == 'dynamic';

  String toString() => 'LinkableType: $qualifiedName';
}


bool _boolFor(String key, Map input) {
  var value = input[key];
  if (value == true || value == 'true') return true;
  if (value == null || value == false || value == 'false') return false;
  throw new FormatException("Invalid format, expected boolean key: $key"
      " value: $value");
}
