library chrome_idl_convert_test;

import 'package:unittest/unittest.dart';

import '../tool/chrome_idl_parser.dart';
import '../tool/chrome_idl_convert.dart';
import '../tool/chrome_idl_model.dart';
import '../tool/chrome_model.dart';

ChromeIDLParser chromeIDLParser;

void main() {
  setUp(() {
    chromeIDLParser = new ChromeIDLParser();
  });
  group('ChromeIDLParser convert', chromeIDLConvertTests);
}

void chromeIDLConvertTests() {
  test('Convert Test', () {
    String testData ="""// Copyright (c) 2013 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Use the <code>chrome.power</code> API to override the system's power
// management features.
namespace power {
  [noinline_doc] enum Level {
    // Prevent the system from sleeping in response to user inactivity.
    system,

    // Prevent the display from being turned off or dimmed or the system
    // from sleeping in response to user inactivity.
    display
  };

  interface Functions {
    // Requests that power management be temporarily disabled. |level|
    // describes the degree to which power management should be disabled.
    // If a request previously made by the same app is still active, it
    // will be replaced by the new request.
    static void requestKeepAwake(Level level);

    // Releases a request previously made via requestKeepAwake().
    static void releaseKeepAwake();
  };
};""";

    IDLNamespaceDeclaration namespace =
        chromeIDLParser.namespaceDeclaration.parse(testData);

    ChromeLibrary chromeLibrary = convert(namespace);
    expect(chromeLibrary, isNotNull);
    // TODO: finish testing this object.
  });
}