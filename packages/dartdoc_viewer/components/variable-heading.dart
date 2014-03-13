// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library web.variable_heading;

import 'package:polymer/polymer.dart';
import 'package:dartdoc_viewer/item.dart';
import 'package:dartdoc_viewer/member.dart';

/** An HTML representation of a Variable. */
@CustomTag("variable-heading")
class VariableHeading extends MemberElement with ChangeNotifier  {
  @reflectable @observable String get getter => __$getter; String __$getter; @reflectable set getter(String value) { __$getter = notifyPropertyChange(#getter, __$getter, value); }
  @reflectable @observable String get name => __$name; String __$name; @reflectable set name(String value) { __$name = notifyPropertyChange(#name, __$name, value); }
  @reflectable @observable bool get isNotSetter => __$isNotSetter; bool __$isNotSetter; @reflectable set isNotSetter(bool value) { __$isNotSetter = notifyPropertyChange(#isNotSetter, __$isNotSetter, value); }

  VariableHeading.created() : super.created();

  Variable get defaultItem => _defaultItem;
  static final _defaultItem =
      new Variable({'type' : [null], 'name' : 'loading'});
  bool wrongClass(newItem) => newItem is! Variable;

  void itemChanged() {
    super.itemChanged();
    if (item == null) return;

    getter = item.isGetter ? 'get ' : '';
    isNotSetter = !item.isSetter;

    final n = item.name;
    name = item.isSetter ? n.substring(0, n.length - 1) : n;
  }
}
