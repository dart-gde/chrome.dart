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

      test('getCurrent', () {
        var id = Windows.WINDOW_ID_CURRENT;
        Windows.getCurrent()
            .then(expectAsync1((Window window) {
              expect(window.id, equals(id));
              expect(window.state is WindowState, isTrue);
              expect(window.type is WindowType, isTrue);
            }));
      });

      test('getLastFocused', () {
        Windows.getLastFocused()
            .then(expectAsync1((Window window) {
              expect(window.state is WindowState, isTrue);
              expect(window.type is WindowType, isTrue);
            }));
      });

      test('getAll', () {
        Windows.getAll()
            .then(expectAsync1((List<Window> windows) {
              expect(windows.isNotEmpty, isTrue);
              expect(windows.first.state is WindowState, isTrue);
              expect(windows.first.type is WindowType, isTrue);
            }));
      });


      test('create', () {
        Windows.create(type: WindowType.NORMAL)
            .then(expectAsync1((Window window) {
              expect(window.state is WindowState, isTrue);
              expect(window.type, WindowType.NORMAL);
            }));
      });

      test('update', () {
        Windows.create()
          .then((window) =>
              Windows.update(window.id, state: WindowState.MINIMIZED))
          .then(expectAsync1((Window window) {
            expect(window.state, WindowState.FULLSCREEN);
            expect(window.type, WindowType.NORMAL);
          }));
      });

      test('remove', () {
        Windows.create()
          .then((window) => Windows.remove(window.id));
      });

      test('remove', () {
        Windows.create()
          .then((window) => Windows.remove(window.id));
      });
    });
  }
}