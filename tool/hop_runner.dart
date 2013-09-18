library hop_runner;

import 'dart:async';
import 'dart:io';
import 'package:hop/hop.dart';
import 'package:hop/hop_tasks.dart';
import 'src/chrome_launch.dart' as chrome_launch;

void main() {
  _buildExample('app_test');
  _buildExample('bluetooth_example');
  _buildExample('identity_example');
  _buildExample('serial_clock');
  _buildExample('serial_example');
  _buildExample('tcp_echo_server');
  _buildExample('udp_echo_client');
  _buildExample('usb_example');

  _buildTasks('test_harness', 'test/app', ['harness_browser.dart', 'background.dart']);

  _buildTasks('test_harness_extension', 'test/ext', ['harness_extension.dart', 'harness_devtools.dart']);

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

void _buildExample(String name) {
  _buildTasks(name, 'example/$name/web', ['$name.dart']);
}

void _buildTasks(String name, String directory, List<String> filenames) {
  final file = filenames
      .map((filename) => '${directory}/${filename}')
      .toList(growable: false);

  final updateTaskName = 'update_js_$name';
  final analyzeTaskName = 'analyze_$name';
  final buildTaskName = 'build_$name';

  addTask(updateTaskName, _createUpdateJSTask(directory));
  addTask(analyzeTaskName, createAnalyzerTask(file));
  addTask(buildTaskName, createDartCompilerTask(file,
      allowUnsafeEval: false, verbose: false, suppressWarnings: true));
  addTask('run_$name', _createLaunchApp(directory));

  allTasks.addAll([updateTaskName, analyzeTaskName, buildTaskName]);
  allUpdateTasks.add(updateTaskName);
  allAnalyzeTasks.add(analyzeTaskName);
  allBuildTasks.add(buildTaskName);
}

Task _createLaunchApp(String manifestDir) =>
  new Task.async((ctx) => chrome_launch
    .launchChrome(manifestDir)
    .then((int exitCode) => exitCode == 0));

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

