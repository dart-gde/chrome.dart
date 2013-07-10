library chrome.windows;

import 'dart:async';

import 'package:js/js.dart' as js;

import 'common.dart';
import 'tabs.dart';

/**
 * @param window Details of the window that was created.
 */
typedef void onWindowCreatedCallback(Window window);

/**
 * Used for onRemoved and onFocusedChange events.
 *
 * @param windowId id of the removed (onRemoved) or the newly
 *                 focused (onFocusedChanged) window.
 */
typedef void windowChangedCallback(int windowId);

final Windows windows = new Windows();

class Windows {

  /**
   * The windowId value that represents the absence of a chrome browser window.
   */
  int get WINDOW_ID_NONE =>
      js.context.chrome.windows.WINDOW_ID_NONE as int;
  /**
   * The windowId value that represents the current window.
   */
  int get WINDOW_ID_CURRENT =>
      js.context.chrome.windows.WINDOW_ID_CURRENT as int;

  /**
   * Gets details about a window.
   *
   * @param populate If true, the window object will have a tabs property that
   *                 contains a list of the tabs.Tab objects
   */
  Future<Window> get(int windowId, [bool populate]) {
    var completer =
        new ChromeCompleter.transform((window) => new Window(window));
    js.scoped(() {
      js.context.chrome.windows.get(
          windowId,
          _createGetInfoMap(populate),
          completer.callback);
    });
    return completer.future;
  }

  /**
   * Gets the window that was most recently focused — typically the window
   * 'on top'.
   *
   * @param populate If true, the window object will have a tabs property that
   *                 contains a list of the tabs.Tab objects
   */
  Future<Window> getCurrent([bool populate]) {
    var completer =
        new ChromeCompleter.transform((window) => new Window(window));
    js.scoped(() {
      js.context.chrome.windows.getCurrent(
          _createGetInfoMap(populate),
          completer.callback);
    });
    return completer.future;
  }

  /**
   * Gets the current window.
   *
   * @param populate If true, the window object will have a tabs property that
   *                 contains a list of the tabs.Tab objects
   */
  Future<Window> getLastFocused([bool populate]) {
    var completer =
        new ChromeCompleter.transform((window) => new Window(window));
    js.scoped(() {
      js.context.chrome.windows.getLastFocused(
          _createGetInfoMap(populate),
          completer.callback);
    });
    return completer.future;
  }

  /**
   * Gets the current window.
   *
   * @param populate If true, the window objects will have a tabs property that
   *                 contains a list of the tabs.Tab objects
   */
  Future<List<Window>> getAll([bool populate]) {
    var completer =
        new ChromeCompleter.transform((js.Proxy jsWindows) {
          List<Window> windows = [];

          for (js.Proxy window in jsWindows) {
            windows.add(new Window(window));
          }
          return windows;
        });
    js.scoped(() {
      js.context.chrome.windows.getAll(
          _createGetInfoMap(populate),
          completer.callback);
    });
    return completer.future;
  }

  /**
   * Creates (opens) a new browser with any optional sizing, position or
   * default URL provided.
   */
  Future<Window> create({
      String url,
      int tabId,
      int left,
      int top,
      int width,
      int height,
      bool focused,
      bool incognito,
      WindowType type}) {
    Map<String, dynamic> createData = {};
    if (url != null) {
      createData['url'] = url;
    }
    if (tabId != null) {
      createData['tabId'] = tabId;
    }
    if (left != null) {
      createData['left'] = left;
    }
    if (top != null) {
      createData['top'] = top;
    }
    if (width != null) {
      createData['width'] = width;
    }
    if (height != null) {
      createData['height'] = height;
    }
    if (focused != null) {
      createData['focused'] = focused;
    }
    if (incognito != null) {
      createData['incognito'] = incognito;
    }
    if (type != null) {
      createData['type'] = type.toString();
    }

    var completer =
        new ChromeCompleter.transform((window) => new Window(window));
    js.scoped(() {
      js.context.chrome.windows.create(js.map(createData), completer.callback);
    });
    return completer.future;
  }

  /**
   * Updates the properties of a window. Specify only the properties that you
   * want to change; unspecified properties will be left unchanged.
   */
  Future<Window> update(int windowId, {
      int left,
      int top,
      int width,
      int height,
      bool focused,
      bool drawAttention,
      WindowState state}) {
    Map<String, dynamic> updateData = {};
    if (left != null) {
      updateData['left'] = left;
    }
    if (top != null) {
      updateData['top'] = top;
    }
    if (width != null) {
      updateData['width'] = width;
    }
    if (height != null) {
      updateData['height'] = height;
    }
    if (focused != null) {
      updateData['focused'] = focused;
    }
    if (drawAttention != null) {
      updateData['drawAttention'] = drawAttention;
    }
    if (state != null) {
      updateData['state'] = state.toString();
    }

    var completer =
        new ChromeCompleter.transform((window) => new Window(window));
    js.scoped(() {
      js.context.chrome.windows.update(windowId,
          js.map(updateData),
          completer.callback);
    });
    return completer.future;
  }

  /**
   * Removes (closes) a window, and all the tabs inside it.
   */
  Future remove(int windowId) {
    var completer = new ChromeCompleter.noArgs();
    js.scoped(() {
      js.context.chrome.windows.remove(windowId, completer.callback);
    });
    return completer.future;
  }

  /**
   * Fired when a window is created.
   */
  void onCreated(onWindowCreatedCallback listener) {
    js.scoped(() {
      void event(js.Proxy window) {
        if (listener!=null) {
          listener(new Window(window));
        }
      };

      js.context.chrome.windows.onCreated
          .addListener(new js.Callback.many(event));
    });
  }

