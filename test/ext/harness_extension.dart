library harness_extension;

import 'dart:async';
import 'dart:html' as html;

import 'package:unittest/html_enhanced_config.dart';
import 'package:unittest/unittest.dart';
import 'package:logging/logging.dart';

import 'package:chrome/ext.dart';

part 'src/test_browser_action.dart';
part 'src/test_context_menus.dart';
part 'src/test_tabs.dart';
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
    print(sb.toString());
  });

  groupSep = '.';
  useHtmlEnhancedConfiguration();

  html.window.onKeyUp.listen((html.KeyboardEvent event) {
    if (event.keyCode == html.KeyCode.R) {
      runtime.reload();
    }
  });

  new TestBrowserAction().main();
  new TestTabs().main();
  new TestWindows().main();
  new TestContextMenus().main();

  Logger.root.info("leaving main");
}