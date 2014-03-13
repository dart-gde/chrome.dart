// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library web.results;

import 'package:dartdoc_viewer/data.dart';
import 'package:dartdoc_viewer/search.dart';
import 'package:dartdoc_viewer/location.dart';
import 'package:polymer/polymer.dart';
import 'dart:html';

/**
 * An HTML representation of a Search Result.
 */
@CustomTag("search-result")
class Result extends AnchorElement with Polymer, ChangeNotifier {
  @reflectable @published SearchResult get item => __$item; SearchResult __$item; @reflectable set item(SearchResult value) { __$item = notifyPropertyChange(#item, __$item, value); }

  /// The name of this member.
  @reflectable @observable String get descriptiveName => __$descriptiveName; String __$descriptiveName; @reflectable set descriptiveName(String value) { __$descriptiveName = notifyPropertyChange(#descriptiveName, __$descriptiveName, value); }

  /// The type of this member.
  @reflectable @observable String get descriptiveType => __$descriptiveType; String __$descriptiveType; @reflectable set descriptiveType(String value) { __$descriptiveType = notifyPropertyChange(#descriptiveType, __$descriptiveType, value); }

  /// The library containing this member.
  @reflectable @observable String get outerLibrary => __$outerLibrary; String __$outerLibrary; @reflectable set outerLibrary(String value) { __$outerLibrary = notifyPropertyChange(#outerLibrary, __$outerLibrary, value); }

  Result.created() : super.created() {
    polymerCreated();
  }

  itemChanged() {
    descriptiveName = _getDescriptiveName();
    descriptiveType = _getDescriptiveType();
    outerLibrary = _getOuterLibrary();
  }

  bool get applyAuthorStyles => true;

  String get membertype => item == null ? 'none' : item.type;
  String get qualifiedname => item == null ? 'none' : item.element;

  String _getDescriptiveName() {
    if (qualifiedname == null) return '';
    // TODO(alanknight) : Look at unifying this with Location
    var name = qualifiedname.split('.');
    if (membertype == 'library') {
      var lib = pageIndex[qualifiedname];
      if (lib == null) return '';
      return lib.decoratedName;
    } else if (membertype == 'constructor') {
      // Constructor names have the class name followed by a hyphen followed
      // by the constructor name. Unnamed constructors have nothing after the
      // hyphen. We want to display just the constructor name, or nothing.
      var className = name[name.length - 2];
      var constructorNameWithClass = name.last;
      var constructorName = constructorNameWithClass.split("-").last;
      return constructorName.isEmpty ?
          className : "$className.$constructorName";
    }
    return name.last;
  }

  String _getDescriptiveType() {
    if (item == null) return '';
    var loc = new DocsLocation(item.element);
    if (membertype == 'class')
      return 'class';
    if (membertype == 'library') {
      return loc.packageName == null ?
          'library' : 'library in ${loc.packageName}';
    }
    var ownerType = searchIndex.map[loc.parentQualifiedName];
    if (ownerType == 'class')
      return '$membertype in ${loc.parentName}';
    return membertype;
  }

  String _getOuterLibrary() {
    if (membertype == 'library') return '';
    var loc = new DocsLocation(qualifiedname);
    var libraryName = loc.libraryQualifiedName;
    var library = pageIndex[libraryName];
    if (library == null) return '';
    var packageName = loc.packageName;
    if (packageName == null) {
      return 'library ${library.decoratedName}';
    } else {
      return 'library ${library.decoratedName} in ${packageName}';
    }
  }
}
