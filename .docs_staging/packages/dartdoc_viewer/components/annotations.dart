// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library web.annotations;

import 'package:dartdoc_viewer/item.dart';
import 'package:polymer/polymer.dart';
import 'package:dartdoc_viewer/member.dart';

// TODO(jmesserly): just extend HtmlElement?
@CustomTag('dartdoc-annotation')
class AnnotationElement extends PolymerElement with ChangeNotifier  {
  @reflectable @published AnnotationGroup get annotations => __$annotations; AnnotationGroup __$annotations; @reflectable set annotations(AnnotationGroup value) { __$annotations = notifyPropertyChange(#annotations, __$annotations, value); }

  AnnotationElement.created() : super.created();

  void annotationsChanged() {
    this.children.clear();
    if (annotations == null || annotations.annotations.isEmpty) return;
    // TODO(jmesserly): we should be able to build this content via template
    var out = new StringBuffer();
    for (var annotation in annotations.annotations) {
      if (annotation.link.isDocumented) {
        out.write('<a href="#${annotation.link.location}">'
            '${annotation.link.simpleType}</a>');
      } else {
        out.write(annotation.link.simpleType);
      }
      var hasParams = annotation.parameters.isNotEmpty;
      if (hasParams) out.write("(");
      out.write(annotation.parameters.join(", "));
      if (hasParams) out.write(")");
      if (annotation != annotations.annotations.last) {
        out.write(", ");
      }
    }
    if (annotations.supportedBrowsers.isNotEmpty) {
      out.write("<br>Supported on: ");
      out.write(annotations.supportedBrowsers.join(", "));
    }
    this.setInnerHtml(out.toString(), treeSanitizer: nullSanitizer);
  }
}
