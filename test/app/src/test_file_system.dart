library test_file_system;

import 'dart:async';

import 'package:unittest/unittest.dart';

import 'package:chrome/app.dart';

void main() {
  group('chrome.fileSystem', () {
    test('exists', () {
      expect(fileSystem, isNotNull);
    });

    test('directory.getEntries', () {
      return runtime.getPackageDirectoryEntry().then((DirectoryEntry dir) {
        expect(dir, isNotNull);
        expect(dir.toURL(), isNotNull);

        return dir.getEntries();
      }).then((List<Entry> entries) {
        expect(entries, isNotNull);
        expect(entries.length, greaterThanOrEqualTo(1));

        // this is a bit conflated, but try and get the content of the first file
        FileEntry file = entries.firstWhere((e) => e is FileEntry);
        expect(file.toURL(), isNotNull);

        return file.readText();
      }).then((String content) {
        expect(content, isNotNull);
        print("read file content length = ${content.length}");
        expect(content.length, greaterThanOrEqualTo(1));
      });
    });
  });
}

