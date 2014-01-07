/* This file has been generated - do not edit */

library chrome.app;

import '../src/common.dart';
import '../src/files.dart';
import 'windows.dart';

final ChromeApp app = new ChromeApp._();

class ChromeApp {
  ChromeApp._();

  /**
   * Accessor for the `chrome.app.runtime` namespace.
   */
  final ChromeAppRuntime runtime = new ChromeAppRuntime._();

  /**
   * Accessor for the `chrome.app.window` namespace.
   */
  final ChromeAppWindow window = new ChromeAppWindow._();
}

/**
 * Use the `chrome.app.runtime` API to manage the app lifecycle. The app runtime
 * manages app installation, controls the event page, and can shut down the app
 * at anytime.
 */
class ChromeAppRuntime extends ChromeApi {
  static final JsObject _app_runtime = chrome['app']['runtime'];

  ChromeAppRuntime._();

  bool get available => _app_runtime != null;

  Stream<LaunchData> get onLaunched => _onLaunched.stream;

  final ChromeStreamController<LaunchData> _onLaunched =
      new ChromeStreamController<LaunchData>.oneArg(_app_runtime, 'onLaunched', _createLaunchData);

  Stream get onRestarted => _onRestarted.stream;

  final ChromeStreamController _onRestarted =
      new ChromeStreamController.noArgs(_app_runtime, 'onRestarted');

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.app.runtime' is not available");
  }
}

class LaunchItem extends ChromeObject {
  LaunchItem({FileEntry entry, String type}) {
    if (entry != null) this.entry = entry;
    if (type != null) this.type = type;
  }
  LaunchItem.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  FileEntry get entry => _createFileEntry(jsProxy['entry']);
  set entry(FileEntry value) => jsProxy['entry'] = jsify(value);

  String get type => jsProxy['type'];
  set type(String value) => jsProxy['type'] = value;
}

/**
 * Optional data for the launch. Either `items`, or the pair (`url,
 * referrerUrl`) can be present for any given launch.
 */
class LaunchData extends ChromeObject {
  LaunchData({String id, List<LaunchItem> items, String url, String referrerUrl, bool isKioskSession}) {
    if (id != null) this.id = id;
    if (items != null) this.items = items;
    if (url != null) this.url = url;
    if (referrerUrl != null) this.referrerUrl = referrerUrl;
    if (isKioskSession != null) this.isKioskSession = isKioskSession;
  }
  LaunchData.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  List<LaunchItem> get items => listify(jsProxy['items'], _createLaunchItem);
  set items(List<LaunchItem> value) => jsProxy['items'] = jsify(value);

  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;

  String get referrerUrl => jsProxy['referrerUrl'];
  set referrerUrl(String value) => jsProxy['referrerUrl'] = value;

  bool get isKioskSession => jsProxy['isKioskSession'];
  set isKioskSession(bool value) => jsProxy['isKioskSession'] = value;
}

LaunchData _createLaunchData(JsObject jsProxy) => jsProxy == null ? null : new LaunchData.fromProxy(jsProxy);
FileEntry _createFileEntry(JsObject jsProxy) => jsProxy == null ? null : new ChromeFileEntry.fromProxy(jsProxy);
LaunchItem _createLaunchItem(JsObject jsProxy) => jsProxy == null ? null : new LaunchItem.fromProxy(jsProxy);

/**
 * Use the `chrome.app.window` API to create windows. Windows have an optional
 * frame with title bar and size controls. They are not associated with any
 * Chrome browser windows.
 */
class ChromeAppWindow extends ChromeApi {
  static final JsObject _app_window = chrome['app']['window'];

  ChromeAppWindow._();

  bool get available => _app_window != null;

