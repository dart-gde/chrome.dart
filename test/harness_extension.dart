// TODO(devoncarew): we need to create a general test harness for the extensions
// APIs

library harness_extension;

import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data' as typed_data;

import 'package:unittest/html_enhanced_config.dart';
import 'package:unittest/unittest.dart';
import 'package:logging/logging.dart';
import 'package:js/js.dart' as js;

import 'package:chrome/chrome_ext.dart';

// TODO(devoncarew): we currently can't part these because they're used by the
// harness_browser.dart library. Possibly convert the parts into libraries?
//part 'src/test_i18n.dart';
//part 'src/test_power.dart';
//part 'src/test_push_messaging.dart';
//part 'src/test_runtime.dart';
//part 'src/test_storage.dart';
part 'src/test_windows.dart';

main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord r) {
    StringBuffer sb = new StringBuffer();
    sb
    ..write(r.time.toString())
    ..write(":")
    ..write(r.loggerName)
    ..write(":")
    ..write(r.level.name)
    ..write(":")
    ..write(r.sequenceNumber)
    ..write(": ")
    ..write(r.message.toString());
    logMessage(sb.toString());
  });

  groupSep = '.';
  useHtmlEnhancedConfiguration();

  html.window.onKeyUp.listen((html.KeyboardEvent event) {
    if (event.keyCode == html.KeyCode.R) {
      Runtime.reload();
    }
  });

  // TODO: add these back in
//  new TestI18N().main();
//  new TestPower().main();
//  new TestPushMessaging().main();
//  new TestRuntime().main();
//  new TestStorage().main();
  new TestWindows().main();
}
