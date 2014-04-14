// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library dartdoc_viewer.analytics;

import 'dart:js';

import 'location.dart';

/// Used to send analytics information for dartdoc-viewer
class Tracker {
  String _lastLoc;

  /// Uses the current location to send analytics inforamtion.
  ///
  /// Excludes members within a class
  ///
  /// Does not track sequential visits to members within a class
  void track(String locationHref) {
    var url = Uri.parse(locationHref);
    var path = url.path;
    if (url.query != '') {
      path = '$path?${url.query}';
    }

    if (url.fragment != '') {
      path = '$path#${url.fragment}';
    }

    var atIndex = path.indexOf(ANCHOR_PLUS_PREFIX);
    if (atIndex > 0) {
      path = path.substring(0, atIndex);
    }

    if (_lastLoc != path) {
      _lastLoc = path;
      _track();
    }
  }

  void _track() {
    var ga = context['ga'];
    if (ga != null) {
      var data = new JsObject.jsify({ 'page': _lastLoc });
      context.callMethod('ga', ['send', 'pageview', data]);
    }
  }
}
