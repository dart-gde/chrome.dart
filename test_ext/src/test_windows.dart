part of harness_extension;

class TestWindows {
  void main() {
    group('chrome.windows', () {

      Window window;

      setUp(() {
        return windows.create(focused: true, type: WindowType.NORMAL)
            .then((_window) => window = _window);
      });

      tearDown(() {
        Future closeFuture = windows.remove(window.id);
        window.release();
        window = null;
        return closeFuture;
      });

      test('getters', () {
        expect(window.id, new isInstanceOf<int>());
        // TODO(DrMarcII): Figure out why the focused status of the window is
        //                 not true as expected
        expect(window.focused, isFalse);
        expect(window.top, isNonNegative);
        expect(window.left, isNonNegative);
        expect(window.width, isPositive);
        expect(window.height, isPositive);
        expect(window.tabs, hasLength(1));
        expect(window.tabs.first, new isInstanceOf<Tab>());
        expect(window.incognito, isFalse);
        expect(window.type, WindowType.NORMAL);
        expect(window.state, WindowState.NORMAL);
        expect(window.alwaysOnTop, isFalse);
      });

      test('get populate true', () {
        windows.get(window.id, populate: true)
            .then(expectAsync1((Window newWindow) {
              expect(newWindow.id, window.id);
              expect(newWindow.tabs, hasLength(1));
              expect(newWindow.tabs.first.id, window.tabs.first.id);
            }));
      });

      test('get populate false', () {
        windows.get(window.id, populate: false)
            .then(expectAsync1((Window newWindow) {
              expect(newWindow.id, window.id);
              expect(newWindow.tabs, isNull);
            }));
      });

      test('getCurrent populate true', () {
        windows.getCurrent(populate: true)
            .then(expectAsync1((Window newWindow) {
              expect(newWindow.tabs, hasLength(isPositive));
            }));
      });

      test('getCurrent populate false', () {
        windows.getCurrent(populate: false)
            .then(expectAsync1((Window newWindow) {
              expect(newWindow.tabs, isNull);
            }));
      });

      test('getLastFocused populate true', () {
        windows.getLastFocused(populate: true)
            .then(expectAsync1((Window newWindow) {
              // TODO(DrMarcII): figure out why the last focused window
              //                 is non-deterministic
              expect(newWindow.tabs, hasLength(isPositive));
            }));
      });

      test('getLastFocused populate false', () {
        windows.getLastFocused(populate: false)
            .then(expectAsync1((Window newWindow) {
              // TODO(DrMarcII): figure out why the last focused window
              //                 is non-deterministic
              expect(newWindow.tabs, isNull);
            }));
      });

      test('getAll populate true', () {
        windows.getAll(populate: true)
            .then(expectAsync1((List<Window> allWindows) {
              expect(allWindows.map((w) => w.id), contains(window.id));
              expect(allWindows.map((w) => w.tabs),
                  everyElement(hasLength(isPositive)));
            }));
      });

      test('getAll populate false', () {
        windows.getAll(populate: false)
            .then(expectAsync1((List<Window> allWindows) {
              expect(allWindows.map((w) => w.id), contains(window.id));
              expect(allWindows.map((w) => w.tabs), everyElement(isNull));
            }));
      });

      test('create defaults', () {
        windows.create()
            .then((Window window) {
              expect(window.tabs, hasLength(1));
              expect(window.tabs.first.url, 'chrome://newtab/');
              expect(window.incognito, isFalse);
              expect(window.type, WindowType.NORMAL);
              return windows.remove(window.id);
            })
            .then(expectAsync1((_) { }));
      });

      test('create incognito window', () {
        windows.create(
            url: 'http://www.google.com/',
            left: 10,
            top: 10,
            width: 300,
            height: 300,
            focused: true,
            incognito: true,
            type: WindowType.NORMAL)
            .then((Window window) {
              expect(window.tabs, hasLength(1));
              expect(window.tabs.first.url, 'http://www.google.com/');
              expect(window.left, 10);
              expect(window.top, 10);
              expect(window.width, 300);
              expect(window.height, 300);
              // TODO(DrMarcII): figure out why focused doesn't work
              // expect(window.focused, isTrue);
              expect(window.incognito, isTrue);
              expect(window.type, WindowType.NORMAL);
              expect(window.state, WindowState.NORMAL);
              return windows.remove(window.id);
            }).then(expectAsync1((_) { }));
      });

      // requires enable panels flag to be set.
      test('create panel', () {
        windows.create(type: WindowType.PANEL)
            .then((Window window) {
              expect(window.tabs, hasLength(1));
              expect(window.incognito, isFalse);
              expect(window.type, WindowType.PANEL);
              expect(window.state, WindowState.NORMAL);
              return windows.remove(window.id);
            }).then(expectAsync1((_) { }));
      });

      test('update maximized', () {
        // TODO(DrMarcII): Figure out better mechanism to validate this
        windows.update(window.id, state: WindowState.MAXIMIZED)
            .then(expectAsync1((_) { }));
      });

      test('update set size', () {
        // TODO(DrMarcII): Figure out better mechanism to validate this
        windows.update(
            window.id,
            left: 10,
            top: 10,
            width: 300,
            height: 300,
            drawAttention: true,
            focused: false).then(expectAsync1((_) { }));
      });

      test('remove', () {
        int id;
        windows.create()
            .then((window) => id = window.id)
            .then((_) => windows.remove(id))
            .then((_) => windows.get(id))
            .catchError(expectAsync1((_) { }));
      });

      test('onCreated', () {
        var subscription;
        subscription = windows.onCreated.listen(expectAsync1((window) {
          expect(window, new isInstanceOf<Window>());
          subscription.cancel();
        }));
        windows.create()
            .then((window) => windows.remove(window.id))
            .then(expectAsync1((_) { }));
      });

      test('onRemoved', () {
        var subscription;
        subscription = windows.onRemoved.listen(expectAsync1((windowId) {
          expect(windowId, isPositive);
          subscription.cancel();
        }));
        windows.create()
            .then((window) => windows.remove(window.id))
            .then(expectAsync1((_) { }));
      });

      test('onFocusChanged', () {
        var subscription;
        subscription = windows.onFocusChanged.listen(expectAsync1((windowId) {
          expect(windowId, new isInstanceOf<int>());
          subscription.cancel();
        }));
        windows.create(focused: true)
            .then((window) => windows.remove(window.id))
            .then(expectAsync1((_) { }));
      });
    });
  }
}