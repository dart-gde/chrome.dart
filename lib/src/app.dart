library chrome_app;

import 'dart:async';

import 'package:js/js.dart' as js;
import 'package:logging/logging.dart';

import 'common.dart';

// chrome.app

class ChromeApp {
  final ChromeWindow window = new ChromeWindow();
}

// chrome.app.window

class ChromeWindow {
  AppWindow _current;

  /**
   * Returns an AppWindow object for the current script context (ie JavaScript
   * 'window' object).
   */
  AppWindow current() {
    if (_current == null) {
      _current = js.scoped(() {
        return new AppWindow(chromeProxy.app.window.current());
      });
    }

    return _current;
  }

  Future<AppWindow> create(String url, {String id, Bounds bounds}) {
    return js.scoped(() {
      Completer completer = new Completer();

      Map options = {};

      if (id != null) {
        options['id'] = id;
      }

//      if (bounds != null) {
//        options['bounds'] = bounds;
//      }

      chromeProxy.app.window.create(
          url,
          js.map(options),
          new js.Callback.once((var proxy) => completer.complete(new AppWindow(proxy))));

      return completer.future;
    });
  }

  // chrome.app.window.onClosed.addListener(function() {...});
  void onClosed(var callback) {
    return js.scoped(() {
      return chromeProxy.app.window.onClosed.addListener(new js.Callback.once(() {
        callback();
      }));
    });
  }
}

/**
 * Windows have an optional frame with title bar and size controls. They are not
 * associated with any Chrome browser windows.
 */
class AppWindow {
  js.Proxy proxy;

  AppWindow(this.proxy) {
    js.retain(proxy);
  }

  /**
   * Close the window.
   */
  void close() {
    js.scoped(() {
      proxy.close();
    });
  }

  /**
   * app.window.current().focus()
   */
  void focus() {
    js.scoped(() {
      proxy.focus();
    });
  }

  /**
   * Draw attention to the window.
   */
  void drawAttention() {
    js.scoped(() {
      proxy.drawAttention();
    });
  }

  /**
   * Clear attention to the window.
   */
  void clearAttention() {
    js.scoped(() {
      proxy.clearAttention();
    });
  }

  /**
   * Is the window maximized?
   */
  bool isMaximized() {
    return js.scoped(() {
      return proxy.isMaximized();
    });
  }

  /**
   * Is the window minimized?
   */
  bool isMinimized() {
    return js.scoped(() {
      return proxy.isMaximized();
    });
  }

  void dispose() {
    js.release(proxy);
  }
}

class Bounds {
  int left;
  int top;
  int width;
  int height;

  Bounds({this.left, this.top, this.width, this.height});
}
