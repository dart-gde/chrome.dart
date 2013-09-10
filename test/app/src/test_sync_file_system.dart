library sync_file_system;

import 'dart:async';

import 'package:unittest/unittest.dart';

import 'package:chrome/app.dart';

void main() {
  group('chrome.syncFileSystem', () {
    test('exists', () {
      expect(syncFileSystem, isNotNull);
    });

    test('requestFileSystem', () {
      syncFileSystem.requestFileSystem().then((FileSystem fs) {
        expect(fs, isNotNull);
        expect(fs is FileSystem, isTrue);
        expect(fs.name, isNotNull);

        // root
        expect(fs.root, isNotNull);
        expect(fs.root.toURL(), isNotNull);
      }).catchError((error) {
        // this is ok - the user may not be signed in
        expect(error, isNotNull);
        expect(error.toString(), stringContainsInOrder(['authentication failed']));
      });
    });
  });
}

