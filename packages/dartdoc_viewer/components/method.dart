// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library web.method;

import 'package:polymer/polymer.dart';

import 'package:dartdoc_viewer/member.dart';
import 'package:dartdoc_viewer/item.dart';


@initMethod registerMethodElement() {
  Polymer.register('method-panel', MethodElement);
  Polymer.register('dartdoc-method', MethodElement);
}

/// Shared type for dartdoc-method and method-panel
class MethodElement extends InheritedElement with ChangeNotifier  {
  @reflectable @observable bool get isNotConstructor => __$isNotConstructor; bool __$isNotConstructor; @reflectable set isNotConstructor(bool value) { __$isNotConstructor = notifyPropertyChange(#isNotConstructor, __$isNotConstructor, value); }
  @reflectable @observable String get modifiers => __$modifiers; String __$modifiers; @reflectable set modifiers(String value) { __$modifiers = notifyPropertyChange(#modifiers, __$modifiers, value); }
  @reflectable @observable String get constantModifier => __$constantModifier; String __$constantModifier; @reflectable set constantModifier(String value) { __$constantModifier = notifyPropertyChange(#constantModifier, __$constantModifier, value); }
  @reflectable @observable String get staticModifier => __$staticModifier; String __$staticModifier; @reflectable set staticModifier(String value) { __$staticModifier = notifyPropertyChange(#staticModifier, __$staticModifier, value); }

  MethodElement.created() : super.created();

  bool wrongClass(newItem) => newItem is! Method;

  void itemChanged() {
    super.itemChanged();
    if (item == null) return;

    isNotConstructor = !item.isConstructor;
    constantModifier = item.isConstant ? 'const' : '';
    staticModifier = item.isStatic ? 'static' : '';
    modifiers = constantModifier + staticModifier;
  }

  Method get defaultItem => _defaultItem;

  static final _defaultItem = new Method({
    "name" : "Loading",
    "qualifiedName" : "Loading",
    "comment" : "",
    "parameters" : null,
    "return" : [null],
  }, isConstructor: true);
}
