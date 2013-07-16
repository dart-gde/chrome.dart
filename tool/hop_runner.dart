library hop_runner;

import 'dart:async';
import 'dart:io';
import 'package:hop/hop.dart';
import 'package:hop/hop_tasks.dart';

void main() {
  final serialExample = ['example/serial_example/web/chrome_app_serial_example.dart'];
  addTask('serial_example', createAnalyzerTask(serialExample));
  addTask('build_serial_example', createDartCompilerTask(serialExample,
      allowUnsafeEval: false));

  final serialClockExample = ['example/serial_clock/web/clock.dart'];
  addTask('serial_clock', createAnalyzerTask(serialClockExample));
  addTask('build_serial_clock', createDartCompilerTask(serialClockExample,
      allowUnsafeEval: false));

  final tcpEchoExample = ['example/tcp_echo_server/web/tcp_echo_server_example.dart'];
  addTask('tcp_echo_server', createAnalyzerTask(tcpEchoExample));
  addTask('build_tcp_echo_server', createDartCompilerTask(tcpEchoExample,
      allowUnsafeEval: false));

  final udpEchoExample = ['example/udp_echo_client/web/udp_echo_client_example.dart'];
  addTask('udp_echo_client', createAnalyzerTask(udpEchoExample));
  addTask('build_udp_echo_client', createDartCompilerTask(udpEchoExample,
      allowUnsafeEval: false));

  final usbExample = ['example/usb_example/chrome_app_usb_example.dart'];
  addTask('usb_example', createAnalyzerTask(usbExample));
  addTask('build_usb_example', createDartCompilerTask(usbExample,
      allowUnsafeEval: false));

  final bluetoothExample = ['example/bluetooth_getdevices/bluetooth_getdevices.dart'];
  addTask('bluetooth_example', createAnalyzerTask(bluetoothExample));
  addTask('build_bluetooth_example', createDartCompilerTask(bluetoothExample,
      allowUnsafeEval: false));

  addTask('analyze_examples', createAnalyzerTask(
      ['example/serial_clock/web/clock.dart',
       'example/serial_example/web/chrome_app_serial_example.dart',
       'example/tcp_echo_server/web/tcp_echo_server_example.dart',
       'example/udp_echo_client/web/udp_echo_client_example.dart',
       'example/usb_example/chrome_app_usb_example.dart']));

  final libs = ['lib/chrome.dart', 'lib/chrome_ext.dart'];
  addTask('analyze_libs', createAnalyzerTask(libs));

  final tests = ['test/harness_browser.dart', 'test_ext/harness_extension.dart'];
  addTask('analyze_tests', createAnalyzerTask(tests));

  addTask('build_test_harness',
      createDartCompilerTask(['test/harness_browser.dart'],
      allowUnsafeEval: false));

  addTask('build_test_harness_extension',
      createDartCompilerTask(['test_ext/harness_extension.dart'],
      allowUnsafeEval: false));

  runHop();
}