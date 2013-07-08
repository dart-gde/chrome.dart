part of harness_browser;

class TestWindows {
  void main() {
    group('chrome.windows', () {
      test('get', () {
        var id = Windows.WINDOW_ID_CURRENT;
        Windows.get(id)
            .then(expectAsync1((Window window) {
              expect(window.id, equals(id));
              expect(window.state is WindowState, isTrue);
              expect(window.type is WindowType, isTrue);
            }));
      });


    });
  }
}