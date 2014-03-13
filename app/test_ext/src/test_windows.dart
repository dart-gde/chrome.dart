library test_windows;

import 'dart:async';

import 'package:unittest/unittest.dart';
import 'package:chrome/chrome_ext.dart' as chrome;

void main() {
  group('chrome.windows', () {
    chrome.Window window;

    setUp(() {
      chrome.WindowsCreateParams windowCreateParams =
          new chrome.WindowsCreateParams(focused: true, type: "normal");
      return chrome.windows.create(windowCreateParams)
        .then((_window) => window = _window);
    });

    tearDown(() {
      Future closeFuture = chrome.windows.remove(window.id);
      window = null;
      return closeFuture;
    });

    test('getters', () {
      expect(window.id, new isInstanceOf<int>());
      // TODO(DrMarcII): Figure out why the focused status of the window is
      //                 not true as expected
      //expect(window.focused, isFalse);
      expect(window.top, isNonNegative);
      expect(window.left, isNonNegative);
      expect(window.width, isPositive);
      expect(window.height, isPositive);
      expect(window.tabs, hasLength(1));
      expect(window.tabs.first, new isInstanceOf<chrome.Tab>());
      expect(window.incognito, isFalse);
      expect(window.type, "normal");
      expect(window.state, "normal");
      expect(window.alwaysOnTop, isFalse);
    });

    test('get populate true', () {
      chrome.WindowsGetParams getInfo =
          new chrome.WindowsGetParams(populate: true);

      chrome.windows.get(window.id, getInfo)
        .then(expectAsync((chrome.Window newWindow) {
          expect(newWindow.id, window.id);
          expect(newWindow.tabs, hasLength(1));
          expect(newWindow.tabs.first.id, window.tabs.first.id);
        }));
    });

    test('get populate false', () {
      chrome.WindowsGetParams getInfo =
          new chrome.WindowsGetParams(populate: false);

      chrome.windows.get(window.id, getInfo)
        .then(expectAsync((chrome.Window newWindow) {
          expect(newWindow.id, window.id);
          expect(newWindow.tabs, isNull);
        }));
    });

    test('getCurrent populate true', () {
      chrome.WindowsGetCurrentParams getInfo =
          new chrome.WindowsGetCurrentParams(populate: true);

      chrome.windows.getCurrent(getInfo)
        .then(expectAsync((chrome.Window newWindow) {
          expect(newWindow.tabs, hasLength(isPositive));
        }));
    });

    test('getCurrent populate false', () {
      chrome.WindowsGetCurrentParams getInfo =
          new chrome.WindowsGetCurrentParams(populate: false);

      chrome.windows.getCurrent(getInfo)
        .then(expectAsync((chrome.Window newWindow) {
          expect(newWindow.tabs, isNull);
        }));
    });

    test('getLastFocused populate true', () {
      chrome.WindowsGetLastFocusedParams getInfo =
          new chrome.WindowsGetLastFocusedParams(populate: true);

      chrome.windows.getLastFocused(getInfo)
        .then(expectAsync((chrome.Window newWindow) {
          // TODO(DrMarcII): figure out why the last focused window
          //                 is non-deterministic
          expect(newWindow.tabs, hasLength(isPositive));
        }));
    });

    test('getLastFocused populate false', () {
      chrome.WindowsGetLastFocusedParams getInfo =
          new chrome.WindowsGetLastFocusedParams(populate: false);

      chrome.windows.getLastFocused(getInfo)
        .then(expectAsync((chrome.Window newWindow) {
          // TODO(DrMarcII): figure out why the last focused window
          //                 is non-deterministic
          expect(newWindow.tabs, isNull);
        }));
    });

    test('getAll populate true', () {
      chrome.WindowsGetAllParams getInfo =
          new chrome.WindowsGetAllParams(populate: true);

      chrome.windows.getAll(getInfo)
        .then(expectAsync((List<chrome.Window> allWindows) {
          expect(allWindows.map((w) => w.id), contains(window.id));
          expect(allWindows.map((w) => w.tabs),
              everyElement(hasLength(isPositive)));
        }));
    });

    test('getAll populate false', () {
      chrome.WindowsGetAllParams getInfo =
          new chrome.WindowsGetAllParams(populate: false);

      chrome.windows.getAll(getInfo)
        .then(expectAsync((List<chrome.Window> allWindows) {
          expect(allWindows.map((w) => w.id), contains(window.id));
          expect(allWindows.map((w) => w.tabs), everyElement(isNull));
        }));
    });

    test('create defaults', () {
      chrome.windows.create()
        .then((chrome.Window window) {
          expect(window.tabs, hasLength(1));
          expect(window.tabs.first.url, 'chrome://newtab/');
          expect(window.incognito, isFalse);
          expect(window.type, "normal");
          return chrome.windows.remove(window.id);
        })
          .then(expectAsync((_) { }));
    });

    // Requires extension access to incognito windows.
    test('create incognito window', () {
      chrome.WindowsCreateParams createData =
          new chrome.WindowsCreateParams(url: 'http://www.google.com/',
              left: 10,
              top: 10,
              width: 300,
              height: 300,
              focused: true,
              incognito: true,
              type: "normal");

      chrome.windows.create(createData)
            .then((chrome.Window window) {
              expect(window.tabs, hasLength(1));
              expect(window.tabs.first.url, 'http://www.google.com/');
              // TODO: https://github.com/dart-gde/chrome.dart/issues/97
              //expect(window.left, 10);
              //expect(window.top, 10);
              //expect(window.width, 300);
              //expect(window.height, 300);
              // TODO(DrMarcII): figure out why focused doesn't work
              // expect(window.focused, isTrue);
              expect(window.incognito, isTrue);
              expect(window.type, "normal");
              expect(window.state, "normal");
              return chrome.windows.remove(window.id);
            }).then(expectAsync((_) { }));
      });

      // Requires enable panels flag to be set.
      test('create panel', () {
        chrome.WindowsCreateParams createData =
            new chrome.WindowsCreateParams(type: "panel");
        chrome.windows.create(createData)
            .then((chrome.Window window) {
              expect(window.tabs, hasLength(1));
              expect(window.incognito, isFalse);
              expect(window.type, "panel");
              expect(window.state, "normal");
              return chrome.windows.remove(window.id);
            }).then(expectAsync((_) { }));
      });

      test('update maximized', () {
        chrome.WindowsUpdateParams updateInfo =
            new chrome.WindowsUpdateParams(state: "maximized");

        // TODO(DrMarcII): Figure out better mechanism to validate this
        chrome.windows.update(window.id, updateInfo)
            .then(expectAsync((_) { }));
      });

      test('update set size', () {
        chrome.WindowsUpdateParams updateInfo =
            new chrome.WindowsUpdateParams(left: 10,
                top: 10,
                width: 300,
                height: 300,
                drawAttention: true,
                focused: false);

        // TODO(DrMarcII): Figure out better mechanism to validate this
        chrome.windows.update(window.id, updateInfo).then(expectAsync((_) { }));
      });

      test('remove', () {
        int id;
        chrome.windows.create()
            .then((window) => id = window.id)
            .then((_) => chrome.windows.remove(id))
            .then((_) => chrome.windows.get(id))
            .catchError(expectAsync((_) { }));
      });

      test('onCreated', () {
        var subscription;
        subscription = chrome.windows.onCreated.listen(expectAsync((window) {
          expect(window, new isInstanceOf<chrome.Window>());
          subscription.cancel();
        }));
        chrome.windows.create()
            .then((window) => chrome.windows.remove(window.id))
            .then(expectAsync((_) { }));
      });

      test('onRemoved', () {
        var subscription;
        subscription = chrome.windows.onRemoved.listen(expectAsync((windowId) {
          expect(windowId, isPositive);
          subscription.cancel();
        }));
        chrome.windows.create()
            .then((window) => chrome.windows.remove(window.id))
            .then(expectAsync((_) { }));
      });

      test('onFocusChanged', () {
        var subscription;
        subscription = chrome.windows.onFocusChanged.listen(expectAsync((windowId) {
          expect(windowId, new isInstanceOf<int>());
          subscription.cancel();
        }));

        chrome.WindowsCreateParams updateInfo =
            new chrome.WindowsCreateParams(focused: true);
        chrome.windows.create(updateInfo)
            .then((window) => chrome.windows.remove(window.id))
            .then(expectAsync((_) { }));
      });
  });
}
