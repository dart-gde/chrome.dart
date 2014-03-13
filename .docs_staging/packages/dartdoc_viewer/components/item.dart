// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library web.item;

import 'package:polymer/polymer.dart';
import 'package:dartdoc_viewer/item.dart';
import 'package:dartdoc_viewer/member.dart';

/**
 * An HTML representation of a Item.
 *
 * Used as a placeholder for an CategoryItem object.
 */
 @CustomTag("dartdoc-item")
class ItemElement extends MemberElement {
  ItemElement.created() : super.created();

  wrongClass(newItem) => newItem is! Item;

  get defaultItem => _defaultItem;
  static final _defaultItem = new Class.forPlaceholder("loading.loading",
      "loading");
}
