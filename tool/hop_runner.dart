library hop_runner;

import 'dart:async';
import 'dart:io';
import 'package:hop/hop.dart';
import 'package:hop/hop_tasks.dart';

void main() {
  addTask('test_dart2js', createDart2JsTask(['test/harness_browser.dart'],
      allowUnsafeEval: false,
      packageRoot: 'packages/'
  ));

  addTask('serial_example', createDart2JsTask(
      ['example/serial_example/web/chrome_app_serial_example.dart'],
      allowUnsafeEval: false,
      packageRoot: 'packages/'
  ));

  addTask('serial_clock', createDart2JsTask(
      ['example/serial_clock/web/chrome_app_serial_example.dart'],
      allowUnsafeEval: false,
      packageRoot: 'packages/'
  ));

  addTask('tcp_echo_server', createDart2JsTask(
      ['example/tcp_echo_server/web/tcp_echo_server_example.dart'],
      allowUnsafeEval: false,
      packageRoot: 'packages/'
  ));

  addTask('udp_echo_client', createDart2JsTask(
      ['example/udp_echo_client/web/udp_echo_server_example.dart'],
      allowUnsafeEval: false,
      packageRoot: 'packages/'
  ));

  addTask('usb_example', createDart2JsTask(
      ['example/usb_example/chrome_app_usb_example.dart'],
      allowUnsafeEval: false,
      packageRoot: 'packages/'
  ));

  addTask('analyze_libs', createDartAnalyzerTask(['lib/chrome.dart']));

  addAsyncTask('analyze_libs_hack', (ctx) => startProcess(ctx, 'dart_analyzer',
      ['lib/chrome.dart']));

  addTask('analyze_tests', createDartAnalyzerTask(
      ['test/harness_browser.dart']));

  addTask('analyze_examples', createDartAnalyzerTask(
      ['example/serial_clock/web/clock.dart',
       'example/serial_example/web/chrome_app_serial_example.dart',
       'example/tcp_echo_server/web/tcp_echo_server_example.dart',
       'example/udp_echo_client/web/udp_echo_client_example.dart']));

  runHop();
}
