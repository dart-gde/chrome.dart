library harness_browser;

import 'dart:html' as html;

import 'package:unittest/html_enhanced_config.dart';
import 'package:unittest/unittest.dart';
import 'package:logging/logging.dart';
import 'package:js/js.dart' as js;

import 'package:chrome/chrome.dart';

part 'src/test_runtime.dart';
part 'src/test_serial.dart';

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

  new TestRuntime().main();
  new TestSerial().main();
}
