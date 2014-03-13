// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library web.parameters;

import 'dart:html';
import 'package:dartdoc_viewer/item.dart';
import 'package:dartdoc_viewer/location.dart';
import 'package:polymer/polymer.dart';
import 'package:dartdoc_viewer/member.dart';
import 'type.dart';

@CustomTag("dartdoc-parameter")
class ParameterElement extends DartdocElement with ChangeNotifier  {
  @reflectable @published List<Parameter> get parameters => __$parameters; List<Parameter> __$parameters = const []; @reflectable set parameters(List<Parameter> value) { __$parameters = notifyPropertyChange(#parameters, __$parameters, value); }

  ParameterElement.created() : super.created();

  void parametersChanged() {
    var required = [], optional = [];
    if (parameters != null) {
      for (var p in parameters) {
        (p.isOptional ? optional : required).add(p);
      }
    }

    this.children.clear();
    this.appendText('(');
    addParameters(required, 'required', optional);
    addParameters(optional, 'optional', optional);
    this.appendText(')');
  }

  /// Adds [elements] to the tag with class [className].
  void addParameters(List<Parameter> elements, String className,
      List<Parameter> optional) {
    if (elements.isEmpty) return;
    var outerSpan = new SpanElement();
    if (className == 'optional') {
      var optionalOpeningDelimiter =
          optional.isEmpty ? '' : optional.first.isNamed ? '{' : '[';
      outerSpan.appendText(optionalOpeningDelimiter);
    }
    for (var element in elements) {
      // Since a dartdoc-annotation cannot be instantiated from Dart code,
      // the annotations must be built manually.
      element.annotations.annotations.forEach((annotation) {
        var anchor = new AnchorElement()
          ..text = '@${annotation.simpleType}'
          ..href = '${locationPrefixed(annotation.location)}';
        outerSpan.append(anchor);
        outerSpan.appendText(' ');
      });
      // Skip dynamic as an outer parameter type (but not as generic)
      var space = '';
      if (!element.type.isDynamic) {
        outerSpan.append(new TypeElement()..type = element.type);
        space = ' ';
      }
      var parameterName = new AnchorElement()
        ..text = element.name
        ..href = element.prefixedAnchorHref
        ..id = element.anchorHrefLocation.anchor;
      outerSpan.appendText(space);
      outerSpan.append(parameterName);
      outerSpan.appendText(element.decoration);
      if (className == 'required' && optional.isNotEmpty ||
          element != elements.last) {
        outerSpan.appendText(', ');
      }
    }
    if (className == 'optional') {
      var optionalClosingDelimiter =
          optional.isEmpty ? '' : optional.first.isNamed ? '}' : ']';
      outerSpan.appendText(optionalClosingDelimiter);
    }
    this.append(outerSpan);
  }
}
