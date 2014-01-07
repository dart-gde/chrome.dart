library test_chrome_idl_files;

// TODO: also test test/idl/chrome/*.idl files

import 'dart:io';

import 'package:unittest/unittest.dart';

import '../tool/chrome_idl_parser.dart';
import '../tool/chrome_idl_convert.dart';
import '../tool/chrome_idl_model.dart';
import '../tool/chrome_model.dart';

void main() {
  group('ChromeIDLParser', () {
    bool idlFileExtTest(FileSystemEntity file) => file.path.endsWith('.idl');

    Iterable<FileSystemEntity> chromeIdlFileEntities = new Directory('idl')
    .listSync(recursive: false, followLinks: false).where(idlFileExtTest);

    Iterable<FileSystemEntity> chromeIdlTestFileEntities =
        new Directory('test/idl/chrome')
    .listSync(recursive: false, followLinks: false).where(idlFileExtTest);

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
        ChromeLibrary chromeLibrary = convert(namespace);
      });
    });
  });
}
