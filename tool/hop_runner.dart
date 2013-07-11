library hop_runner;

import 'dart:async';
import 'dart:io';
import 'package:hop/hop.dart';
import 'package:hop/hop_tasks.dart';

void main() {
  addTask('test_dart2js', createAnalyzerTask(['test/harness_browser.dart']));

  addTask('serial_example', createAnalyzerTask(
      ['example/serial_example/web/chrome_app_serial_example.dart']));

  addTask('serial_clock', createAnalyzerTask(
      ['example/serial_clock/web/clock.dart']));

  addTask('tcp_echo_server', createAnalyzerTask(
      ['example/tcp_echo_server/web/tcp_echo_server_example.dart']));

  addTask('udp_echo_client', createAnalyzerTask(
      ['example/udp_echo_client/web/udp_echo_client_example.dart']));

  addTask('usb_example', createAnalyzerTask(
      ['example/usb_example/chrome_app_usb_example.dart']));

  addTask('bluetooth_example', createAnalyzerTask(
      ['example/bluetooth_getdevices/bluetooth_getdevices.dart']));

  addTask('analyze_libs', createAnalyzerTask(
      ['lib/chrome.dart', 'lib/chrome_ext.dart']));

  addTask('analyze_tests', createAnalyzerTask(
      ['test/harness_browser.dart', 'test_ext/harness_extension.dart']));

  addTask('analyze_examples', createAnalyzerTask(
      ['example/serial_clock/web/clock.dart',
       'example/serial_example/web/chrome_app_serial_example.dart',
       'example/tcp_echo_server/web/tcp_echo_server_example.dart',
       'example/udp_echo_client/web/udp_echo_client_example.dart',
       'example/usb_example/chrome_app_usb_example.dart']));

  addTask('build_test_harness',
      createDartCompilerTask(['test/harness_browser.dart'],
      allowUnsafeEval: false));

  addTask('build_test_harness_extension',
      createDartCompilerTask(['test_ext/harness_extension.dart'],
      allowUnsafeEval: false));

  runHop();
}