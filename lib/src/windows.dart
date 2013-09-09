library chrome.windows;

import 'dart:async';

import 'package:js/js.dart' as js;

import 'common.dart';
import 'tabs.dart';

/// accessor for the `chrome.windows` namespace.
final Windows windows = new Windows._();

/**
 * Encapsulation of the `chrome.windows` namespace.
 * The single instance of this class is accessed from the [tabs]
 * getter.
 */
class Windows {

  Windows._();

  /// The windowId value that represents the absence of a chrome browser window.
  int get WINDOW_ID_NONE =>
      chromeProxy.windows.WINDOW_ID_NONE as int;
  /// The windowId value that represents the current window.
  int get WINDOW_ID_CURRENT =>
      chromeProxy.windows.WINDOW_ID_CURRENT as int;

  /**
   * Gets details about a window.
   *
   * If [populate] is true, the window object will have a [tabs] property that
   * contains a list of [tabs.Tab] objects.
   */
  Future<Window> get(int windowId, {bool populate}) {
    var completer =
        new ChromeCompleter.oneArg((window) => new Window(window));
    js.scoped(() {
      chromeProxy.windows.get(
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
   * If [populate] is true, the window object will have a [tabs] property that
   * contains a list of [tabs.Tab] objects.
   */
  Future<Window> getCurrent({bool populate}) {
    var completer =
        new ChromeCompleter.oneArg((window) => new Window(window));
    js.scoped(() {
      chromeProxy.windows.getCurrent(
          _createGetInfoMap(populate),
          completer.callback);
    });
    return completer.future;
  }

  /**
   * Gets the current window.
   *
   * If [populate] is true, the window object will have a [tabs] property that
   * contains a list of [tabs.Tab] objects.
   */
  Future<Window> getLastFocused({bool populate}) {
    var completer =
        new ChromeCompleter.oneArg((window) => new Window(window));
    js.scoped(() {
      chromeProxy.windows.getLastFocused(
          _createGetInfoMap(populate),
          completer.callback);
    });
    return completer.future;
  }

  /**
   * Gets the current window.
   *
   * If [populate] is true, the window object will have a [tabs] property that
   * contains a list of [tabs.Tab] objects.
   */
  Future<List<Window>> getAll({bool populate}) {
    var completer =
        new ChromeCompleter.oneArg((jsWindows) {
          List<Window> windows = [];

          for (int i = 0; i < jsWindows.length; i++) {
            windows.add(new Window(jsWindows[i]));
          }
          return windows;
        });
    js.scoped(() {
      chromeProxy.windows.getAll(
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
        new ChromeCompleter.oneArg((window) => new Window(window));
    js.scoped(() {
      chromeProxy.windows.create(js.map(createData), completer.callback);
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
        new ChromeCompleter.oneArg((window) => new Window(window));
    js.scoped(() {
      chromeProxy.windows.update(windowId,
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
      chromeProxy.windows.remove(windowId, completer.callback);
    });
    return completer.future;
  }

  final ChromeStreamController<Window> _onCreated =
      new ChromeStreamController<Window>.oneArg(
          () => chromeProxy.windows.onCreated,
          (window) => new Window(window));

  /**
   * Fired when a window is created.
   */
  Stream<Window> get onCreated => _onCreated.stream;

  final ChromeStreamController<int> _onRemoved =
      new ChromeStreamController<int>.oneArg(
          () => chromeProxy.windows.onRemoved,
          (windowId) => windowId);

  /**
   * Fired when a window is removed (closed).
   */
  Stream<int> get onRemoved => _onRemoved.stream;

  final ChromeStreamController<int> _onFocusChanged =
      new ChromeStreamController<int>.oneArg(
          () => chromeProxy.windows.onFocusChanged,
          (windowId) => windowId);

  /**
   * Fired when the currently focused window changes. Will be
   * {@link WINDOW_ID_NONE} if all chrome windows have lost focus.
   *
   * Note: On some Linux window managers, [WINDOW_ID_NONE] will always be
   * sent immediately preceding a switch from one chrome window to another.
   */
  Stream<int> get onFocusChanged => _onFocusChanged.stream;

  js.Proxy _createGetInfoMap(bool populate) {
    Map<String, dynamic> getInfo = {};
    if (populate != null) {
      getInfo['populate'] = populate;
    }
    return js.map(getInfo);
  }
}

class Window {
  final int id;
  final bool focused;
  final int top;
  final int left;
  final int width;
  final int height;
  final List<Tab> tabs;
  final bool incognito;
  final WindowType type;
  final WindowState state;
  final bool alwaysOnTop;

  const Window._(
      this.id,
      this.focused,
      this.top,
      this.left,
      this.width,
      this.height,
      this.tabs,
      this.incognito,
      this.type,
      this.state,
      this.alwaysOnTop);

  Window(window) : this._(
      window['id'],
      window.focused,
      window['top'],
      window['left'],
      window['width'],
      window['height'],
      _createTabs(window['tabs']),
      window.incognito,
      window['type'] != null ? new WindowType(window.type) : null,
      window['state'] != null ? new WindowState(window.state) : null,
      window.alwaysOnTop);


  static List<Tab> _createTabs(jsTabs) {
    if (jsTabs == null) {
      return null;
    }
    var tabs = [];

    for (int i = 0; i < jsTabs.length; i++) {
      tabs.add(new Tab(jsTabs[i]));
    }

    return tabs;
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