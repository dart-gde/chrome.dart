library harness_app;

import 'dart:html' as html;

import 'package:unittest/html_enhanced_config.dart';
import 'package:unittest/unittest.dart';
import 'package:logging/logging.dart';

import 'package:chrome/chrome_app.dart' as chrome;

import 'src/test_app.dart' as app;
import 'src/test_i18n.dart' as i18n;
import 'src/test_power.dart' as power;
import 'src/test_push_messaging.dart' as push_messaging;
import 'src/test_runtime.dart' as runtime;
import 'src/test_serial.dart' as serial;
import 'src/test_socket.dart' as socket;
import 'src/test_storage.dart' as storage;
import 'src/test_sync_file_system.dart' as sync_file_system;
import 'src/test_file_system.dart' as file_system;

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord r) => print(r.toString()));
  Logger.root.fine("harness_app.main()");

  groupSep = '.';
  useHtmlEnhancedConfiguration();

  html.window.onKeyUp.listen((html.KeyboardEvent event) {
    if (event.keyCode == html.KeyCode.R) {
      chrome.runtime.reload();
    }
  });

  app.main();
  i18n.main();
  power.main();
  push_messaging.main();
  runtime.main();
  serial.main();
  socket.main();
  storage.main();
  sync_file_system.main();
  file_system.main();

  Logger.root.fine("harness_app unit tests done");
}
