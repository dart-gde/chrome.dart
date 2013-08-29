part of harness_browser;

class TestFileSystem {

  void main() {
    group('chrome.fileSystem', () {
      test('exists', () {
        expect(fileSystem, isNotNull);
      });

      test('readFile', () {
        return runtime.getPackageDirectoryEntry().then((js.Proxy proxy) {
          DirectoryEntry dir = new DirectoryEntry(proxy);


          dir.release();
        });
      });

    });
  }

}
