part of harness_browser;

class TestWindows {
  void main() {
    group('chrome.windows', () {
      test('get', () {
        var id = ext.windows.WINDOW_ID_CURRENT;
        ext.windows.get(id)
            .then(expectAsync1((ext.Window window) {
              expect(window.id, equals(id));
              expect(window.state is ext.WindowState, isTrue);
              expect(window.type is ext.WindowType, isTrue);
            }));
      });

      test('getCurrent', () {
        var id = ext.windows.WINDOW_ID_CURRENT;
        ext.windows.getCurrent()
            .then(expectAsync1((ext.Window window) {
              expect(window.id, equals(id));
              expect(window.state is ext.WindowState, isTrue);
              expect(window.type is ext.WindowType, isTrue);
            }));
      });

      test('getLastFocused', () {
        ext.windows.getLastFocused()
            .then(expectAsync1((ext.Window window) {
              expect(window.state is ext.WindowState, isTrue);
              expect(window.type is ext.WindowType, isTrue);
            }));
      });

      test('getAll', () {
        ext.windows.getAll()
            .then(expectAsync1((List<ext.Window> windows) {
              expect(windows.isNotEmpty, isTrue);
              expect(windows.first.state is ext.WindowState, isTrue);
              expect(windows.first.type is ext.WindowType, isTrue);
            }));
      });


      test('create', () {
        ext.windows.create(type: ext.WindowType.NORMAL)
            .then(expectAsync1((ext.Window window) {
              expect(window.state is ext.WindowState, isTrue);
              expect(window.type, ext.WindowType.NORMAL);
            }));
      });

      test('update', () {
        ext.windows.create()
          .then((window) =>
              ext.windows.update(window.id, state: ext.WindowState.MINIMIZED))
          .then(expectAsync1((ext.Window window) {
            expect(window.state, ext.WindowState.FULLSCREEN);
            expect(window.type, ext.WindowType.NORMAL);
          }));
      });

      test('remove', () {
        ext.windows.create()
          .then((window) => ext.Windows.remove(window.id));
      });

      test('remove', () {
        ext.windows.create()
          .then((window) => ext.Windows.remove(window.id));
      });
    });
  }
}