// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library web.page;

import 'package:polymer/polymer.dart';
import 'package:dartdoc_viewer/item.dart';
import 'package:dartdoc_viewer/member.dart';

/** An HTML representation of a page */
@CustomTag("dartdoc-page")
class PageElement extends DartdocElement with ChangeNotifier  {
  @reflectable @published Item get item => __$item; Item __$item; @reflectable set item(Item value) { __$item = notifyPropertyChange(#item, __$item, value); }
  @reflectable @observable bool get isLibrary => __$isLibrary; bool __$isLibrary; @reflectable set isLibrary(bool value) { __$isLibrary = notifyPropertyChange(#isLibrary, __$isLibrary, value); }
  @reflectable @observable bool get isMethod => __$isMethod; bool __$isMethod; @reflectable set isMethod(bool value) { __$isMethod = notifyPropertyChange(#isMethod, __$isMethod, value); }
  @reflectable @observable bool get isClass => __$isClass; bool __$isClass; @reflectable set isClass(bool value) { __$isClass = notifyPropertyChange(#isClass, __$isClass, value); }
  @reflectable @observable bool get isTypedef => __$isTypedef; bool __$isTypedef; @reflectable set isTypedef(bool value) { __$isTypedef = notifyPropertyChange(#isTypedef, __$isTypedef, value); }
  @reflectable @observable bool get isHome => __$isHome; bool __$isHome; @reflectable set isHome(bool value) { __$isHome = notifyPropertyChange(#isHome, __$isHome, value); }

  PageElement.created() : super.created();

  void itemChanged() {
    isLibrary = item is Library;
    isMethod = item is Method;
    isClass = item is Class;
    isTypedef = item is Typedef;
    isHome = item is Home;
  }
}
