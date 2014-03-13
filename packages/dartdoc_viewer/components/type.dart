// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library web.type;

import 'dart:html';
import 'package:dartdoc_viewer/item.dart';
import 'package:dartdoc_viewer/location.dart';
import 'package:dartdoc_viewer/search.dart' show searchIndex;
import 'package:polymer/polymer.dart';

// TODO(jmesserly): just extend HtmlElement?
@CustomTag('dartdoc-type')
class TypeElement extends PolymerElement with ChangeNotifier  {
  @reflectable @published NestedType get type => __$type; NestedType __$type; @reflectable set type(NestedType value) { __$type = notifyPropertyChange(#type, __$type, value); }

  Element _child;

  factory TypeElement() => new Element.tag('dartdoc-type');
  TypeElement.created() : super.created();

  void enteredView() {
    super.enteredView();
    typeChanged();
    searchIndex.onLoad(typeChanged);
  }

  void typeChanged() {
    if (_child != null) _child.remove();
    if (type == null || type.isDynamic) return;
    this.append(_child = createInner(type));
  }

  /// Creates an HTML element for a parameterized type.
  static Element createInner(NestedType type) {
    var span = new SpanElement()..classes.add('type');
    if (searchIndex.map.containsKey(type.outer.qualifiedName)) {
      var outer = new AnchorElement()
        ..text = type.outer.simpleType
        ..href = locationPrefixed(type.outer.location);
      span.append(outer);
    } else {
      span.appendText(type.outer.simpleType);
    }
    if (type.inner.isNotEmpty) {
      span.appendText('<');
      for (var element in type.inner) {
        if (element != type.inner.first) span.appendText(', ');
        span.append(createInner(element));
      }
      span.appendText('>');
    }
    return span;
  }
}
