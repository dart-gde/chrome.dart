library hop_runner;

import 'dart:async';
import 'dart:io';
import 'package:hop/hop.dart';
import 'package:hop/hop_tasks.dart';

void copy(String fileName, String sourceDirectory, String destinationDirectory) {
  var srcFile = new File('$sourceDirectory/$fileName').readAsStringSync();
  new File('$destinationDirectory/$fileName').writeAsStringSync(srcFile);
}

Task createUpdateJSTask(String directory) =>
    new Task.async((TaskContext context){
      copy('dart.js', 'packages/browser', directory);
      copy('interop.js', 'packages/browser', directory);
      copy('dart_interop.js', 'packages/js', directory);
      return true;
    }, description: 'update js files from packages');

void buildTasks(String name, String directory, String filename) {
  final file = ['${directory}/${filename}'];
  addTask('update_js_$name', createUpdateJSTask(directory));
  addTask('analyze_$name', createAnalyzerTask(file));
  addTask('build_$name', createDartCompilerTask(file, allowUnsafeEval: false));
}

void main() {
  buildTasks('serial_example', 'example/serial_example/web',
      'chrome_app_serial_example.dart');

  buildTasks('serial_clock', 'example/serial_clock/web', 'clock.dart');

  buildTasks('tcp_echo_server', 'example/tcp_echo_server/web',
      'tcp_echo_server_example.dart');

  buildTasks('udp_echo_client', 'example/udp_echo_client/web',
      'udp_echo_client_example.dart');

  buildTasks('usb_example', 'example/usb_example',
      'chrome_app_usb_example.dart');

  buildTasks('bluetooth_example', 'example/bluetooth_getdevices',
      'bluetooth_getdevices.dart');

  buildTasks('test_harness', 'test', 'harness_browser.dart');

  buildTasks('test_harness_extension', 'test_ext', 'harness_extension.dart');

  final libs = ['lib/chrome.dart', 'lib/chrome_ext.dart'];
  addTask('analyze_libs', createAnalyzerTask(libs));

  runHop();
}