/* This file has been generated from windows.json - do not edit */

/**
 * Use the `chrome.windows` API to interact with browser windows. You can use
 * this API to create, modify, and rearrange windows in the browser.
 */
library chrome.windows;

import 'tabs.dart';
import '../src/common.dart';

/**
 * Accessor for the `chrome.windows` namespace.
 */
final ChromeWindows windows = new ChromeWindows._();

class ChromeWindows extends ChromeApi {
  static final JsObject _windows = chrome['windows'];

  ChromeWindows._();

  bool get available => _windows != null;

  /**
   * The windowId value that represents the absence of a chrome browser window.
   */
  int get WINDOW_ID_NONE => _windows['WINDOW_ID_NONE'];

  /**
   * The windowId value that represents the [current
   * window](windows.html#current-window).
   */
  int get WINDOW_ID_CURRENT => _windows['WINDOW_ID_CURRENT'];

  /**
   * Gets details about a window.
   * 
   * [getInfo]
   */
  Future<Window> get(int windowId, [WindowsGetParams getInfo]) {
    if (_windows == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Window>.oneArg(_createWindow);
    _windows.callMethod('get', [windowId, jsify(getInfo), completer.callback]);
    return completer.future;
  }

  /**
   * Gets the [current window](#current-window).
   * 
   * [getInfo]
   */
  Future<Window> getCurrent([WindowsGetCurrentParams getInfo]) {
    if (_windows == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Window>.oneArg(_createWindow);
    _windows.callMethod('getCurrent', [jsify(getInfo), completer.callback]);
    return completer.future;
  }

  /**
   * Gets the window that was most recently focused - typically the window 'on
   * top'.
   * 
   * [getInfo]
   */
  Future<Window> getLastFocused([WindowsGetLastFocusedParams getInfo]) {
    if (_windows == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Window>.oneArg(_createWindow);
    _windows.callMethod('getLastFocused', [jsify(getInfo), completer.callback]);
    return completer.future;
  }

  /**
   * Gets all windows.
   * 
   * [getInfo]
   */
  Future<List<Window>> getAll([WindowsGetAllParams getInfo]) {
    if (_windows == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<Window>>.oneArg((e) => listify(e, _createWindow));
    _windows.callMethod('getAll', [jsify(getInfo), completer.callback]);
    return completer.future;
  }

  /**
   * Creates (opens) a new browser with any optional sizing, position or default
   * URL provided.
   * 
   * Returns:
   * Contains details about the created window.
   */
  Future<Window> create([WindowsCreateParams createData]) {
    if (_windows == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Window>.oneArg(_createWindow);
    _windows.callMethod('create', [jsify(createData), completer.callback]);
    return completer.future;
  }

  /**
   * Updates the properties of a window. Specify only the properties that you
   * want to change; unspecified properties will be left unchanged.
   */
  Future<Window> update(int windowId, WindowsUpdateParams updateInfo) {
    if (_windows == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Window>.oneArg(_createWindow);
    _windows.callMethod('update', [windowId, jsify(updateInfo), completer.callback]);
    return completer.future;
  }

  /**
   * Removes (closes) a window, and all the tabs inside it.
   */
  Future remove(int windowId) {
    if (_windows == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _windows.callMethod('remove', [windowId, completer.callback]);
    return completer.future;
  }

  /**
   * Fired when a window is created.
   */
  Stream<Window> get onCreated => _onCreated.stream;

  final ChromeStreamController<Window> _onCreated =
      new ChromeStreamController<Window>.oneArg(_windows, 'onCreated', _createWindow);

  /**
   * Fired when a window is removed (closed).
   */
  Stream<int> get onRemoved => _onRemoved.stream;

  final ChromeStreamController<int> _onRemoved =
      new ChromeStreamController<int>.oneArg(_windows, 'onRemoved', selfConverter);

  /**
   * Fired when the currently focused window changes. Will be
   * chrome.windows.WINDOW_ID_NONE if all chrome windows have lost focus. Note:
   * On some Linux window managers, WINDOW_ID_NONE will always be sent
   * immediately preceding a switch from one chrome window to another.
   */
  Stream<int> get onFocusChanged => _onFocusChanged.stream;

  final ChromeStreamController<int> _onFocusChanged =
      new ChromeStreamController<int>.oneArg(_windows, 'onFocusChanged', selfConverter);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.windows' is not available");
  }
}

class Window extends ChromeObject {
  Window({int id, bool focused, int top, int left, int width, int height, List<Tab> tabs, bool incognito, String type, String state, bool alwaysOnTop, String sessionId}) {
    if (id != null) this.id = id;
    if (focused != null) this.focused = focused;
    if (top != null) this.top = top;
    if (left != null) this.left = left;
    if (width != null) this.width = width;
    if (height != null) this.height = height;
    if (tabs != null) this.tabs = tabs;
    if (incognito != null) this.incognito = incognito;
    if (type != null) this.type = type;
    if (state != null) this.state = state;
    if (alwaysOnTop != null) this.alwaysOnTop = alwaysOnTop;
    if (sessionId != null) this.sessionId = sessionId;
  }
  Window.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The ID of the window. Window IDs are unique within a browser session. Under
   * some circumstances a Window may not be assigned an ID, for example when
   * querying windows using the [sessions] API, in which case a session ID may
   * be present.
   */
  int get id => jsProxy['id'];
  set id(int value) => jsProxy['id'] = value;

  /**
   * Whether the window is currently the focused window.
   */
  bool get focused => jsProxy['focused'];
  set focused(bool value) => jsProxy['focused'] = value;

  /**
   * The offset of the window from the top edge of the screen in pixels. Under
   * some circumstances a Window may not be assigned top property, for example
   * when querying closed windows from the [sessions] API.
   */
  int get top => jsProxy['top'];
  set top(int value) => jsProxy['top'] = value;

  /**
   * The offset of the window from the left edge of the screen in pixels. Under
   * some circumstances a Window may not be assigned left property, for example
   * when querying closed windows from the [sessions] API.
   */
  int get left => jsProxy['left'];
  set left(int value) => jsProxy['left'] = value;

  /**
   * The width of the window, including the frame, in pixels. Under some
   * circumstances a Window may not be assigned width property, for example when
   * querying closed windows from the [sessions] API.
   */
  int get width => jsProxy['width'];
  set width(int value) => jsProxy['width'] = value;

  /**
   * The height of the window, including the frame, in pixels. Under some
   * circumstances a Window may not be assigned height property, for example
   * when querying closed windows from the [sessions] API.
   */
  int get height => jsProxy['height'];
  set height(int value) => jsProxy['height'] = value;

  /**
   * Array of [tabs.Tab] objects representing the current tabs in the window.
   */
  List<Tab> get tabs => listify(jsProxy['tabs'], _createTab);
  set tabs(List<Tab> value) => jsProxy['tabs'] = jsify(value);

  /**
   * Whether the window is incognito.
   */
  bool get incognito => jsProxy['incognito'];
  set incognito(bool value) => jsProxy['incognito'] = value;

  /**
   * The type of browser window this is. Under some circumstances a Window may
   * not be assigned type property, for example when querying closed windows
   * from the [sessions] API.
   * enum of `normal`, `popup`, `panel`, `app`
   */
  String get type => jsProxy['type'];
  set type(String value) => jsProxy['type'] = value;

  /**
   * The state of this browser window. Under some circumstances a Window may not
   * be assigned state property, for example when querying closed windows from
   * the [sessions] API.
   * enum of `normal`, `minimized`, `maximized`, `fullscreen`
   */
  String get state => jsProxy['state'];
  set state(String value) => jsProxy['state'] = value;

  /**
   * Whether the window is set to be always on top.
   */
  bool get alwaysOnTop => jsProxy['alwaysOnTop'];
  set alwaysOnTop(bool value) => jsProxy['alwaysOnTop'] = value;

  /**
   * The session ID used to uniquely identify a Window obtained from the
   * [sessions] API.
   */
  String get sessionId => jsProxy['sessionId'];
  set sessionId(String value) => jsProxy['sessionId'] = value;
}

class WindowsGetParams extends ChromeObject {
  WindowsGetParams({bool populate}) {
    if (populate != null) this.populate = populate;
  }
  WindowsGetParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * If true, the [windows.Window] object will have a [tabs] property that
   * contains a list of the [tabs.Tab] objects. The `Tab` objects only contain
   * the `url`, `title` and `favIconUrl` properties if the extension's manifest
   * file includes the `"tabs"` permission.
   */
  bool get populate => jsProxy['populate'];
  set populate(bool value) => jsProxy['populate'] = value;
}

class WindowsGetCurrentParams extends ChromeObject {
  WindowsGetCurrentParams({bool populate}) {
    if (populate != null) this.populate = populate;
  }
  WindowsGetCurrentParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * If true, the [windows.Window] object will have a [tabs] property that
   * contains a list of the [tabs.Tab] objects. The `Tab` objects only contain
   * the `url`, `title` and `favIconUrl` properties if the extension's manifest
   * file includes the `"tabs"` permission.
   */
  bool get populate => jsProxy['populate'];
  set populate(bool value) => jsProxy['populate'] = value;
}

class WindowsGetLastFocusedParams extends ChromeObject {
  WindowsGetLastFocusedParams({bool populate}) {
    if (populate != null) this.populate = populate;
  }
  WindowsGetLastFocusedParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * If true, the [windows.Window] object will have a [tabs] property that
   * contains a list of the [tabs.Tab] objects. The `Tab` objects only contain
   * the `url`, `title` and `favIconUrl` properties if the extension's manifest
   * file includes the `"tabs"` permission.
   */
  bool get populate => jsProxy['populate'];
  set populate(bool value) => jsProxy['populate'] = value;
}

class WindowsGetAllParams extends ChromeObject {
  WindowsGetAllParams({bool populate}) {
    if (populate != null) this.populate = populate;
  }
  WindowsGetAllParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * If true, each [windows.Window] object will have a [tabs] property that
   * contains a list of the [tabs.Tab] objects for that window. The `Tab`
   * objects only contain the `url`, `title` and `favIconUrl` properties if the
   * extension's manifest file includes the `"tabs"` permission.
   */
  bool get populate => jsProxy['populate'];
  set populate(bool value) => jsProxy['populate'] = value;
}

class WindowsCreateParams extends ChromeObject {
  WindowsCreateParams({var url, int tabId, int left, int top, int width, int height, bool focused, bool incognito, String type}) {
    if (url != null) this.url = url;
    if (tabId != null) this.tabId = tabId;
    if (left != null) this.left = left;
    if (top != null) this.top = top;
    if (width != null) this.width = width;
    if (height != null) this.height = height;
    if (focused != null) this.focused = focused;
    if (incognito != null) this.incognito = incognito;
    if (type != null) this.type = type;
  }
  WindowsCreateParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * A URL or array of URLs to open as tabs in the window. Fully-qualified URLs
   * must include a scheme (i.e. 'http://www.google.com', not 'www.google.com').
   * Relative URLs will be relative to the current page within the extension.
   * Defaults to the New Tab Page.
   */
  dynamic get url => jsProxy['url'];
  set url(var value) => jsProxy['url'] = jsify(value);

  /**
   * The id of the tab for which you want to adopt to the new window.
   */
  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;

  /**
   * The number of pixels to position the new window from the left edge of the
   * screen. If not specified, the new window is offset naturally from the last
   * focused window. This value is ignored for panels.
   */
  int get left => jsProxy['left'];
  set left(int value) => jsProxy['left'] = value;

  /**
   * The number of pixels to position the new window from the top edge of the
   * screen. If not specified, the new window is offset naturally from the last
   * focused window. This value is ignored for panels.
   */
  int get top => jsProxy['top'];
  set top(int value) => jsProxy['top'] = value;

  /**
   * The width in pixels of the new window, including the frame. If not
   * specified defaults to a natural width.
   */
  int get width => jsProxy['width'];
  set width(int value) => jsProxy['width'] = value;

  /**
   * The height in pixels of the new window, including the frame. If not
   * specified defaults to a natural height.
   */
  int get height => jsProxy['height'];
  set height(int value) => jsProxy['height'] = value;

  /**
   * If true, opens an active window. If false, opens an inactive window.
   */
  bool get focused => jsProxy['focused'];
  set focused(bool value) => jsProxy['focused'] = value;

  /**
   * Whether the new window should be an incognito window.
   */
  bool get incognito => jsProxy['incognito'];
  set incognito(bool value) => jsProxy['incognito'] = value;

  /**
   * Specifies what type of browser window to create. The 'panel' and
   * 'detached_panel' types create a popup unless the '--enable-panels' flag is
   * set.
   * enum of `normal`, `popup`, `panel`, `detached_panel`
   */
  String get type => jsProxy['type'];
  set type(String value) => jsProxy['type'] = value;
}

class WindowsUpdateParams extends ChromeObject {
  WindowsUpdateParams({int left, int top, int width, int height, bool focused, bool drawAttention, String state}) {
    if (left != null) this.left = left;
    if (top != null) this.top = top;
    if (width != null) this.width = width;
    if (height != null) this.height = height;
    if (focused != null) this.focused = focused;
    if (drawAttention != null) this.drawAttention = drawAttention;
    if (state != null) this.state = state;
  }
  WindowsUpdateParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The offset from the left edge of the screen to move the window to in
   * pixels. This value is ignored for panels.
   */
  int get left => jsProxy['left'];
  set left(int value) => jsProxy['left'] = value;

  /**
   * The offset from the top edge of the screen to move the window to in pixels.
   * This value is ignored for panels.
   */
  int get top => jsProxy['top'];
  set top(int value) => jsProxy['top'] = value;

  /**
   * The width to resize the window to in pixels. This value is ignored for
   * panels.
   */
  int get width => jsProxy['width'];
  set width(int value) => jsProxy['width'] = value;

  /**
   * The height to resize the window to in pixels. This value is ignored for
   * panels.
   */
  int get height => jsProxy['height'];
  set height(int value) => jsProxy['height'] = value;

  /**
   * If true, brings the window to the front. If false, brings the next window
   * in the z-order to the front.
   */
  bool get focused => jsProxy['focused'];
  set focused(bool value) => jsProxy['focused'] = value;

  /**
   * If true, causes the window to be displayed in a manner that draws the
   * user's attention to the window, without changing the focused window. The
   * effect lasts until the user changes focus to the window. This option has no
   * effect if the window already has focus. Set to false to cancel a previous
   * draw attention request.
   */
  bool get drawAttention => jsProxy['drawAttention'];
  set drawAttention(bool value) => jsProxy['drawAttention'] = value;

  /**
   * The new state of the window. The 'minimized', 'maximized' and 'fullscreen'
   * states cannot be combined with 'left', 'top', 'width' or 'height'.
   * enum of `normal`, `minimized`, `maximized`, `fullscreen`
   */
  String get state => jsProxy['state'];
  set state(String value) => jsProxy['state'] = value;
}

Window _createWindow(JsObject jsProxy) => jsProxy == null ? null : new Window.fromProxy(jsProxy);
Tab _createTab(JsObject jsProxy) => jsProxy == null ? null : new Tab.fromProxy(jsProxy);
