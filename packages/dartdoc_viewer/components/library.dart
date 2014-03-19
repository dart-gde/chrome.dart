// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library web.library;

import 'package:dartdoc_viewer/item.dart';
import 'package:polymer/polymer.dart';
import 'package:dartdoc_viewer/lazy_load.dart';
import 'package:dartdoc_viewer/member.dart';

/**
 * Implementation of the main view for a Dart library.
 *
 * Because libraries can be large (such as dart:html) we populate the lists of
 * data lazily. This allows the initial page to be rendered very quickly.
 */
@CustomTag("dartdoc-library")
class LibraryElement extends MemberElement {
  final ObservableList lazyOperators = new ObservableList();
  final ObservableList lazyVariables = new ObservableList();
  final ObservableList lazyFunctions = new ObservableList();
  final ObservableList lazyClasses = new ObservableList();
  final ObservableList lazyTypedefs = new ObservableList();
  final ObservableList lazyErrors = new ObservableList();

  LazyListLoader _loader;

  LibraryElement.created() : super.created();

  wrongClass(newItem) => newItem is! Library;

  get defaultItem => _defaultItem;
  static final _defaultItem =
      new Library.forPlaceholder({ 'name': 'loading', 'preview': 'loading' });

  leftView() {
    super.leftView();
    if (_loader != null) {
      _loader.cancel();
      _loader = null;
    }
  }

  itemChanged() {
    super.itemChanged();

    if (item == null) return;

    if (_loader != null) _loader.cancel();
    _loader = new LazyListLoader([
      item.operators.content,
      item.variables.content,
      item.functions.content,
      item.classes.content,
      item.typedefs.content,
      item.errors.content
    ], [
      lazyOperators,
      lazyVariables,
      lazyFunctions,
      lazyClasses,
      lazyTypedefs,
      lazyErrors
    ])..start(eager: viewer.activeMember != '');
  }
}
