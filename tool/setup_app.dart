import 'dart:io';

import 'package:path/path.dart';
import 'package:unscripted/unscripted.dart';
import 'package:chrome/build/build.dart' as build;

void main(List<String> arguments) => declare(buildApp).execute(arguments);

@Command(help: 'Copies and builds a chrome application or extension')
@ArgExample('app/test_ext harness.dart',
  help: 'Copies the packages folder to "app/test_ext" and builds "harness.dart"')
buildApp(String directory, String main) {

  // verify execution location
  if (!new Directory(directory).existsSync()) {
    print('This script must be run from the project root.');
    exit(1);
  }

  // copy packages
  print('copying packages/ to $directory/packages/...');
  build.copyPackages(new Directory(directory));

  String mainEntryPath = join(directory, main);

  // build with dart2js
  runProcess(
      'dart2js',
      [mainEntryPath, '--out=${mainEntryPath}.js']);

  // clean up some clutter
  runProcess('rm', ['${mainEntryPath}.js.deps', '${mainEntryPath}.js.map']);
}

void runProcess(String executable, List<String> arguments) {
  print("${executable} ${arguments.join(' ')}");

  ProcessResult result = Process.runSync(executable, arguments);

  if (result.stdout != null && !result.stdout.isEmpty) {
    print(result.stdout.trim());
  }

  if (result.stderr != null && !result.stderr.isEmpty) {
    print(result.stderr);
  }

  if (result.exitCode != 0) {
    throw new Exception(
        "${executable} failed with a return code of ${result.exitCode}");
  }
}
