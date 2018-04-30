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
  JsObject get _windows => chrome['windows'];

  /**
   * Fired when a window is created.
   */
  Stream<Window> get onCreated => _onCreated.stream;
  ChromeStreamController<Window> _onCreated;

  /**
   * Fired when a window is removed (closed).
   */
  Stream<int> get onRemoved => _onRemoved.stream;
  ChromeStreamController<int> _onRemoved;

  /**
   * Fired when the currently focused window changes. Will be
   * chrome.windows.WINDOW_ID_NONE if all chrome windows have lost focus. Note:
   * On some Linux window managers, WINDOW_ID_NONE will always be sent
   * immediately preceding a switch from one chrome window to another.
   */
  Stream<int> get onFocusChanged => _onFocusChanged.stream;
  ChromeStreamController<int> _onFocusChanged;

  ChromeWindows._() {
    var getApi = () => _windows;
    _onCreated = new ChromeStreamController<Window>.oneArg(getApi, 'onCreated', _createWindow);
    _onRemoved = new ChromeStreamController<int>.oneArg(getApi, 'onRemoved', selfConverter);
    _onFocusChanged = new ChromeStreamController<int>.oneArg(getApi, 'onFocusChanged', selfConverter);
  }

  bool get available => _windows != null;

  /**
   * The windowId value that represents the absence of a chrome browser window.
   */
  int get WINDOW_ID_NONE => _windows['WINDOW_ID_NONE'];

  /**
   * The windowId value that represents the [current
   * window](windows#current-window).
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

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.windows' is not available");
  }
}

/**
 * The type of browser window this is. Under some circumstances a Window may not
 * be assigned type property, for example when querying closed windows from the
 * [sessions] API.
 */
class WindowWindowType extends ChromeEnum {
  /**
   * A normal browser window.
   */
  static const WindowWindowType NORMAL = const WindowWindowType._('normal');
  /**
   * A browser popup window.
   */
  static const WindowWindowType POPUP = const WindowWindowType._('popup');
  /**
   * <i>Deprecated in this API.</i> A Chrome App panel-style window. Extensions
   * can only see their own panel windows.
   */
  static const WindowWindowType PANEL = const WindowWindowType._('panel');
  /**
   * <i>Deprecated in this API.</i> A Chrome App window. Extensions can only see
   * their app own windows.
   */
  static const WindowWindowType APP = const WindowWindowType._('app');
  /**
   * A devtools window.
   */
  static const WindowWindowType DEVTOOLS = const WindowWindowType._('devtools');

  static const List<WindowWindowType> VALUES = const[NORMAL, POPUP, PANEL, APP, DEVTOOLS];

  const WindowWindowType._(String str): super(str);
}

/**
 * The state of this browser window. Under some circumstances a Window may not
 * be assigned state property, for example when querying closed windows from the
 * [sessions] API.
 */
class WindowState extends ChromeEnum {
  /**
   * Normal window state (i.e. not minimized, maximized, or fullscreen).
   */
  static const WindowState NORMAL = const WindowState._('normal');
  /**
   * Minimized window state.
   */
  static const WindowState MINIMIZED = const WindowState._('minimized');
  /**
   * Maximized window state.
   */
  static const WindowState MAXIMIZED = const WindowState._('maximized');
  /**
   * Fullscreen window state.
   */
  static const WindowState FULLSCREEN = const WindowState._('fullscreen');
  /**
   * <i>Deprecated since Chrome M59.</i> Docked windows are no longer supported.
   * This state will be converted to "normal".
   */
  static const WindowState DOCKED = const WindowState._('docked');
  /**
   * Locked fullscreen window state. This fullscreen state cannot be exited by
   * user action. It is available only to whitelisted extensions on Chrome OS.
   */
  static const WindowState LOCKED_FULLSCREEN = const WindowState._('locked-fullscreen');

  static const List<WindowState> VALUES = const[NORMAL, MINIMIZED, MAXIMIZED, FULLSCREEN, DOCKED, LOCKED_FULLSCREEN];

  const WindowState._(String str): super(str);
}

/**
 * Specifies what type of browser window to create. 'panel' is deprecated and
 * only available to existing whitelisted extensions on Chrome OS.
 */
class CreateType extends ChromeEnum {
  static const CreateType NORMAL = const CreateType._('normal');
  static const CreateType POPUP = const CreateType._('popup');
  static const CreateType PANEL = const CreateType._('panel');

  static const List<CreateType> VALUES = const[NORMAL, POPUP, PANEL];

  const CreateType._(String str): super(str);
}

