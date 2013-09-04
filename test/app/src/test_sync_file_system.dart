part of harness_browser;

class TestSyncFileSystem {
  void main() {
    group('chrome.syncFileSystem', () {
      test('exists', () {
        expect(syncFileSystem, isNotNull);
      });

      test('requestFileSystem', () {
        syncFileSystem.requestFileSystem().then((FileSystem fs) {
          expect(fs, isNotNull);
          expect(fs is FileSystem, isTrue);
        }).catchError((error) {
          // this is ok - the user may not be signed in
          expect(error, isNotNull);
          expect(error.toString(), stringContainsInOrder(['authentication failed']));
        });
      });
    });
  }
}
