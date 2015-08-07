library test_sync_file_system;

import 'package:unittest/unittest.dart';
import 'package:chrome/chrome_app.dart' as chrome;

void main() {
  group('chrome.syncFileSystem', () {
    test('exists', () {
      expect(chrome.syncFileSystem, isNotNull);
    });

    test('requestFileSystem', () {
      //Completer c = new Completer();
      Function f = expectAsync((_) {

      });
      chrome.syncFileSystem.requestFileSystem().then((chrome.FileSystem fs) {
        expect(fs, isNotNull);
        expect(fs is chrome.FileSystem, isTrue);
        expect(fs.name, isNotNull);

        // root
        expect(fs.root, isNotNull);
        expect(fs.root.toUrl(), isNotNull);
        f(null);
      }, onError: (error) {
        logMessage("onError error = ${error.toString()}");
        // this is ok - the user may not be signed in
        expect(error, isNotNull);
        f(null);
      }).catchError((error) {
        logMessage("catchError error = ${error.toString()}");
        // this is ok - the user may not be signed in
        expect(error, isNotNull);
        expect(error.toString(), stringContainsInOrder(['authentication failed']));
        f(null);
      });
    });
  });
}
