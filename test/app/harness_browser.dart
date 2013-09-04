library harness_browser;

import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data' as typed_data;

import 'package:unittest/html_enhanced_config.dart';
import 'package:unittest/unittest.dart';
import 'package:logging/logging.dart';
import 'package:js/js.dart' as js;

import 'package:chrome/app.dart';

import 'src/test_app.dart' as app;
import 'src/test_storage.dart' as storage;

part 'src/test_file_system.dart';
part 'src/test_i18n.dart';
part 'src/test_power.dart';
part 'src/test_push_messaging.dart';
part 'src/test_runtime.dart';
part 'src/test_serial.dart';
part 'src/test_socket.dart';

void main() {
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
      runtime.reload();
    }
  });

  app.main();
  storage.main();

  new TestFileSystem().main();
  new TestI18N().main();
  new TestPower().main();
  new TestPushMessaging().main();
  new TestRuntime().main();
  new TestSerial().main();
  new TestSocket().main();
}
