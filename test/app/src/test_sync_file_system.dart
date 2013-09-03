part of harness_browser;

class TestSyncFileSystem {
  void main() {
    group('chrome.syncFileSystem', () {
      test('exists', () {
        expect(syncFileSystem, isNotNull);
      });

      test('requestFileSystem', () {
        syncFileSystem.requestFileSystem().then(expectAsync1((FileSystem fs) {
          expect(fs, isNotNull);
          expect(fs is FileSystem, isTrue);
        }));
      });
    });
  }
}
