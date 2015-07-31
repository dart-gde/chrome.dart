/* This file has been generated - do not edit */

library chrome.app;

import '../src/common.dart';
import '../src/files.dart';
import 'windows.dart';

part 'app_patch.dart';

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
  JsObject get _app_runtime => chrome['app']['runtime'];

  Stream<EmbedRequest> get onEmbedRequested => _onEmbedRequested.stream;
  ChromeStreamController<EmbedRequest> _onEmbedRequested;

  Stream<LaunchData> get onLaunched => _onLaunched.stream;
  ChromeStreamController<LaunchData> _onLaunched;

  Stream get onRestarted => _onRestarted.stream;
  ChromeStreamController _onRestarted;

  ChromeAppRuntime._() {
    var getApi = () => _app_runtime;
    _onEmbedRequested = new ChromeStreamController<EmbedRequest>.oneArg(getApi, 'onEmbedRequested', _createEmbedRequest);
    _onLaunched = new ChromeStreamController<LaunchData>.oneArg(getApi, 'onLaunched', _createLaunchData);
    _onRestarted = new ChromeStreamController.noArgs(getApi, 'onRestarted');
  }

  bool get available => _app_runtime != null;
}

/**
 * Enumeration of app launch sources.
 */
class LaunchSource extends ChromeEnum {
  static const LaunchSource APP_LAUNCHER = const LaunchSource._('app_launcher');
  static const LaunchSource NEW_TAB_PAGE = const LaunchSource._('new_tab_page');
  static const LaunchSource RELOAD = const LaunchSource._('reload');
  static const LaunchSource RESTART = const LaunchSource._('restart');
  static const LaunchSource LOAD_AND_LAUNCH = const LaunchSource._('load_and_launch');
  static const LaunchSource COMMAND_LINE = const LaunchSource._('command_line');
  static const LaunchSource FILE_HANDLER = const LaunchSource._('file_handler');
  static const LaunchSource URL_HANDLER = const LaunchSource._('url_handler');
  static const LaunchSource SYSTEM_TRAY = const LaunchSource._('system_tray');
  static const LaunchSource ABOUT_PAGE = const LaunchSource._('about_page');
  static const LaunchSource KEYBOARD = const LaunchSource._('keyboard');
  static const LaunchSource EXTENSIONS_PAGE = const LaunchSource._('extensions_page');
  static const LaunchSource MANAGEMENT_API = const LaunchSource._('management_api');
  static const LaunchSource EPHEMERAL_APP = const LaunchSource._('ephemeral_app');
  static const LaunchSource BACKGROUND = const LaunchSource._('background');
  static const LaunchSource KIOSK = const LaunchSource._('kiosk');
  static const LaunchSource CHROME_INTERNAL = const LaunchSource._('chrome_internal');
  static const LaunchSource TEST = const LaunchSource._('test');

  static const List<LaunchSource> VALUES = const[APP_LAUNCHER, NEW_TAB_PAGE, RELOAD, RESTART, LOAD_AND_LAUNCH, COMMAND_LINE, FILE_HANDLER, URL_HANDLER, SYSTEM_TRAY, ABOUT_PAGE, KEYBOARD, EXTENSIONS_PAGE, MANAGEMENT_API, EPHEMERAL_APP, BACKGROUND, KIOSK, CHROME_INTERNAL, TEST];

  const LaunchSource._(String str): super(str);
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
  LaunchData({String id, List<LaunchItem> items, String url, String referrerUrl, bool isKioskSession, LaunchSource source}) {
    if (id != null) this.id = id;
    if (items != null) this.items = items;
    if (url != null) this.url = url;
    if (referrerUrl != null) this.referrerUrl = referrerUrl;
    if (isKioskSession != null) this.isKioskSession = isKioskSession;
    if (source != null) this.source = source;
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

  LaunchSource get source => _createLaunchSource(jsProxy['source']);
  set source(LaunchSource value) => jsProxy['source'] = jsify(value);
}

/**
 * This object specifies details and operations to perform on the embedding
 * request. The app to be embedded can make a decision on whether or not to
 * allow the embedding and what to embed based on the embedder making the
 * request.
 */
class EmbedRequest extends ChromeObject {
  EmbedRequest({String embedderId, dynamic data}) {
    if (embedderId != null) this.embedderId = embedderId;
    if (data != null) this.data = data;
  }
  EmbedRequest.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get embedderId => jsProxy['embedderId'];
  set embedderId(String value) => jsProxy['embedderId'] = value;

