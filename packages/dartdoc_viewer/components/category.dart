// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library web.category;

import 'package:polymer/polymer.dart';
import 'package:dartdoc_viewer/item.dart';
import 'package:dartdoc_viewer/app.dart';
import 'package:dartdoc_viewer/member.dart';
import 'dart:html';

/**
 * An HTML representation of a Category.
 *
 * Used as a placeholder for an CategoryItem object.
 */
 @CustomTag("dartdoc-category")
class CategoryElement extends DartdocElement with ChangeNotifier  {
  @reflectable @published Category get category => __$category; Category __$category; @reflectable set category(Category value) { __$category = notifyPropertyChange(#category, __$category, value); }

  // Note: only one of these is used at any given time, the other two will be
  // null. We do it this way to keep the <template if> outside of the
  // <template repeat>, so the repeat is more strongly typed.
  @reflectable @published ObservableList<Item> get items => __$items; ObservableList<Item> __$items; @reflectable set items(ObservableList<Item> value) { __$items = notifyPropertyChange(#items, __$items, value); }
  @reflectable @published ObservableList<Variable> get variables => __$variables; ObservableList<Variable> __$variables; @reflectable set variables(ObservableList<Variable> value) { __$variables = notifyPropertyChange(#variables, __$variables, value); }
  @reflectable @published ObservableList<Method> get methods => __$methods; ObservableList<Method> __$methods; @reflectable set methods(ObservableList<Method> value) { __$methods = notifyPropertyChange(#methods, __$methods, value); }

  @reflectable @observable bool get hasItems => __$hasItems; bool __$hasItems = false; @reflectable set hasItems(bool value) { __$hasItems = notifyPropertyChange(#hasItems, __$hasItems, value); }

  @reflectable @observable String get title => __$title; String __$title; @reflectable set title(String value) { __$title = notifyPropertyChange(#title, __$title, value); }
  @reflectable @observable String get stylizedName => __$stylizedName; String __$stylizedName; @reflectable set stylizedName(String value) { __$stylizedName = notifyPropertyChange(#stylizedName, __$stylizedName, value); }

  @reflectable @observable String get accordionStyle => __$accordionStyle; String __$accordionStyle; @reflectable set accordionStyle(String value) { __$accordionStyle = notifyPropertyChange(#accordionStyle, __$accordionStyle, value); }
  @reflectable @observable String get divClass => __$divClass; String __$divClass; @reflectable set divClass(String value) { __$divClass = notifyPropertyChange(#divClass, __$divClass, value); }
  @reflectable @observable String get caretStyle => __$caretStyle; String __$caretStyle; @reflectable set caretStyle(String value) { __$caretStyle = notifyPropertyChange(#caretStyle, __$caretStyle, value); }
  @reflectable @observable String get lineHeight => __$lineHeight; String __$lineHeight; @reflectable set lineHeight(String value) { __$lineHeight = notifyPropertyChange(#lineHeight, __$lineHeight, value); }

  CategoryElement.created() : super.created() {
    registerObserver('viewer', viewer.changes.listen((changes) {
      if (changes.any((c) => c.name == #isDesktop)) {
        _isExpanded = viewer.isDesktop;
      }
    }));
    _isExpanded = viewer.isDesktop;
  }

  bool __isExpanded;
  bool get _isExpanded => __isExpanded;
  void set _isExpanded(bool expanded) {
    __isExpanded = expanded;
    accordionStyle = expanded ? '' : 'collapsed';
    divClass = expanded ? 'collapse in' : 'collapse';
    caretStyle = expanded ? '' : 'caret';
    lineHeight = expanded ? 'auto' : '0px';
  }

  void categoryChanged() {
    title = category == null ? '' : category.name;
    stylizedName = category == null ? '' : category.name.replaceAll(' ', '-');
  }

  void itemsChanged() => _updateHasItems();
  void variablesChanged() => _updateHasItems();
  void methodsChanged() => _updateHasItems();

  void _updateHasItems() {
    hasItems = items != null && items.isNotEmpty ||
        variables != null && variables.isNotEmpty ||
        methods != null && methods.isNotEmpty;
  }

  void hideShow(event, detail, AnchorElement target) {
    _isExpanded = !_isExpanded;
  }
}
