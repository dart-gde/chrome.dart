// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library shared;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:template_binding/template_binding.dart';
import 'package:dartdoc_viewer/components/main.dart';

final defaultSyntax = new _DefaultSyntaxWithEvents();

// TODO(janicejl): JSON path should not be hardcoded.
// Path to the JSON file being read in. This file will always be in JSON
// format and contains the format of the rest of the files.
String sourcePath = 'docs/library_list.json';

/// This is the cut off point between mobile and desktop in pixels.
// TODO(janicejl): Use pixel desity rather than how many pixels. Look at:
// http://www.mobilexweb.com/blog/ipad-mini-detection-for-html5-user-agent
const int DESKTOP_SIZE_BOUNDARY = 1006;


MainElement get dartdocMain => _dartdocMain == null ?
    _dartdocMain = querySelector("#dartdoc-main") :
    _dartdocMain;

MainElement _dartdocMain;


// TODO(jmesserly): for now we disable polymer expressions
class _DefaultSyntaxWithEvents extends BindingDelegate {
  prepareBinding(String path, name, node) =>
      Polymer.prepareBinding(path, name, node, super.prepareBinding);
}