  dynamic get data => jsProxy['data'];
  set data(dynamic value) => jsProxy['data'] = jsify(value);

  /**
   * Allows `embedderId` to embed this app in an <appview> element. The `url`
   * specifies the content to embed.
   */
  void allow(String url) {
    jsProxy.callMethod('allow', [url]);
  }

  /**
   * Prevents ` embedderId` from embedding this app in an <appview> element.
   */
  void deny() {
    jsProxy.callMethod('deny');
  }
}

EmbedRequest _createEmbedRequest(JsObject jsProxy) => jsProxy == null ? null : new EmbedRequest.fromProxy(jsProxy);
LaunchData _createLaunchData(JsObject jsProxy) => jsProxy == null ? null : new LaunchData.fromProxy(jsProxy);
FileEntry _createFileEntry(JsObject jsProxy) => jsProxy == null ? null : new ChromeFileEntry.fromProxy(jsProxy);
LaunchItem _createLaunchItem(JsObject jsProxy) => jsProxy == null ? null : new LaunchItem.fromProxy(jsProxy);
LaunchSource _createLaunchSource(String value) => LaunchSource.VALUES.singleWhere((ChromeEnum e) => e.value == value);

/**
 * Use the `chrome.app.window` API to create windows. Windows have an optional
 * frame with title bar and size controls. They are not associated with any
 * Chrome browser windows. See the <a
 * href="https://github.com/GoogleChrome/chrome-app-samples/tree/master/samples/window-state">
 * Window State Sample</a> for a demonstration of these options.
 */
class _ChromeAppWindow extends ChromeApi {
  JsObject get _app_window => chrome['app']['window'];

  Stream get onBoundsChanged => _onBoundsChanged.stream;
  ChromeStreamController _onBoundsChanged;

  Stream get onClosed => _onClosed.stream;
  ChromeStreamController _onClosed;

  Stream get onFullscreened => _onFullscreened.stream;
  ChromeStreamController _onFullscreened;

  Stream get onMaximized => _onMaximized.stream;
  ChromeStreamController _onMaximized;

  Stream get onMinimized => _onMinimized.stream;
  ChromeStreamController _onMinimized;

  Stream get onRestored => _onRestored.stream;
  ChromeStreamController _onRestored;

  Stream get onAlphaEnabledChanged => _onAlphaEnabledChanged.stream;
  ChromeStreamController _onAlphaEnabledChanged;

  Stream get onWindowFirstShown => _onWindowFirstShown.stream;
  ChromeStreamController _onWindowFirstShown;

  _ChromeAppWindow._() {
    var getApi = () => _app_window;
    _onBoundsChanged = new ChromeStreamController.noArgs(getApi, 'onBoundsChanged');
    _onClosed = new ChromeStreamController.noArgs(getApi, 'onClosed');
    _onFullscreened = new ChromeStreamController.noArgs(getApi, 'onFullscreened');
    _onMaximized = new ChromeStreamController.noArgs(getApi, 'onMaximized');
    _onMinimized = new ChromeStreamController.noArgs(getApi, 'onMinimized');
    _onRestored = new ChromeStreamController.noArgs(getApi, 'onRestored');
    _onAlphaEnabledChanged = new ChromeStreamController.noArgs(getApi, 'onAlphaEnabledChanged');
    _onWindowFirstShown = new ChromeStreamController.noArgs(getApi, 'onWindowFirstShown');
  }

  bool get available => _app_window != null;

  /**
   * The size and position of a window can be specified in a number of different
   * ways. The most simple option is not specifying anything at all, in which
   * case a default size and platform dependent position will be used.
   * 
   * To set the position, size and constraints of the window, use the
   * `innerBounds` or `outerBounds` properties. Inner bounds do not include
   * window decorations. Outer bounds include the window's title bar and frame.
   * Note that the padding between the inner and outer bounds is determined by
   * the OS. Therefore setting the same property for both inner and outer bounds
   * is considered an error (for example, setting both `innerBounds.left` and
   * `outerBounds.left`).
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
   * `function(createdWindow) { createdWindow.contentWindow.foo = function () {
   * }; };`
   * 
   * window.js:
   * 
   * `window.onload = function () { foo(); }`
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

  /**
   * Gets an array of all currently created app windows. This method is new in
   * Chrome 33.
   */
  List<AppWindow> getAll() {
    if (_app_window == null) _throwNotAvailable();

    var ret = _app_window.callMethod('getAll');
    return ret;
  }

