library test_chrome_idl_files;

import 'dart:io';
import 'dart:mirrors';

import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import '../tool/chrome_idl_parser.dart';
import '../tool/chrome_idl_convert.dart';
import '../tool/chrome_idl_model.dart';

void main() {
  final String testDirectory = path.dirname(
      currentMirrorSystem().findLibrary(#test_chrome_idl_files).uri.path);

  group('ChromeIDLParser', () {
    bool idlFileExtTest(FileSystemEntity file) => file.path.endsWith('.idl');

    Iterable<FileSystemEntity> chromeIdlFileEntities =
        new Directory(path.join(testDirectory, '..', 'idl'))
            .listSync(recursive: false, followLinks: false)
            .where(idlFileExtTest);

    Iterable<FileSystemEntity> chromeIdlTestFileEntities =
        new Directory(path.join(testDirectory, 'idl', 'chrome'))
            .listSync(recursive: false, followLinks: false)
            .where(idlFileExtTest);

    List<FileSystemEntity> testFileEntities = new List<FileSystemEntity>()
      ..addAll(chromeIdlFileEntities)
      ..addAll(chromeIdlTestFileEntities);

    // TODO: make async
    testFileEntities.forEach((FileSystemEntity fileEntity) {
      test('${fileEntity.path}', () {
        File file = new File(fileEntity.path);
        String webIdl = file.readAsStringSync();
        ChromeIDLParser chromeIDLParser = new ChromeIDLParser();
        IDLNamespaceDeclaration namespace =
            chromeIDLParser.namespaceDeclaration.parse(webIdl);
        /*ChromeLibrary chromeLibrary =*/ convert(namespace);
      });
    });
  });
}
