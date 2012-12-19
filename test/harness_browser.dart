library harness_browser;

import 'dart:html' as html;

import 'package:unittest/html_enhanced_config.dart';
import 'package:unittest/unittest.dart';
import 'package:logging/logging.dart';
import 'package:js/js.dart' as js;

import 'package:chrome/chrome.dart';

part 'src/test_runtime.dart';

main() {
  Logger.root.level = Level.ALL; 
  Logger.root.on.record.add((LogRecord r) {
    StringBuffer sb = new StringBuffer();
    sb
    ..add(r.time.toString())
    ..add(":")
    ..add(r.loggerName)
    ..add(":")
    ..add(r.level.name)
    ..add(":")
    ..add(r.sequenceNumber)
    ..add(": ")
    ..add(r.message.toString());
    print(sb.toString()); 
  });
    
  groupSep = '.';
  useHtmlEnhancedConfiguration();

  html.window.on.keyUp.add((html.KeyboardEvent event) {
    if (event.keyCode == html.KeyCode.R) {
      new Runtime().reload();
    }
  });
  
  new TestRuntime().main();
}