  /**
   * Gets an [AppWindow] with the given id. If no window with the given id
   * exists null is returned. This method is new in Chrome 33.
   */
  AppWindow get(String id) {
    if (_app_window == null) _throwNotAvailable();

    return _createAppWindow(_app_window.callMethod('get', [id]));
  }

  /**
   * Does the current platform support windows being visible on all workspaces?
   */
  bool canSetVisibleOnAllWorkspaces() {
    if (_app_window == null) _throwNotAvailable();

    return _app_window.callMethod('canSetVisibleOnAllWorkspaces');
  }

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

/**
 * Previously named Bounds.
 */
class ContentBounds extends ChromeObject {
  ContentBounds({int left, int top, int width, int height}) {
    if (left != null) this.left = left;
    if (top != null) this.top = top;
    if (width != null) this.width = width;
    if (height != null) this.height = height;
  }
  ContentBounds.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get left => jsProxy['left'];
  set left(int value) => jsProxy['left'] = value;

  int get top => jsProxy['top'];
  set top(int value) => jsProxy['top'] = value;

  int get width => jsProxy['width'];
  set width(int value) => jsProxy['width'] = value;

  int get height => jsProxy['height'];
  set height(int value) => jsProxy['height'] = value;
}

class BoundsSpecification extends ChromeObject {
  BoundsSpecification({int left, int top, int width, int height, int minWidth, int minHeight, int maxWidth, int maxHeight}) {
    if (left != null) this.left = left;
    if (top != null) this.top = top;
    if (width != null) this.width = width;
    if (height != null) this.height = height;
    if (minWidth != null) this.minWidth = minWidth;
    if (minHeight != null) this.minHeight = minHeight;
    if (maxWidth != null) this.maxWidth = maxWidth;
    if (maxHeight != null) this.maxHeight = maxHeight;
  }
  BoundsSpecification.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get left => jsProxy['left'];
  set left(int value) => jsProxy['left'] = value;

  int get top => jsProxy['top'];
  set top(int value) => jsProxy['top'] = value;

  int get width => jsProxy['width'];
  set width(int value) => jsProxy['width'] = value;

  int get height => jsProxy['height'];
  set height(int value) => jsProxy['height'] = value;

  int get minWidth => jsProxy['minWidth'];
  set minWidth(int value) => jsProxy['minWidth'] = value;

  int get minHeight => jsProxy['minHeight'];
  set minHeight(int value) => jsProxy['minHeight'] = value;

  int get maxWidth => jsProxy['maxWidth'];
  set maxWidth(int value) => jsProxy['maxWidth'] = value;

  int get maxHeight => jsProxy['maxHeight'];
  set maxHeight(int value) => jsProxy['maxHeight'] = value;
}

class FrameOptions extends ChromeObject {
  FrameOptions({String type, String color, String activeColor, String inactiveColor}) {
    if (type != null) this.type = type;
    if (color != null) this.color = color;
    if (activeColor != null) this.activeColor = activeColor;
    if (inactiveColor != null) this.inactiveColor = inactiveColor;
  }
  FrameOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get type => jsProxy['type'];
  set type(String value) => jsProxy['type'] = value;

  String get color => jsProxy['color'];
  set color(String value) => jsProxy['color'] = value;

  String get activeColor => jsProxy['activeColor'];
  set activeColor(String value) => jsProxy['activeColor'] = value;

