library test_app;

import 'dart:async';
import 'dart:html' as html;

import 'package:unittest/unittest.dart';

import 'package:chrome/src/app.dart';

const String _TEST_WINDOW_URL = 'test_window.html';

void main() {
  final windows = <AppWindow>[];

  Future createWindow(function) {
    Completer completer = new Completer();
    Duration duration = new Duration(seconds: 3);
    Timer timer = new Timer(duration, () {
      function().then(expectAsync1((v) => completer.complete(v)));
    });
    return completer.future;
  };

  group('chrome.app.window', () {

    tearDown(() {
      return Future
          .forEach(windows, (AppWindow win) {
            win.close();
            return win.onClosed.first.then((_) =>
                new Future(() => win.dispose()));
          })
          .then((_) => windows.clear());
    });

    test('Test that a call to get the current window succeeds', () {
      final win = app.window.current;
      expect(win, const isInstanceOf<AppWindow>());
      expect(win.isMaximized, isFalse);
      expect(win.isMinimized, isFalse);
      expect(win.isFullscreen, isFalse);
    });

    test('Test a vanilla call to create() with no options', () {
      createWindow(() {
        return app.window.create(_TEST_WINDOW_URL)
          .then((AppWindow win) {
            windows.add(win);
            expect(win, const isInstanceOf<AppWindow>());
            expect(win.isMaximized, isFalse);
            expect(win.isMinimized, isFalse);
            expect(win.isFullscreen, isFalse);
            return true;
          });
      }).then(expectAsync1((v) => expect(v, isTrue)));
    });

    test('Test a call to create() with options: { bounds }', () {
      createWindow(() {
        return app.window.create(_TEST_WINDOW_URL,
                         bounds: const Bounds(left: 10,
                                              top: 20,
          // TODO(rms): if we specify any width < 130 here the test will fail.
          // Investigate, possibly a Chrome bug?
                                              width: 131,
                                              height: 40))
          .then((AppWindow win) {
            windows.add(win);
            expect(win, const isInstanceOf<AppWindow>());
            expect(win.isMaximized, isFalse);
            expect(win.isMinimized, isFalse);
            expect(win.isFullscreen, isFalse);
            expect(win.bounds.left, equals(10));
            expect(win.bounds.top, equals(20));
            expect(win.bounds.width, equals(131));
            expect(win.bounds.height, equals(40));
            return true;
          });
      }).then(expectAsync1((v) => expect(v, isTrue)));
    });

    test('Test a call to create() with options: { state : minimized }', () {
      createWindow(() {
      return app.window.create(_TEST_WINDOW_URL, state : 'minimized')
        .then((AppWindow win) {
          windows.add(win);
          expect(win, const isInstanceOf<AppWindow>());
          expect(win.isMinimized, isTrue);
          expect(win.isFullscreen, isFalse);
          expect(win.isMaximized, isFalse);
          return true;
        });
      }).then(expectAsync1((v) => expect(v, isTrue)));
    });

    test('Test a call to create() with options: { state : maximized }', () {
      createWindow(() {
      return app.window.create(_TEST_WINDOW_URL, state : 'maximized')
        .then((AppWindow win) {
          windows.add(win);
          expect(win, const isInstanceOf<AppWindow>());
          expect(win.isMaximized, isTrue);
          expect(win.isMinimized, isFalse);
          expect(win.isFullscreen, isFalse);
          return true;
        });
      }).then(expectAsync1((v) => expect(v, isTrue)));
    });

//    test('Test a call to create() with options: { state : fullscreen }', () {
//      createWindow(() {
//      return app.window.create(_TEST_WINDOW_URL, state : 'fullscreen')
//        .then((AppWindow win) {
//          windows.add(win);
//          expect(win, const isInstanceOf<AppWindow>());
//          expect(win.isFullscreen, isTrue);
//          expect(win.isMaximized, isFalse);
//          expect(win.isMinimized, isFalse);
//          return true;
//        });
//      }).then(expectAsync1((v)=> print(v)));
//    });

    test('Test a successful call to minimize()', () {
      final verify = (AppWindow win) {
        expect(win.isMinimized, isTrue);
        expect(win.isMaximized, isFalse);
        expect(win.isFullscreen, isFalse);
      };
      createWindow(() {
       return app.window.create(_TEST_WINDOW_URL).then((AppWindow win) {
          windows.add(win);
          win.onMinimized.listen(verify);
          win.minimize();
          return true;
        });
      }).then(expectAsync1((v) => expect(v, isTrue)));
    });

    test('Test a successful call to maximize()', () {
      final verify = (AppWindow win) {
        expect(win.isMaximized, isTrue);
        expect(win.isFullscreen, isFalse);
        expect(win.isMinimized, isFalse);
      };
      createWindow(() {
        return app.window.create(_TEST_WINDOW_URL).then((AppWindow win) {
          windows.add(win);
          win.onMaximized.listen(verify);
          win.maximize();
          return true;
        });
      }).then(expectAsync1((v) => expect(v, isTrue)));
    });

//    test('Test a successful call to fullscreen()', () {
//      final verify = (AppWindow win) {
//        expect(win.isFullscreen, isTrue);
//        expect(win.isMaximized, isFalse);
//        expect(win.isMinimized, isFalse);
//      };
//      createWindow(() {
//        return app.window.create(_TEST_WINDOW_URL).then((AppWindow win) {
//          windows.add(win);
//          win.onFullscreened.listen(verify);
//          win.fullscreen();
//          return true;
//        });
//      }).then(expectAsync1((v)=> print(v)));
//    });

    test('Test a successful call to restore() from isMaximized', () {
      final verify = (AppWindow win) {
        expect(win.isMaximized, isFalse);
        expect(win.isFullscreen, isFalse);
        expect(win.isMinimized, isFalse);
      };

      createWindow(() {
        return app.window.create(_TEST_WINDOW_URL).then((AppWindow win) {
          windows.add(win);
          win.onRestored.listen(verify);
          win.maximize();
          return win.onMaximized.first.then((win) {
            win.restore();
            return true;
          });
        });
      }).then(expectAsync1((v) => expect(v, isTrue)));
    });

    test('Test getting the contentWindow of an AppWindow', () {
      final verify = (HtmlWindow contentWindow) {
        expect(contentWindow.closed, isFalse);
      };
      createWindow(() {
        return app.window.create(_TEST_WINDOW_URL).then((AppWindow win) {
          windows.add(win);
          HtmlWindow contentWindow = win.contentWindow;
          contentWindow.onContentLoaded.listen(verify);
          return true;
        });
      }).then(expectAsync1((v) => expect(v, isTrue)));
    });

    test('Test postMessage to the contentWindow of an AppWindow', () {
      StreamSubscription sub;
      sub = html.window.onMessage.listen(
          (html.MessageEvent msg) {
            expect(msg.data, equals('echo: hello friend'));
            sub.cancel();
          });
      createWindow(() {
        return app.window.create(_TEST_WINDOW_URL).then((AppWindow win) {
          windows.add(win);
          HtmlWindow contentWindow = win.contentWindow;
          return contentWindow.onContentLoaded.first.then((_) {
            contentWindow.postMessage('hello friend', '*');
            return true;
          });
        });
      }).then(expectAsync1((v) => expect(v, isTrue)));
    });
  });
}