  /**
   * Fired when a window is removed (closed).
   */
  void onRemoved(windowChangedCallback listener) {
    js.scoped(() {
      void event(int windowId) {
        if (listener!=null) {
          listener(windowId);
        }
      };

      js.context.chrome.windows.onRemoved
          .addListener(new js.Callback.many(event));
    });
  }

  /**
   * Fired when the currently focused window changes. Will be
   * {@link WINDOW_ID_NONE} if all chrome windows have lost focus.
   *
   * Note: On some Linux window managers, {@link WINDOW_ID_NONE} will always be
   * sent immediately preceding a switch from one chrome window to another.
   */
  void onFocusChanged(windowChangedCallback listener) {
    js.scoped(() {
      void event(int windowId) {
        if (listener!=null) {
          listener(windowId);
        }
      };

      js.context.chrome.windows.onFocusChanged
          .addListener(new js.Callback.many(event));
    });
  }

  js.Proxy _createGetInfoMap(bool populate) {
    Map<String, dynamic> getInfo = {};
    if (populate != null) {
      getInfo['populate'] = populate;
    }
    return js.map(getInfo);
  }
}

class Window {
  final js.Proxy _window;

  Window(this._window) {
    js.retain(_window);
  }

  /**
   * The ID of the window. Window IDs are unique within a browser session.
   * Under some circumstances a Window may not be assigned an ID, for example
   * when querying closed windows from the sessionRestore API.
   */
  int get id {
    return _window.id as int;
  }

  /**
   * Whether the window is currently the focused window.
   */
  bool get focused {
    return _window.focused as bool;
  }

  /**
   * The offset of the window from the top edge of the screen in pixels. Under
   * some circumstances a Window may not be assigned top property, for example
   * when querying closed windows from the sessionRestore API.
   */
  int get top {
    return _window.top as int;
  }

  /**
   * The offset of the window from the left edge of the screen in pixels. Under
   * some circumstances a Window may not be assigned left property, for example
   * when querying closed windows from the sessionRestore API.
   */
  int get left {
    return _window.left as int;
  }

  /**
   * The width of the window, including the frame, in pixels. Under some
   * circumstances a Window may not be assigned width property, for example
   * when querying closed windows from the sessionRestore API.
   */
  int get width {
    return _window.width as int;
  }

  /**
   * The height of the window, including the frame, in pixels. Under some
   * circumstances a Window may not be assigned height property, for example
   * when querying closed windows from the sessionRestore API.
   */
  int get height {
    return _window.height as int;
  }


  /**
   * The current tabs in the window.
   */
  List<Tab> get tabs {
    dynamic jsTabs = _window.tabs;
    List<Tab> tabs = [];
    if (jsTabs != null) {
      for (var i = 0; i < jsTabs.length; i++) {
        tabs.add(new Tab(jsTabs[i]));
      }
    }
    return tabs;
  }

  /**
   * Whether the window is incognito.
   */
  bool get incognito {
    return _window.incognito as bool;
  }

  /**
   * The type of browser window this is. Under some circumstances a Window may
   * not be assigned type property, for example when querying closed windows
   * from the sessionRestore API.
   */
  WindowType get type {
    String type = _window.type;
    if (type != null) {
      return new WindowType(type);
    } else {
      return null;
    }
  }

  /**
   * The state of this browser window. Under some circumstances a Window may
   * not be assigned state property, for example when querying closed windows
   * from the sessionRestore API.
   */
  WindowState get state {
    String state = _window.state;
    if (state != null) {
      return new WindowState(state);
    } else {
      return null;
    }
  }

  /**
   * Whether the window is set to be always on top.
   */
  bool get alwaysOnTop {
    return _window.alwaysOnTop as bool;
  }

  /**
   * Release the {@link js.Proxy} to the underlying javascript window object.
   * Ideally this method should be called after last use for any Window object.
   */
  void release() {
    js.release(_window);
  }
}

class WindowState {
  final String _state;

  const WindowState._internal(this._state);

  factory WindowState(String state) {
    switch (state.toLowerCase()) {
      case 'normal':
        return NORMAL;
      case 'minimized':
        return MINIMIZED;
      case 'maximized':
        return MAXIMIZED;
      case 'fullscreen':
        return FULLSCREEN;
      default:
        throw 'Unknown WindowState: $state';
    }
  }

  String toString() {
    return _state;
  }

  static const WindowState NORMAL = const WindowState._internal('normal');
  static const WindowState MINIMIZED = const WindowState._internal('minimized');
  static const WindowState MAXIMIZED = const WindowState._internal('maximized');
  static const WindowState FULLSCREEN =
      const WindowState._internal('fullscreen');

}

class WindowType {
  final String _type;

  const WindowType._internal(this._type);

  factory WindowType(String type) {
    switch (type.toLowerCase()) {
      case 'normal':
        return NORMAL;
      case 'popup':
        return POPUP;
      case 'panel':
        return PANEL;
      case 'detached_panel':
        return DETACHED_PANEL;
      case 'app':
        return APP;
      default:
        throw 'Unknown WindowType: $type';
    }
  }

  String toString() {
    return _type;
  }

  static const WindowType NORMAL = const WindowType._internal('normal');
  static const WindowType POPUP = const WindowType._internal('popup');
  static const WindowType PANEL = const WindowType._internal('panel');
  static const WindowType DETACHED_PANEL =
      const WindowType._internal('detached_panel');
  static const WindowType APP = const WindowType._internal('app');
}