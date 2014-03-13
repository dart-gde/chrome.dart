// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library dartdoc_viewer.analytics;

import 'dart:js';

/// Used to send analytics information for dartdoc-viewer
class Tracker {
  String _lastLoc;

  /// Uses the current location to send analytics inforamtion.
  ///
  /// Excludes members within a class
  ///
  /// Does not track sequential visits to members within a class
  void track(String locationHref) {
    var atIndex = locationHref.indexOf('@');
    if (atIndex > 0) {
      locationHref = locationHref.substring(0, atIndex);
    }

    if (_lastLoc != locationHref) {
      _lastLoc = locationHref;
      _track();
    }
  }

  void _track() {
    var ga = new JsObject(context['ga']);
    if (ga != null) {
      var data = new JsObject.jsify({ 'page': _lastLoc });
      context.callMethod('ga', ['send', 'pageview', data]);
    }
  }
}
