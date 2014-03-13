// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library web.minimap_library;

import 'package:dartdoc_viewer/item.dart';
import 'package:polymer/polymer.dart';
import 'package:dartdoc_viewer/member.dart';

/// An element in a page's minimap displayed on the right of the page.
@CustomTag("dartdoc-minimap-library")
class MinimapElementLibrary extends MemberElement {
  MinimapElementLibrary.created() : super.created();

  bool wrongClass(newItem) => newItem is! Library;

  Library get defaultItem => _defaultItem;
  static final _defaultItem = new Library.forPlaceholder({
    'name': 'loading', 'qualifiedName': 'loading', 'preview': 'loading' });
}
