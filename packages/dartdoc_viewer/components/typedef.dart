// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library web.typedef;

import 'package:dartdoc_viewer/item.dart';
import 'package:dartdoc_viewer/location.dart';
import 'package:polymer/polymer.dart';
import 'package:dartdoc_viewer/member.dart';

@CustomTag("dartdoc-typedef")
class TypedefElement extends MemberElement {
  TypedefElement.created() : super.created();

  bool wrongClass(newItem) => newItem is! Typedef;
  Typedef get defaultItem => _defaultItem;
  static final _defaultItem =
      new Typedef({'name' : 'loading', 'qualifiedName' : 'loading'});

  String get prefixedLocation => locationPrefixed(item.type.location);
}
