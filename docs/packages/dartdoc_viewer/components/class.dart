// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library web.class_;

import 'dart:html';
import 'package:dartdoc_viewer/item.dart';
import 'package:polymer/polymer.dart';
import 'package:dartdoc_viewer/app.dart';
import 'package:dartdoc_viewer/lazy_load.dart';
import 'package:dartdoc_viewer/member.dart';


@CustomTag("dartdoc-class")
class ClassElement extends MemberElement {
  static const MAX_SUBCLASSES_TO_SHOW = 3;

  final ObservableList lazyConstructors = new ObservableList();
  final ObservableList lazyOperators = new ObservableList();
  final ObservableList lazyInstanceFunctions = new ObservableList();
  final ObservableList lazyStaticFunctions = new ObservableList();
  final ObservableList lazyInstanceVariables = new ObservableList();
  final ObservableList lazyStaticVariables = new ObservableList();

  LazyListLoader _loader;

  ClassElement.created() : super.created() {
    registerObserver('viewer', viewer.changes.listen((changes) {
      if (changes.any((c) =>
          c.name == #isInherited || c.name == #showObjectMembers)) {
        _loadCategories();
      }
    }));
  }

  Class get defaultItem => _defaultItem;

  static final _defaultItem = new Class.forPlaceholder('loading.loading',
      'loading');

  bool wrongClass(newItem) => newItem is! Class;

  void showSubclass(event, detail, target) {
    for (var e in shadowRoot.querySelectorAll('.hidden')) {
      e.classes.remove('hidden');
    }
    shadowRoot.querySelector('#subclass-button').classes.add('hidden');
  }

  void leftView() {
    super.leftView();
    if (_loader != null) {
      _loader.cancel();
      _loader = null;
    }
  }

  void _loadCategories() {
    if (_loader != null) _loader.cancel();
    var categories =
    _loader = new LazyListLoader(
      item.categories.map((x) => x.filteredContent(viewer.filter)).toList(),
      [
        lazyConstructors,
        lazyOperators,
        lazyInstanceFunctions,
        lazyStaticFunctions,
        lazyInstanceVariables,
        lazyStaticVariables
      ])..start(eager: viewer.activeMember != '');
  }

  void itemChanged() {
    super.itemChanged();

    _loadCategories();

    if (shadowRoot != null) {
      addInterfaces();
      addSubclasses();
    }
  }

  void addInterfaces() {
    var p = shadowRoot.querySelector("#interfaces");
    if (p == null) return;
    p.children.clear();
    if (item.interfaces.isNotEmpty) {
      p.appendText('Implements: ');
      makeLinks(item.interfaces).forEach(p.append);
      p.appendText(' ');
    }
    if (item.superClass != null) {
      p.appendText('Extends: ');
      makeLinks([item.superClass]).forEach(p.append);
    }
  }

  void addSubclasses() {
    if (item.qualifiedName == 'dart.core.Object') return;

    var p = shadowRoot.querySelector("#subclasses");
    p.children.clear();
    final subclasses = item.subclasses;
    var links = makeLinks(subclasses.take(MAX_SUBCLASSES_TO_SHOW));
    if (subclasses.isNotEmpty) {
      p.appendText('Subclasses: ');
      links.forEach(p.append);
    }
    if (subclasses.length <= MAX_SUBCLASSES_TO_SHOW) return;
    var ellipsis = new AnchorElement()
      ..classes = ["btn", "btn-link", "btn-xs"]
      ..id = "subclass-button"
      ..text = "..."
      ..onClick.listen((event) => showSubclass(null, null, null));
    p.append(ellipsis);
    makeLinks(subclasses.skip(MAX_SUBCLASSES_TO_SHOW), hidden: true)
        .forEach(p.append);
  }

  /// Make links for subclasses, interfaces, etc. comma-separated, and hidden
  /// initially if [hidden] is true. Also assume that if [hidden] is false
  /// we should suppress the first comma.
  makeLinks(Iterable classes, {hidden : false}) {
    var first = !hidden;
    return classes.map((cls) => makeLink(cls, hidden: hidden)).fold([],
        (list, classLink) {
          if (first) {
            first = false;
          } else {
            list.add(
                new SpanElement()
                  ..text = ', '
                  ..id = 'subclass-hidden'
                  ..classes = hidden ? ['hidden'] : []);
          }
          list.add(classLink);
          return list;
    });
  }

  AnchorElement makeLink(cls, {bool hidden : false}) =>
    new AnchorElement()
      ..href = "#${cls.location}"
      ..id = 'subclass-hidden'
      ..classes = (hidden ? ['hidden'] : [])
      ..text = cls.simpleType;
}