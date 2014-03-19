// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library web.lazy_load;

import 'dart:html';

/**
 * Lazily populates the lists, limiting the work done per frame.
 * Returns a function that can be called to cancel the load.
 */
class LazyListLoader {
  final _LazyListCopier _copier;

  // TODO(jmesserly): ideally we could tune this based on an actual per-frame
  // budget. Unfortunately we don't have any way of measuring the time spent
  // in the template repeat expansion.
  final int _itemsPerFrame;

  bool _canceled = false;

  LazyListLoader(List<List> src, List<List> dest,
      {int itemsPerFrame: 25})
      : _itemsPerFrame = itemsPerFrame,
        _copier = new _LazyListCopier(src, dest);

  void cancel() {
    _canceled = true;
  }

  void start({bool eager: false}) {
    if (eager) {
      _copier.loadAll();
    } else {
      _loadItems(null);
    }
  }

  void _loadItems(_) {
    if (_canceled) return;

    _copier.load(_itemsPerFrame);
    if (!_copier.isDone) {
      window.animationFrame.then(_loadItems);
    }
  }
}

/**
 * Given two Lists of Lists, a source and a destination, copies items from
 * one to the other. For example given these two lists:
 *
 *     var src = [[1, 2, 3], [4], [5, 6]]
 *     var dest = [[], [], []]
 *
 * Each call to [next] will copy one item. After two calls we'll have:
 *
 *     dest = [[1, 2], [], []]
 *
 * After two more calls:
 *
 *     dest = [[1, 2, 3], [4], []]
 *
 * ... etc until all items are copied.
 *
 * This is used by [LazyListLoader], because a page like `dart:html` has a
 * mixture of top-level variables, functions, classes, and typedefs. We want
 * to load items in order, independently of which category they're in.
 */
class _LazyListCopier {
  int list = 0;
  int offset = 0;

  final List<List> src;
  final List<List> dest;

  _LazyListCopier(this.src, this.dest) {
    for (var list in dest) {
      list.clear();
    }
    _maybeMoveToNextList();
  }

  bool get isDone => list >= src.length;

  void next() {
    if (isDone) return;

    dest[list].add(src[list][offset++]);
    _maybeMoveToNextList();
  }

  _maybeMoveToNextList() {
    while (list < src.length && offset >= src[list].length) {
      list++;
      offset = 0;
    }
  }

  void loadAll() {
    for (int i = 0; i < src.length; i++) {
      dest[i].addAll(src[i]);
    }
  }

  void load(int count) {
    for (int i = 0; i < count && !isDone; i++) {
      next();
    }
  }
}
