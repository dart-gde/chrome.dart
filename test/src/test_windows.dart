// TODO Figure out how we want to run extension API tests.
part of harness_extension;

class TestWindows {
  void main() {
    group('chrome.windows', () {
      test('get', () {
        var id = windows.WINDOW_ID_CURRENT;
        windows.get(id)
            .then(expectAsync1((Window window) {
              expect(window.id, equals(id));
              expect(window.state is WindowState, isTrue);
              expect(window.type is WindowType, isTrue);
            }));
      });

      test('getCurrent', () {
        var id = windows.WINDOW_ID_CURRENT;
        windows.getCurrent()
            .then(expectAsync1((Window window) {
              expect(window.id, equals(id));
              expect(window.state is WindowState, isTrue);
              expect(window.type is WindowType, isTrue);
            }));
      });

      test('getLastFocused', () {
        windows.getLastFocused()
            .then(expectAsync1((Window window) {
              expect(window.state is WindowState, isTrue);
              expect(window.type is WindowType, isTrue);
            }));
      });

      test('getAll', () {
        windows.getAll()
            .then(expectAsync1((List<Window> windows) {
              expect(windows.isNotEmpty, isTrue);
              expect(windows.first.state is WindowState, isTrue);
              expect(windows.first.type is WindowType, isTrue);
            }));
      });


      test('create', () {
        windows.create(type: WindowType.NORMAL)
            .then(expectAsync1((Window window) {
              expect(window.state is WindowState, isTrue);
              expect(window.type, WindowType.NORMAL);
            }));
      });

      test('update', () {
        windows.create()
          .then((window) =>
              windows.update(window.id, state: WindowState.MINIMIZED))
          .then(expectAsync1((Window window) {
            expect(window.state, WindowState.FULLSCREEN);
            expect(window.type, WindowType.NORMAL);
          }));
      });

      test('remove', () {
        windows.create()
          .then((window) => windows.remove(window.id));
      });

      test('remove', () {
        windows.create()
          .then((window) => windows.remove(window.id));
      });
    });
  }
}
