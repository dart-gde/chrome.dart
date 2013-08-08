library hop_runner;

import 'dart:async';
import 'dart:io';
import 'package:hop/hop.dart';
import 'package:hop/hop_tasks.dart';

void main() {
  _buildTasks('serial_example', 'example/serial_example/web',
      ['chrome_app_serial_example.dart']);

  _buildTasks('serial_clock', 'example/serial_clock/web', ['clock.dart']);

  _buildTasks('tcp_echo_server', 'example/tcp_echo_server/web',
      ['tcp_echo_server_example.dart']);

  _buildTasks('udp_echo_client', 'example/udp_echo_client/web',
      ['udp_echo_client_example.dart']);

  _buildTasks('usb_example', 'example/usb_example',
      ['chrome_app_usb_example.dart']);

  _buildTasks('bluetooth_example', 'example/bluetooth_getdevices',
      ['bluetooth_getdevices.dart']);

  _buildTasks('identity_example', 'example/identity_example',
  ['identity_example.dart']);

  _buildTasks('test_harness', 'test/app',
      ['harness_browser.dart', 'background.dart']);

  _buildTasks('test_harness_extension', 'test/ext', ['harness_extension.dart']);

  addChainedTask("build_and_analyze_all", allTasks,
      description: "Build and analyze all samples and tests");

  addChainedTask("update_js_all", allUpdateTasks,
      description: "Update all javascript dependency files");

  addChainedTask("analyze_all", allAnalyzeTasks,
      description: "Analyze all samples and tests");

  addChainedTask("build_all", allBuildTasks,
      description: "Build all samples and tests");

  final libs = ['lib/app.dart', 'lib/ext.dart'];
  addTask('analyze_libs', createAnalyzerTask(libs));

  runHop();
}

final List<String> allTasks = new List<String>();
final List<String> allUpdateTasks = new List<String>();
final List<String> allAnalyzeTasks = new List<String>();
final List<String> allBuildTasks = new List<String>();

void _buildTasks(String name, String directory, List<String> filenames) {
  final file = filenames
      .map((filename) => '${directory}/${filename}')
      .toList(growable: false);

  final updateTaskName = 'update_js_$name';
  final analyzeTaskName = 'analyze_$name';
  final buildTaskName = 'build_$name';

  addTask(updateTaskName, _createUpdateJSTask(directory));
  addTask(analyzeTaskName, createAnalyzerTask(file));
  addTask(buildTaskName, createDartCompilerTask(file, allowUnsafeEval: false));

  allTasks.addAll([updateTaskName, analyzeTaskName, buildTaskName]);
  allUpdateTasks.add(updateTaskName);
  allAnalyzeTasks.add(analyzeTaskName);
  allBuildTasks.add(buildTaskName);
}

Task _createUpdateJSTask(String directory) =>
    new Task.async((TaskContext context) {
      var files = {
                   'dart.js': 'packages/browser',
                   'interop.js': 'packages/browser',
                   'dart_interop.js': 'packages/js'
      };

      return Future
          .forEach(files.keys, (String key) {
            return _copy(key, files[key], directory);
          })
          .then((_) => true);

    }, description: 'update js files from packages');

Future _copy(String fileName, String sourceDirectory, String destinationDirectory) {
  var srcFile = new File('$sourceDirectory/$fileName').readAsStringSync();
  return new File('$destinationDirectory/$fileName')
    .writeAsString(srcFile)
    .then((_) => null);
}

