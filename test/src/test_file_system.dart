part of harness_browser;

class TestFileSystem {
  void main() {
    group('chrome.fileSystem', () {
      // TODO: we need better testing of the file system calls
      test('exists', () {
        expect(fileSystem, isNotNull);
      });
    });
  }
}
