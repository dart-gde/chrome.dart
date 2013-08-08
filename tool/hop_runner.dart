library hop_runner;

import 'dart:io';
import 'package:hop/hop.dart';
import 'package:hop/hop_tasks.dart';

final List<String> allTasks = new List<String>();
final List<String> allUpdateTasks = new List<String>();
final List<String> allAnalyzeTasks = new List<String>();
final List<String> allBuildTasks = new List<String>();

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


void buildTasks(String name, String directory, List<String> filenames) {
  final file = filenames.map((filename) => '${directory}/${filename}');

  final updateTaskName = 'update_js_$name';
  final analyzeTaskName = 'analyze_$name';
  final buildTaskName = 'build_$name';

  addTask(updateTaskName, createUpdateJSTask(directory));
  addTask(analyzeTaskName, createAnalyzerTask(file));
  addTask(buildTaskName, createDartCompilerTask(file, allowUnsafeEval: false));

  allTasks.addAll([updateTaskName, analyzeTaskName, buildTaskName]);
  allUpdateTasks.add(updateTaskName);
  allAnalyzeTasks.add(analyzeTaskName);
  allBuildTasks.add(buildTaskName);
}

void main() {
  buildTasks('serial_example', 'example/serial_example/web',
      ['chrome_app_serial_example.dart']);

  buildTasks('serial_clock', 'example/serial_clock/web', ['clock.dart']);

  buildTasks('tcp_echo_server', 'example/tcp_echo_server/web',
      ['tcp_echo_server_example.dart']);

  buildTasks('udp_echo_client', 'example/udp_echo_client/web',
      ['udp_echo_client_example.dart']);

  buildTasks('usb_example', 'example/usb_example',
      ['chrome_app_usb_example.dart']);

  buildTasks('bluetooth_example', 'example/bluetooth_getdevices',
      ['bluetooth_getdevices.dart']);

  buildTasks('identity_example', 'example/identity_example',
  ['identity_example.dart']);

  buildTasks('test_harness', 'test/app',
      ['harness_browser.dart', 'background.dart']);

  buildTasks('test_harness_extension', 'test/ext', ['harness_extension.dart']);

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
