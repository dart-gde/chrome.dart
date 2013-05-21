part of harness_browser;

class TestApp {
  void main() {
    group('chrome.app.window', () {
      test('isMaximized', () {
        // test that the call works
        app.window.current().isMaximized();
      });
      test('isMinimized', () {
        // test that the call works
        app.window.current().isMinimized();
      });
      test('maxMin', () {
        // test that the calls return reasonable info
        expect(
            app.window.current().isMinimized() &&
            app.window.current().isMaximized(),
            false);
      });
    });
  }
}
