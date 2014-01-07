library test_file_system;

import 'dart:async';

import 'package:unittest/unittest.dart';
import 'package:chrome/chrome_app.dart' as chrome;

void main() {
  group('chrome.fileSystem', () {
    test('exists', () {
      expect(chrome.fileSystem, isNotNull);
    });

    test('directory.getFile', () {
      return chrome.runtime.getPackageDirectoryEntry()
          .then(expectAsync1((chrome.DirectoryEntry dir) {
        logMessage("dir = ${dir}");
        expect(dir, isNotNull);
        expect(dir.toUrl(), isNotNull);
        return dir.getFile("manifest.json");
      })).then(expectAsync1((chrome.Entry entry) {
        logMessage("entry = ${entry}");
        expect(entry, isNotNull);
        expect(entry.isFile, true);
        expect(entry.name, "manifest.json");
        expect(entry.toUrl(), isNotNull);
      }));
    });
  });
}