  /**
   * The size and position of a window can be specified in a number of different
   * ways. The most simple option is not specifying anything at all, in which
   * case a default size and platform dependent position will be used.
   * 
   * Another option is to use the bounds property, which will put the window at
   * the specified coordinates with the specified size. If the window has a
   * frame, it's total size will be the size given plus the size of the frame;
   * that is, the size in bounds is the content size, not the window size.
   * 
   * To automatically remember the positions of windows you can give them ids.
   * If a window has an id, This id is used to remember the size and position of
   * the window whenever it is moved or resized. This size and position is then
   * used instead of the specified bounds on subsequent opening of a window with
   * the same id. If you need to open a window with an id at a location other
   * than the remembered default, you can create it hidden, move it to the
   * desired location, then show it.
   * 
   * Returns:
   * Called in the creating window (parent) before the load event is called in
   * the created window (child). The parent can set fields or functions on the
   * child usable from onload. E.g. background.js:
   * 
   * `function(created_window) { created_window.contentWindow.foo = function ()
   * { }; };`
   * 
   * window.js:
   * 
   *  `window.onload = function () { foo(); }`
   */
  Future<AppWindow> create(String url, [CreateWindowOptions options]) {
    if (_app_window == null) _throwNotAvailable();

    var completer = new ChromeCompleter<AppWindow>.oneArg(_createAppWindow);
    _app_window.callMethod('create', [url, jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Returns an [AppWindow] object for the current script context (ie JavaScript
   * 'window' object). This can also be called on a handle to a script context
   * for another page, for example: otherWindow.chrome.app.window.current().
   */
  AppWindow current() {
    if (_app_window == null) _throwNotAvailable();

    return _createAppWindow(_app_window.callMethod('current'));
  }

  void initializeAppWindow(dynamic state) {
    if (_app_window == null) _throwNotAvailable();

    _app_window.callMethod('initializeAppWindow', [jsify(state)]);
  }

  Stream get onBoundsChanged => _onBoundsChanged.stream;

  final ChromeStreamController _onBoundsChanged =
      new ChromeStreamController.noArgs(_app_window, 'onBoundsChanged');

  Stream get onClosed => _onClosed.stream;

  final ChromeStreamController _onClosed =
      new ChromeStreamController.noArgs(_app_window, 'onClosed');

  Stream get onFullscreened => _onFullscreened.stream;

  final ChromeStreamController _onFullscreened =
      new ChromeStreamController.noArgs(_app_window, 'onFullscreened');

  Stream get onMaximized => _onMaximized.stream;

  final ChromeStreamController _onMaximized =
      new ChromeStreamController.noArgs(_app_window, 'onMaximized');

  Stream get onMinimized => _onMinimized.stream;

  final ChromeStreamController _onMinimized =
      new ChromeStreamController.noArgs(_app_window, 'onMinimized');

  Stream get onRestored => _onRestored.stream;

  final ChromeStreamController _onRestored =
      new ChromeStreamController.noArgs(_app_window, 'onRestored');

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.app.window' is not available");
  }
}

/**
 * State of a window: normal, fullscreen, maximized, minimized.
 */
class State extends ChromeEnum {
  static const State NORMAL = const State._('normal');
  static const State FULLSCREEN = const State._('fullscreen');
  static const State MAXIMIZED = const State._('maximized');
  static const State MINIMIZED = const State._('minimized');

  static const List<State> VALUES = const[NORMAL, FULLSCREEN, MAXIMIZED, MINIMIZED];

  const State._(String str): super(str);
}

/**
 * 'shell' is the default window type. 'panel' is managed by the OS (Currently
 * experimental, Ash only).
 */
class WindowType extends ChromeEnum {
  static const WindowType SHELL = const WindowType._('shell');
  static const WindowType PANEL = const WindowType._('panel');

  static const List<WindowType> VALUES = const[SHELL, PANEL];

  const WindowType._(String str): super(str);
}

class CreateWindowOptions extends ChromeObject {
  CreateWindowOptions({String id, int defaultWidth, int defaultHeight, int defaultLeft, int defaultTop, int width, int height, int left, int top, int minWidth, int minHeight, int maxWidth, int maxHeight, WindowType type, String frame, Bounds bounds, bool transparentBackground, State state, bool hidden, bool resizable, bool singleton, bool alwaysOnTop}) {
    if (id != null) this.id = id;
    if (defaultWidth != null) this.defaultWidth = defaultWidth;
    if (defaultHeight != null) this.defaultHeight = defaultHeight;
    if (defaultLeft != null) this.defaultLeft = defaultLeft;
    if (defaultTop != null) this.defaultTop = defaultTop;
    if (width != null) this.width = width;
    if (height != null) this.height = height;
    if (left != null) this.left = left;
    if (top != null) this.top = top;
    if (minWidth != null) this.minWidth = minWidth;
    if (minHeight != null) this.minHeight = minHeight;
    if (maxWidth != null) this.maxWidth = maxWidth;
    if (maxHeight != null) this.maxHeight = maxHeight;
    if (type != null) this.type = type;
    if (frame != null) this.frame = frame;
    if (bounds != null) this.bounds = bounds;
    if (transparentBackground != null) this.transparentBackground = transparentBackground;
    if (state != null) this.state = state;
    if (hidden != null) this.hidden = hidden;
    if (resizable != null) this.resizable = resizable;
    if (singleton != null) this.singleton = singleton;
    if (alwaysOnTop != null) this.alwaysOnTop = alwaysOnTop;
  }
  CreateWindowOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  int get defaultWidth => jsProxy['defaultWidth'];
  set defaultWidth(int value) => jsProxy['defaultWidth'] = value;

  int get defaultHeight => jsProxy['defaultHeight'];
  set defaultHeight(int value) => jsProxy['defaultHeight'] = value;

  int get defaultLeft => jsProxy['defaultLeft'];
  set defaultLeft(int value) => jsProxy['defaultLeft'] = value;

  int get defaultTop => jsProxy['defaultTop'];
  set defaultTop(int value) => jsProxy['defaultTop'] = value;

  int get width => jsProxy['width'];
  set width(int value) => jsProxy['width'] = value;

  int get height => jsProxy['height'];
  set height(int value) => jsProxy['height'] = value;

  int get left => jsProxy['left'];
  set left(int value) => jsProxy['left'] = value;

  int get top => jsProxy['top'];
  set top(int value) => jsProxy['top'] = value;

  int get minWidth => jsProxy['minWidth'];
  set minWidth(int value) => jsProxy['minWidth'] = value;

  int get minHeight => jsProxy['minHeight'];
  set minHeight(int value) => jsProxy['minHeight'] = value;

  int get maxWidth => jsProxy['maxWidth'];
  set maxWidth(int value) => jsProxy['maxWidth'] = value;

  int get maxHeight => jsProxy['maxHeight'];
  set maxHeight(int value) => jsProxy['maxHeight'] = value;

  WindowType get type => _createWindowType(jsProxy['type']);
  set type(WindowType value) => jsProxy['type'] = jsify(value);

  String get frame => jsProxy['frame'];
  set frame(String value) => jsProxy['frame'] = value;

  Bounds get bounds => _createBounds(jsProxy['bounds']);
  set bounds(Bounds value) => jsProxy['bounds'] = jsify(value);

  bool get transparentBackground => jsProxy['transparentBackground'];
  set transparentBackground(bool value) => jsProxy['transparentBackground'] = value;

  State get state => _createState(jsProxy['state']);
  set state(State value) => jsProxy['state'] = jsify(value);

  bool get hidden => jsProxy['hidden'];
  set hidden(bool value) => jsProxy['hidden'] = value;

  bool get resizable => jsProxy['resizable'];
  set resizable(bool value) => jsProxy['resizable'] = value;

  bool get singleton => jsProxy['singleton'];
  set singleton(bool value) => jsProxy['singleton'] = value;

  bool get alwaysOnTop => jsProxy['alwaysOnTop'];
  set alwaysOnTop(bool value) => jsProxy['alwaysOnTop'] = value;
}

class AppWindow extends ChromeObject {
  AppWindow({Window contentWindow}) {
    if (contentWindow != null) this.contentWindow = contentWindow;
  }
  AppWindow.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  Window get contentWindow => _createWindow(jsProxy['contentWindow']);
  set contentWindow(Window value) => jsProxy['contentWindow'] = jsify(value);

  /**
   * Focus the window.
   */
  void focus() {
    jsProxy.callMethod('focus');
  }

  /**
   * Fullscreens the window.
   */
  void fullscreen() {
    jsProxy.callMethod('fullscreen');
  }

  /**
   * Is the window fullscreen?
   */
  bool isFullscreen() {
    return jsProxy.callMethod('isFullscreen');
  }

  /**
   * Minimize the window.
   */
  void minimize() {
    jsProxy.callMethod('minimize');
  }

  /**
   * Is the window minimized?
   */
  bool isMinimized() {
    return jsProxy.callMethod('isMinimized');
  }

  /**
   * Maximize the window.
   */
  void maximize() {
    jsProxy.callMethod('maximize');
  }

  /**
   * Is the window maximized?
   */
  bool isMaximized() {
    return jsProxy.callMethod('isMaximized');
  }

  /**
   * Restore the window, exiting a maximized, minimized, or fullscreen state.
   */
  void restore() {
    jsProxy.callMethod('restore');
  }

  /**
   * Move the window to the position ([left], [top]).
   */
  void moveTo(int left, int top) {
    jsProxy.callMethod('moveTo', [left, top]);
  }

  /**
   * Resize the window to [width]x[height] pixels in size.
   */
  void resizeTo(int width, int height) {
    jsProxy.callMethod('resizeTo', [width, height]);
  }

  /**
   * Draw attention to the window.
   */
  void drawAttention() {
    jsProxy.callMethod('drawAttention');
  }

  /**
   * Clear attention to the window.
   */
  void clearAttention() {
    jsProxy.callMethod('clearAttention');
  }

  /**
   * Close the window.
   */
  void close() {
    jsProxy.callMethod('close');
  }

  /**
   * Show the window. Does nothing if the window is already visible.
   */
  void show() {
    jsProxy.callMethod('show');
  }

  /**
   * Hide the window. Does nothing if the window is already hidden.
   */
  void hide() {
    jsProxy.callMethod('hide');
  }

  /**
   * Get the window's bounds as a [Bounds] object.
   */
  Bounds getBounds() {
    return _createBounds(jsProxy.callMethod('getBounds'));
  }

  /**
   * Set the window's bounds.
   */
  void setBounds(Bounds bounds) {
    jsProxy.callMethod('setBounds', [jsify(bounds)]);
  }

  /**
   * Set the app icon for the window (experimental). Currently this is only
   * being implemented on Ash. todo(stevenjb): Investigate implementing this on
   * Windows and OSX.
   */
  void setIcon(String icon_url) {
    jsProxy.callMethod('setIcon', [icon_url]);
  }

  /**
   * Is the window always on top? Currently available in the Dev channel only.
   */
  bool isAlwaysOnTop() {
    return jsProxy.callMethod('isAlwaysOnTop');
  }

  /**
   * Set whether the window should stay above most other windows. Currently
   * available in the Dev channel only.
   */
  void setAlwaysOnTop(bool always_on_top) {
    jsProxy.callMethod('setAlwaysOnTop', [always_on_top]);
  }
}

AppWindow _createAppWindow(JsObject jsProxy) => jsProxy == null ? null : new AppWindow.fromProxy(jsProxy);
WindowType _createWindowType(String value) => WindowType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
Bounds _createBounds(JsObject jsProxy) => jsProxy == null ? null : new Bounds.fromProxy(jsProxy);
State _createState(String value) => State.VALUES.singleWhere((ChromeEnum e) => e.value == value);
Window _createWindow(JsObject jsProxy) => jsProxy == null ? null : new Window.fromProxy(jsProxy);
