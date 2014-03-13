// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library web.library_panel;

import 'package:polymer/polymer.dart';
import 'package:dartdoc_viewer/member.dart';

/// An element in a page's minimap displayed on the right of the page.
@CustomTag("dartdoc-library-panel")
class LibraryPanel extends DartdocElement {
  LibraryPanel.created() : super.created();

  shadowRootReady(root, template) {
    super.shadowRootReady(root, template);

    registerObserver('viewer', viewer.changes.listen((changes) {
      for (var change in changes) {
        if (change.name == #currentPage) {
          _updateActiveLibrary(null);
          return;
        }
      }
    }));

    onMutation(shadowRoot).then(_updateActiveLibrary);
  }

  void _updateActiveLibrary(_) {
    for (var a in shadowRoot.querySelectorAll('a')) {
      a.classes.toggle('active', a.text == viewer.currentPage.decoratedName);
    }
  }
}
