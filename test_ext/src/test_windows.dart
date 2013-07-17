part of harness_extension;

class TestWindows {
  void main() {
    group('chrome.windows', () {
      test('get', () {
        windows.get(windows.WINDOW_ID_CURRENT)
            .then(expectAsync1((Window window) {
              expect(window.state is WindowState, isTrue);
              expect(window.type is WindowType, isTrue);
              window.release();
            }));
      });

      test('getCurrent', () {
        windows.getCurrent()
            .then(expectAsync1((Window window) {
              expect(window.state is WindowState, isTrue);
              expect(window.type is WindowType, isTrue);
              window.release();
            }));
      });

      test('getLastFocused', () {
        windows.getLastFocused()
            .then(expectAsync1((Window window) {
              expect(window.state is WindowState, isTrue);
              expect(window.type is WindowType, isTrue);
              window.release();
            }));
      });

      test('getAll', () {
        windows.getAll()
            .then(expectAsync1((List<Window> windows) {
              expect(windows.isNotEmpty, isTrue);
              expect(windows.first.state is WindowState, isTrue);
              expect(windows.first.type is WindowType, isTrue);
              windows.map((window) => window.release());
            }));
      });

      test('create', () {
        windows.create(type: WindowType.NORMAL)
            .then(expectAsync1((Window window) {
              expect(window.state is WindowState, isTrue);
              expect(window.type, WindowType.NORMAL);
              window.release();
            }));
      });

      test('update', () {
        windows.create()
          .then((window) {
            int id = window.id;
            window.release();
            return windows.update(id, state: WindowState.MAXIMIZED);
          })
          .then(expectAsync1((Window window) {
            expect(window.state, WindowState.MAXIMIZED);
            expect(window.type, WindowType.NORMAL);
            window.release();
          }));
      });

      test('remove', () {
        windows.create()
          .then((window) {
            int id = window.id;
            window.release();
            return windows.remove(id);
          });
      });
    });
  }
}