  String get inactiveColor => jsProxy['inactiveColor'];
  set inactiveColor(String value) => jsProxy['inactiveColor'] = value;
}

class CreateWindowOptions extends ChromeObject {
  CreateWindowOptions({String id, BoundsSpecification innerBounds, BoundsSpecification outerBounds, int defaultWidth, int defaultHeight, int defaultLeft, int defaultTop, int width, int height, int left, int top, int minWidth, int minHeight, int maxWidth, int maxHeight, WindowType type, bool ime, var frame, ContentBounds bounds, bool alphaEnabled, State state, bool hidden, bool resizable, bool singleton, bool alwaysOnTop, bool focused, bool visibleOnAllWorkspaces}) {
    if (id != null) this.id = id;
    if (innerBounds != null) this.innerBounds = innerBounds;
    if (outerBounds != null) this.outerBounds = outerBounds;
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
    if (ime != null) this.ime = ime;
    if (frame != null) this.frame = frame;
    if (bounds != null) this.bounds = bounds;
    if (alphaEnabled != null) this.alphaEnabled = alphaEnabled;
    if (state != null) this.state = state;
    if (hidden != null) this.hidden = hidden;
    if (resizable != null) this.resizable = resizable;
    if (singleton != null) this.singleton = singleton;
    if (alwaysOnTop != null) this.alwaysOnTop = alwaysOnTop;
    if (focused != null) this.focused = focused;
    if (visibleOnAllWorkspaces != null) this.visibleOnAllWorkspaces = visibleOnAllWorkspaces;
  }
  CreateWindowOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  BoundsSpecification get innerBounds => _createBoundsSpecification(jsProxy['innerBounds']);
  set innerBounds(BoundsSpecification value) => jsProxy['innerBounds'] = jsify(value);

  BoundsSpecification get outerBounds => _createBoundsSpecification(jsProxy['outerBounds']);
  set outerBounds(BoundsSpecification value) => jsProxy['outerBounds'] = jsify(value);

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

  bool get ime => jsProxy['ime'];
  set ime(bool value) => jsProxy['ime'] = value;

  dynamic get frame => jsProxy['frame'];
  set frame(var value) => jsProxy['frame'] = jsify(value);

  ContentBounds get bounds => _createContentBounds(jsProxy['bounds']);
  set bounds(ContentBounds value) => jsProxy['bounds'] = jsify(value);

  bool get alphaEnabled => jsProxy['alphaEnabled'];
  set alphaEnabled(bool value) => jsProxy['alphaEnabled'] = value;

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

  bool get focused => jsProxy['focused'];
  set focused(bool value) => jsProxy['focused'] = value;

  bool get visibleOnAllWorkspaces => jsProxy['visibleOnAllWorkspaces'];
  set visibleOnAllWorkspaces(bool value) => jsProxy['visibleOnAllWorkspaces'] = value;
}

class _AppWindow extends ChromeObject {
  _AppWindow({bool hasFrameColor, int activeFrameColor, int inactiveFrameColor, bool firstShowHasHappened, Window contentWindow, String id, Bounds innerBounds, Bounds outerBounds}) {
    if (hasFrameColor != null) this.hasFrameColor = hasFrameColor;
    if (activeFrameColor != null) this.activeFrameColor = activeFrameColor;
    if (inactiveFrameColor != null) this.inactiveFrameColor = inactiveFrameColor;
    if (firstShowHasHappened != null) this.firstShowHasHappened = firstShowHasHappened;
    if (contentWindow != null) this.contentWindow = contentWindow;
    if (id != null) this.id = id;
    if (innerBounds != null) this.innerBounds = innerBounds;
    if (outerBounds != null) this.outerBounds = outerBounds;
  }
  _AppWindow.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  bool get hasFrameColor => jsProxy['hasFrameColor'];
  set hasFrameColor(bool value) => jsProxy['hasFrameColor'] = value;

  int get activeFrameColor => jsProxy['activeFrameColor'];
  set activeFrameColor(int value) => jsProxy['activeFrameColor'] = value;

  int get inactiveFrameColor => jsProxy['inactiveFrameColor'];
  set inactiveFrameColor(int value) => jsProxy['inactiveFrameColor'] = value;

  bool get firstShowHasHappened => jsProxy['firstShowHasHappened'];
  set firstShowHasHappened(bool value) => jsProxy['firstShowHasHappened'] = value;

  Window get contentWindow => _createWindow(jsProxy['contentWindow']);
  set contentWindow(Window value) => jsProxy['contentWindow'] = jsify(value);

  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  Bounds get innerBounds => _createBounds(jsProxy['innerBounds']);
  set innerBounds(Bounds value) => jsProxy['innerBounds'] = jsify(value);

  Bounds get outerBounds => _createBounds(jsProxy['outerBounds']);
  set outerBounds(Bounds value) => jsProxy['outerBounds'] = jsify(value);