class Window extends ChromeObject {
  Window({int id, bool focused, int top, int left, int width, int height, List<Tab> tabs, bool incognito, WindowWindowType type, WindowState state, bool alwaysOnTop, String sessionId}) {
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
   * The type of browser window this is.
   */
  WindowWindowType get type => _createWindowType(jsProxy['type']);
  set type(WindowWindowType value) => jsProxy['type'] = jsify(value);

  /**
   * The state of this browser window.
   */
  WindowState get state => _createWindowState(jsProxy['state']);
  set state(WindowState value) => jsProxy['state'] = jsify(value);

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
  WindowsGetParams({bool populate, List<WindowWindowType> windowTypes}) {
    if (populate != null) this.populate = populate;
    if (windowTypes != null) this.windowTypes = windowTypes;
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

  /**
   * If set, the [windows.Window] returned will be filtered based on its type.
   * If unset the default filter is set to `['normal', 'popup']`.
   */
  List<WindowWindowType> get windowTypes => listify(jsProxy['windowTypes'], _createWindowType);
  set windowTypes(List<WindowWindowType> value) => jsProxy['windowTypes'] = jsify(value);
}

class WindowsGetCurrentParams extends ChromeObject {
  WindowsGetCurrentParams({bool populate, List<WindowWindowType> windowTypes}) {
    if (populate != null) this.populate = populate;
    if (windowTypes != null) this.windowTypes = windowTypes;
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

  /**
   * If set, the [windows.Window] returned will be filtered based on its type.
   * If unset the default filter is set to `['normal', 'popup']`.
   */
  List<WindowWindowType> get windowTypes => listify(jsProxy['windowTypes'], _createWindowType);
  set windowTypes(List<WindowWindowType> value) => jsProxy['windowTypes'] = jsify(value);
}

class WindowsGetLastFocusedParams extends ChromeObject {
  WindowsGetLastFocusedParams({bool populate, List<WindowWindowType> windowTypes}) {
    if (populate != null) this.populate = populate;
    if (windowTypes != null) this.windowTypes = windowTypes;
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

  /**
   * If set, the [windows.Window] returned will be filtered based on its type.
   * If unset the default filter is set to `['normal', 'popup']`.
   */
  List<WindowWindowType> get windowTypes => listify(jsProxy['windowTypes'], _createWindowType);
  set windowTypes(List<WindowWindowType> value) => jsProxy['windowTypes'] = jsify(value);
}

class WindowsGetAllParams extends ChromeObject {
  WindowsGetAllParams({bool populate, List<WindowWindowType> windowTypes}) {
    if (populate != null) this.populate = populate;
    if (windowTypes != null) this.windowTypes = windowTypes;
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

  /**
   * If set, the [windows.Window] returned will be filtered based on its type.
   * If unset the default filter is set to `['normal', 'popup']`.
   */
  List<WindowWindowType> get windowTypes => listify(jsProxy['windowTypes'], _createWindowType);
  set windowTypes(List<WindowWindowType> value) => jsProxy['windowTypes'] = jsify(value);
}

class WindowsCreateParams extends ChromeObject {
  WindowsCreateParams({var url, int tabId, int left, int top, int width, int height, bool focused, bool incognito, CreateType type, WindowState state, bool setSelfAsOpener}) {
    if (url != null) this.url = url;
    if (tabId != null) this.tabId = tabId;
    if (left != null) this.left = left;
    if (top != null) this.top = top;
    if (width != null) this.width = width;
    if (height != null) this.height = height;
    if (focused != null) this.focused = focused;
    if (incognito != null) this.incognito = incognito;
    if (type != null) this.type = type;
    if (state != null) this.state = state;
    if (setSelfAsOpener != null) this.setSelfAsOpener = setSelfAsOpener;
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
   * Specifies what type of browser window to create.
   */
  CreateType get type => _createCreateType(jsProxy['type']);
  set type(CreateType value) => jsProxy['type'] = jsify(value);

  /**
   * The initial state of the window. The 'minimized', 'maximized' and
   * 'fullscreen' states cannot be combined with 'left', 'top', 'width' or
   * 'height'.
   */
  WindowState get state => _createWindowState(jsProxy['state']);
  set state(WindowState value) => jsProxy['state'] = jsify(value);

  /**
   * If 'setSelfAsOpener' is true, then the newly created window will have its
   * 'window.opener' set to the caller and will be in the same [unit of related
   * browsing
   * contexts](https://www.w3.org/TR/html51/browsers.html#unit-of-related-browsing-contexts)
   * as the caller.
   */
  bool get setSelfAsOpener => jsProxy['setSelfAsOpener'];
  set setSelfAsOpener(bool value) => jsProxy['setSelfAsOpener'] = value;
}

class WindowsUpdateParams extends ChromeObject {
  WindowsUpdateParams({int left, int top, int width, int height, bool focused, bool drawAttention, WindowState state}) {
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
   */
  WindowState get state => _createWindowState(jsProxy['state']);
  set state(WindowState value) => jsProxy['state'] = jsify(value);
}

Window _createWindow(JsObject jsProxy) => jsProxy == null ? null : new Window.fromProxy(jsProxy);
Tab _createTab(JsObject jsProxy) => jsProxy == null ? null : new Tab.fromProxy(jsProxy);
WindowWindowType _createWindowType(String value) => WindowWindowType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
WindowState _createWindowState(String value) => WindowState.VALUES.singleWhere((ChromeEnum e) => e.value == value);
CreateType _createCreateType(String value) => CreateType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
