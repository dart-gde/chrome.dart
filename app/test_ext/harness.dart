library harness_extension;

import 'dart:html' as html;

import 'package:unittest/html_enhanced_config.dart';
import 'package:unittest/unittest.dart';
import 'package:logging/logging.dart';

import 'package:chrome/chrome_ext.dart' as chrome;

import 'src/test_context_menus.dart' as context_menus;
import 'src/test_windows.dart' as windows;
import 'src/test_browser_action.dart' as browser_action;
import 'src/test_tabs.dart' as tabs;

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord r) => r.toString());

  groupSep = '.';
  useHtmlEnhancedConfiguration();

  html.window.onKeyUp.listen((html.KeyboardEvent event) {
    if (event.keyCode == html.KeyCode.R) {
      chrome.runtime.reload();
    }
  });

  windows.main();
  context_menus.main();
  browser_action.main();
  tabs.main();

  Logger.root.info("leaving main");
}
