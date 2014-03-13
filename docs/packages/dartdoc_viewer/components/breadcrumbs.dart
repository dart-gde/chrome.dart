// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library web.breadcrumbs;

import 'package:dartdoc_viewer/item.dart';
import 'package:polymer/polymer.dart';
import 'package:dartdoc_viewer/app.dart';
import 'package:dartdoc_viewer/shared.dart';

@CustomTag('dartdoc-breadcrumbs')
class Breadcrumbs extends PolymerElement with ChangeNotifier  {
  @reflectable @observable List<Item> get breadcrumbs => __$breadcrumbs; List<Item> __$breadcrumbs; @reflectable set breadcrumbs(List<Item> value) { __$breadcrumbs = notifyPropertyChange(#breadcrumbs, __$breadcrumbs, value); }
  @reflectable @observable Item get lastCrumb => __$lastCrumb; Item __$lastCrumb; @reflectable set lastCrumb(Item value) { __$lastCrumb = notifyPropertyChange(#lastCrumb, __$lastCrumb, value); }

  Breadcrumbs.created() : super.created();

  get syntax => defaultSyntax;
  bool get applyAuthorStyles => true;

  void enteredView() {
    super.enteredView();
    registerObserver('viewer', viewer.changes.listen((changes) {
      for (var change in changes) {
        if (change.name == #currentPage || change.name == #homePage) {
          _updateBreadcrumbs();
          return;
        }
      }
    }));
    _updateBreadcrumbs();
  }

  void _updateBreadcrumbs() {
    breadcrumbs = [];
    lastCrumb = null;
    if (viewer.homePage != null && viewer.currentPage != null) {
      for (var p = viewer.currentPage; p != viewer.homePage; p = p.owner) {
        breadcrumbs.add(p);
      }
      breadcrumbs = breadcrumbs.reversed.toList();
      if (breadcrumbs.isNotEmpty) {
        lastCrumb = breadcrumbs.removeLast();
      }
    }

    // Fire an event to tell our parent that we updated, in case it wants to
    // adjust any layout in light of our new size.
    fire('update');
  }
}