  /**
   * Focus the window.
   */
  void focus() {
    jsProxy.callMethod('focus');
  }

  /**
   * Fullscreens the window.
   * 
   * The user will be able to restore the window by pressing ESC. An application
   * can prevent the fullscreen state to be left when ESC is pressed by
   * requesting the `app.window.fullscreen.overrideEsc` permission and canceling
   * the event by calling .preventDefault(), in the keydown and keyup handlers,
   * like this:
   * 
   * `window.onkeydown = window.onkeyup = function(e) { if (e.keyCode == 27 /
   * ESC /) { e.preventDefault(); } };`
   * 
   * Note `window.fullscreen()` will cause the entire window to become
   * fullscreen and does not require a user gesture. The HTML5 fullscreen API
   * can also be used to enter fullscreen mode (see <a
   * href="http://developer.chrome.com/apps/api_other.html">Web APIs</a> for
   * more details).
   */
  void fullscreen() {
    jsProxy.callMethod('fullscreen');
  }

  /**
   * Is the window fullscreen? This will be true if the window has been created
   * fullscreen or was made fullscreen via the `AppWindow` or HTML5 fullscreen
   * APIs.
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
   * Show the window. Does nothing if the window is already visible. Focus the
   * window if [focused] is set to true or omitted.
   */
  void show([bool focused]) {
    jsProxy.callMethod('show', [focused]);
  }

  /**
   * Hide the window. Does nothing if the window is already hidden.
   */
  void hide() {
    jsProxy.callMethod('hide');
  }

  /**
   * Get the window's inner bounds as a [ContentBounds] object.
   */
  ContentBounds getBounds() {
    return _createContentBounds(jsProxy.callMethod('getBounds'));
  }

  /**
   * Set the window's inner bounds.
   */
  void setBounds(ContentBounds bounds) {
    jsProxy.callMethod('setBounds', [jsify(bounds)]);
  }

  /**
   * Set the app icon for the window (experimental). Currently this is only
   * being implemented on Ash. todo(stevenjb): Investigate implementing this on
   * Windows and OSX.
   */
  void setIcon(String iconUrl) {
    jsProxy.callMethod('setIcon', [iconUrl]);
  }

  /**
   * Is the window always on top?
   */
  bool isAlwaysOnTop() {
    return jsProxy.callMethod('isAlwaysOnTop');
  }

  /**
   * Set whether the window should stay above most other windows. Requires the
   * `alwaysOnTopWindows` permission.
   */
  void setAlwaysOnTop(bool alwaysOnTop) {
    jsProxy.callMethod('setAlwaysOnTop', [alwaysOnTop]);
  }

  /**
   * Can the window use alpha transparency? todo(jackhou): Document this
   * properly before going to stable.
   */
  bool alphaEnabled() {
    return jsProxy.callMethod('alphaEnabled');
  }

  /**
   * For platforms that support multiple workspaces, is this window visible on
   * all of them?
   */
  void setVisibleOnAllWorkspaces(bool alwaysVisible) {
    jsProxy.callMethod('setVisibleOnAllWorkspaces', [alwaysVisible]);
  }

  /**
   * Set whether the window should get all keyboard events including system keys
   * that are usually not sent. This is best-effort subject to platform specific
   * constraints. Requires the `"app.window.allKeys"` permission. This is
   * currently available only in dev channel on Windows.
   */
  void setInterceptAllKeys(bool wantAllKeys) {
    jsProxy.callMethod('setInterceptAllKeys', [wantAllKeys]);
  }
}

AppWindow _createAppWindow(JsObject jsProxy) => jsProxy == null ? null : new AppWindow.fromProxy(jsProxy);
BoundsSpecification _createBoundsSpecification(JsObject jsProxy) => jsProxy == null ? null : new BoundsSpecification.fromProxy(jsProxy);
WindowType _createWindowType(String value) => WindowType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
ContentBounds _createContentBounds(JsObject jsProxy) => jsProxy == null ? null : new ContentBounds.fromProxy(jsProxy);
State _createState(String value) => State.VALUES.singleWhere((ChromeEnum e) => e.value == value);
Window _createWindow(JsObject jsProxy) => jsProxy == null ? null : new Window.fromProxy(jsProxy);
Bounds _createBounds(JsObject jsProxy) => jsProxy == null ? null : new Bounds.fromProxy(jsProxy);
