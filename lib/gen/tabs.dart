/* This file has been generated from tabs.json - do not edit */

/**
 * Use the `chrome.tabs` API to interact with the browser's tab system. You can
 * use this API to create, modify, and rearrange tabs in the browser.
 */
library chrome.tabs;

import 'runtime.dart';
import 'windows.dart';
import '../src/common.dart';

/**
 * Accessor for the `chrome.tabs` namespace.
 */
final ChromeTabs tabs = new ChromeTabs._();

class ChromeTabs extends ChromeApi {
  static final JsObject _tabs = chrome['tabs'];

  ChromeTabs._();

  bool get available => _tabs != null;

  /**
   * Retrieves details about the specified tab.
   */
  Future<Tab> get(int tabId) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Tab>.oneArg(_createTab);
    _tabs.callMethod('get', [tabId, completer.callback]);
    return completer.future;
  }

  /**
   * Gets the tab that this script call is being made from. May be undefined if
   * called from a non-tab context (for example: a background page or popup
   * view).
   */
  Future<Tab> getCurrent() {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Tab>.oneArg(_createTab);
    _tabs.callMethod('getCurrent', [completer.callback]);
    return completer.future;
  }

  /**
   * Connects to the content script(s) in the specified tab. The
   * [runtime.onConnect] event is fired in each content script running in the
   * specified tab for the current extension. For more details, see [Content
   * Script Messaging](messaging.html).
   * 
   * Returns:
   * A port that can be used to communicate with the content scripts running in
   * the specified tab. The port's [runtime.Port] event is fired if the tab
   * closes or does not exist.
   */
  Port connect(int tabId, [TabsConnectParams connectInfo]) {
    if (_tabs == null) _throwNotAvailable();

    return _createPort(_tabs.callMethod('connect', [tabId, jsify(connectInfo)]));
  }

  /**
   * Deprecated: Please use sendMessage.
   * 
   * Returns:
   * The JSON response object sent by the handler of the request. If an error
   * occurs while connecting to the specified tab, the callback will be called
   * with no arguments and [runtime.lastError] will be set to the error message.
   */
  Future<dynamic> sendRequest(int tabId, dynamic request) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter<dynamic>.oneArg();
    _tabs.callMethod('sendRequest', [tabId, jsify(request), completer.callback]);
    return completer.future;
  }

  /**
   * Sends a single message to the content script(s) in the specified tab, with
   * an optional callback to run when a response is sent back.  The
   * [runtime.onMessage] event is fired in each content script running in the
   * specified tab for the current extension.
   * 
   * Returns:
   * The JSON response object sent by the handler of the message. If an error
   * occurs while connecting to the specified tab, the callback will be called
   * with no arguments and [runtime.lastError] will be set to the error message.
   */
  Future<dynamic> sendMessage(int tabId, dynamic message) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter<dynamic>.oneArg();
    _tabs.callMethod('sendMessage', [tabId, jsify(message), completer.callback]);
    return completer.future;
  }

  /**
   * Deprecated. Please use query({'active': true}). Gets the tab that is
   * selected in the specified window.
   * 
   * [windowId] Defaults to the [current window](windows.html#current-window).
   */
  Future<Tab> getSelected([int windowId]) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Tab>.oneArg(_createTab);
    _tabs.callMethod('getSelected', [windowId, completer.callback]);
    return completer.future;
  }

  /**
   * Deprecated. Please use query({'windowId': windowId}). Gets details about
   * all tabs in the specified window.
   * 
   * [windowId] Defaults to the [current window](windows.html#current-window).
   */
  Future<List<Tab>> getAllInWindow([int windowId]) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<Tab>>.oneArg((e) => listify(e, _createTab));
    _tabs.callMethod('getAllInWindow', [windowId, completer.callback]);
    return completer.future;
  }

  /**
   * Creates a new tab.
   * 
   * Returns:
   * Details about the created tab. Will contain the ID of the new tab.
   */
  Future<Tab> create(TabsCreateParams createProperties) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Tab>.oneArg(_createTab);
    _tabs.callMethod('create', [jsify(createProperties), completer.callback]);
    return completer.future;
  }

  /**
   * Duplicates a tab.
   * 
   * [tabId] The ID of the tab which is to be duplicated.
   * 
   * Returns:
   * Details about the duplicated tab. The [tabs.Tab] object doesn't contain
   * `url`, `title` and `favIconUrl` if the `"tabs"` permission has not been
   * requested.
   */
  Future<Tab> duplicate(int tabId) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Tab>.oneArg(_createTab);
    _tabs.callMethod('duplicate', [tabId, completer.callback]);
    return completer.future;
  }

  /**
   * Gets all tabs that have the specified properties, or all tabs if no
   * properties are specified.
   */
  Future<List<Tab>> query(TabsQueryParams queryInfo) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<Tab>>.oneArg((e) => listify(e, _createTab));
    _tabs.callMethod('query', [jsify(queryInfo), completer.callback]);
    return completer.future;
  }

  /**
   * Highlights the given tabs.
   * 
   * Returns:
   * Contains details about the window whose tabs were highlighted.
   */
  Future<Window> highlight(TabsHighlightParams highlightInfo) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Window>.oneArg(_createWindow);
    _tabs.callMethod('highlight', [jsify(highlightInfo), completer.callback]);
    return completer.future;
  }

  /**
   * Modifies the properties of a tab. Properties that are not specified in
   * [updateProperties] are not modified.
   * 
   * [tabId] Defaults to the selected tab of the [current
   * window](windows.html#current-window).
   * 
   * Returns:
   * Details about the updated tab. The [tabs.Tab] object doesn't contain `url`,
   * `title` and `favIconUrl` if the `"tabs"` permission has not been requested.
   */
  Future<Tab> update(TabsUpdateParams updateProperties, [int tabId]) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Tab>.oneArg(_createTab);
    _tabs.callMethod('update', [tabId, jsify(updateProperties), completer.callback]);
    return completer.future;
  }

  /**
   * Moves one or more tabs to a new position within its window, or to a new
   * window. Note that tabs can only be moved to and from normal (window.type
   * === "normal") windows.
   * 
   * [tabIds] The tab or list of tabs to move.
   * 
   * Returns:
   * Details about the moved tabs.
   */
  Future<dynamic> move(dynamic tabIds, TabsMoveParams moveProperties) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter<dynamic>.oneArg();
    _tabs.callMethod('move', [jsify(tabIds), jsify(moveProperties), completer.callback]);
    return completer.future;
  }

  /**
   * Reload a tab.
   * 
   * [tabId] The ID of the tab to reload; defaults to the selected tab of the
   * current window.
   */
  Future reload([int tabId, TabsReloadParams reloadProperties]) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _tabs.callMethod('reload', [tabId, jsify(reloadProperties), completer.callback]);
    return completer.future;
  }

  /**
   * Closes one or more tabs.
   * 
   * [tabIds] The tab or list of tabs to close.
   */
  Future remove(dynamic tabIds) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _tabs.callMethod('remove', [jsify(tabIds), completer.callback]);
    return completer.future;
  }

  /**
   * Detects the primary language of the content in a tab.
   * 
   * [tabId] Defaults to the active tab of the [current
   * window](windows.html#current-window).
   * 
   * Returns:
   * An ISO language code such as `en` or `fr`. For a complete list of languages
   * supported by this method, see
   * [kLanguageInfoTable](http://src.chromium.org/viewvc/chrome/trunk/src/third_party/cld/languages/internal/languages.cc).
   * The 2nd to 4th columns will be checked and the first non-NULL value will be
   * returned except for Simplified Chinese for which zh-CN will be returned.
   * For an unknown language, `und` will be returned.
   */
  Future<String> detectLanguage([int tabId]) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter<String>.oneArg();
    _tabs.callMethod('detectLanguage', [tabId, completer.callback]);
    return completer.future;
  }

  /**
   * Captures the visible area of the currently active tab in the specified
   * window. You must have [host permission](declare_permissions.html) for the
   * URL displayed by the tab.
   * 
   * [windowId] The target window. Defaults to the [current
   * window](windows.html#current-window).
   * 
   * [options] Set parameters of image capture, such as the format of the
   * resulting image.
   * 
   * Returns:
   * A data URL which encodes an image of the visible area of the captured tab.
   * May be assigned to the 'src' property of an HTML Image element for display.
   */
  Future<String> captureVisibleTab([int windowId, TabsCaptureVisibleTabParams options]) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter<String>.oneArg();
    _tabs.callMethod('captureVisibleTab', [windowId, jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Injects JavaScript code into a page. For details, see the [programmatic
   * injection](content_scripts.html#pi) section of the content scripts doc.
   * 
   * [tabId] The ID of the tab in which to run the script; defaults to the
   * active tab of the current window.
   * 
   * [details] Details of the script to run.
   * 
   * Returns:
   * The result of the script in every injected frame.
   */
  Future<List<dynamic>> executeScript(InjectDetails details, [int tabId]) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<dynamic>>.oneArg(listify);
    _tabs.callMethod('executeScript', [tabId, jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Injects CSS into a page. For details, see the [programmatic
   * injection](content_scripts.html#pi) section of the content scripts doc.
   * 
   * [tabId] The ID of the tab in which to insert the CSS; defaults to the
   * active tab of the current window.
   * 
   * [details] Details of the CSS text to insert.
   */
  Future insertCSS(InjectDetails details, [int tabId]) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _tabs.callMethod('insertCSS', [tabId, jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Fired when a tab is created. Note that the tab's URL may not be set at the
   * time this event fired, but you can listen to onUpdated events to be
   * notified when a URL is set.
   */
  Stream<Tab> get onCreated => _onCreated.stream;

  final ChromeStreamController<Tab> _onCreated =
      new ChromeStreamController<Tab>.oneArg(_tabs, 'onCreated', _createTab);

  /**
   * Fired when a tab is updated.
   */
  Stream<OnUpdatedEvent> get onUpdated => _onUpdated.stream;

  final ChromeStreamController<OnUpdatedEvent> _onUpdated =
      new ChromeStreamController<OnUpdatedEvent>.threeArgs(_tabs, 'onUpdated', _createOnUpdatedEvent);

  /**
   * Fired when a tab is moved within a window. Only one move event is fired,
   * representing the tab the user directly moved. Move events are not fired for
   * the other tabs that must move in response. This event is not fired when a
   * tab is moved between windows. For that, see [onDetached.]
   */
  Stream<TabsOnMovedEvent> get onMoved => _onMoved.stream;

  final ChromeStreamController<TabsOnMovedEvent> _onMoved =
      new ChromeStreamController<TabsOnMovedEvent>.twoArgs(_tabs, 'onMoved', _createOnMovedEvent);

  /**
   * Deprecated. Please use onActivated.
   */
  Stream<OnSelectionChangedEvent> get onSelectionChanged => _onSelectionChanged.stream;

  final ChromeStreamController<OnSelectionChangedEvent> _onSelectionChanged =
      new ChromeStreamController<OnSelectionChangedEvent>.twoArgs(_tabs, 'onSelectionChanged', _createOnSelectionChangedEvent);

  /**
   * Deprecated. Please use onActivated.
   */
  Stream<OnActiveChangedEvent> get onActiveChanged => _onActiveChanged.stream;

  final ChromeStreamController<OnActiveChangedEvent> _onActiveChanged =
      new ChromeStreamController<OnActiveChangedEvent>.twoArgs(_tabs, 'onActiveChanged', _createOnActiveChangedEvent);

  /**
   * Fires when the active tab in a window changes. Note that the tab's URL may
   * not be set at the time this event fired, but you can listen to onUpdated
   * events to be notified when a URL is set.
   */
  Stream<Map> get onActivated => _onActivated.stream;

  final ChromeStreamController<Map> _onActivated =
      new ChromeStreamController<Map>.oneArg(_tabs, 'onActivated', mapify);

  /**
   * Deprecated. Please use onHighlighted.
   */
  Stream<Map> get onHighlightChanged => _onHighlightChanged.stream;

  final ChromeStreamController<Map> _onHighlightChanged =
      new ChromeStreamController<Map>.oneArg(_tabs, 'onHighlightChanged', mapify);

  /**
   * Fired when the highlighted or selected tabs in a window changes.
   */
  Stream<Map> get onHighlighted => _onHighlighted.stream;

  final ChromeStreamController<Map> _onHighlighted =
      new ChromeStreamController<Map>.oneArg(_tabs, 'onHighlighted', mapify);

  /**
   * Fired when a tab is detached from a window, for example because it is being
   * moved between windows.
   */
  Stream<OnDetachedEvent> get onDetached => _onDetached.stream;

  final ChromeStreamController<OnDetachedEvent> _onDetached =
      new ChromeStreamController<OnDetachedEvent>.twoArgs(_tabs, 'onDetached', _createOnDetachedEvent);

  /**
   * Fired when a tab is attached to a window, for example because it was moved
   * between windows.
   */
  Stream<OnAttachedEvent> get onAttached => _onAttached.stream;

  final ChromeStreamController<OnAttachedEvent> _onAttached =
      new ChromeStreamController<OnAttachedEvent>.twoArgs(_tabs, 'onAttached', _createOnAttachedEvent);

  /**
   * Fired when a tab is closed.
   */
  Stream<TabsOnRemovedEvent> get onRemoved => _onRemoved.stream;

  final ChromeStreamController<TabsOnRemovedEvent> _onRemoved =
      new ChromeStreamController<TabsOnRemovedEvent>.twoArgs(_tabs, 'onRemoved', _createOnRemovedEvent);

  /**
   * Fired when a tab is replaced with another tab due to prerendering or
   * instant.
   */
  Stream<OnReplacedEvent> get onReplaced => _onReplaced.stream;

  final ChromeStreamController<OnReplacedEvent> _onReplaced =
      new ChromeStreamController<OnReplacedEvent>.twoArgs(_tabs, 'onReplaced', _createOnReplacedEvent);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.tabs' is not available");
  }
}

/**
 * Fired when a tab is updated.
 */
class OnUpdatedEvent {
  final int tabId;

  /**
   * Lists the changes to the state of the tab that was updated.
   */
  final Map changeInfo;

  /**
   * Gives the state of the tab that was updated.
   */
  final Tab tab;

  OnUpdatedEvent(this.tabId, this.changeInfo, this.tab);
}

/**
 * Fired when a tab is moved within a window. Only one move event is fired,
 * representing the tab the user directly moved. Move events are not fired for
 * the other tabs that must move in response. This event is not fired when a tab
 * is moved between windows. For that, see [onDetached.]
 */
class TabsOnMovedEvent {
  final int tabId;

  final Map moveInfo;

  TabsOnMovedEvent(this.tabId, this.moveInfo);
}

/**
 * Deprecated. Please use onActivated.
 */
class OnSelectionChangedEvent {
  /**
   * The ID of the tab that has become active.
   */
  final int tabId;

  final Map selectInfo;

  OnSelectionChangedEvent(this.tabId, this.selectInfo);
}

/**
 * Deprecated. Please use onActivated.
 */
class OnActiveChangedEvent {
  /**
   * The ID of the tab that has become active.
   */
  final int tabId;

  final Map selectInfo;

  OnActiveChangedEvent(this.tabId, this.selectInfo);
}

/**
 * Fired when a tab is detached from a window, for example because it is being
 * moved between windows.
 */
class OnDetachedEvent {
  final int tabId;

  final Map detachInfo;

  OnDetachedEvent(this.tabId, this.detachInfo);
}

/**
 * Fired when a tab is attached to a window, for example because it was moved
 * between windows.
 */
class OnAttachedEvent {
  final int tabId;

  final Map attachInfo;

  OnAttachedEvent(this.tabId, this.attachInfo);
}

/**
 * Fired when a tab is closed.
 */
class TabsOnRemovedEvent {
  final int tabId;

  final Map removeInfo;

  TabsOnRemovedEvent(this.tabId, this.removeInfo);
}

/**
 * Fired when a tab is replaced with another tab due to prerendering or instant.
 */
class OnReplacedEvent {
  final int addedTabId;

  final int removedTabId;

  OnReplacedEvent(this.addedTabId, this.removedTabId);
}

class Tab extends ChromeObject {
  Tab({int id, int index, int windowId, int openerTabId, bool highlighted, bool active, bool pinned, String url, String title, String favIconUrl, String status, bool incognito, int width, int height, String sessionId}) {
    if (id != null) this.id = id;
    if (index != null) this.index = index;
    if (windowId != null) this.windowId = windowId;
    if (openerTabId != null) this.openerTabId = openerTabId;
    if (highlighted != null) this.highlighted = highlighted;
    if (active != null) this.active = active;
    if (pinned != null) this.pinned = pinned;
    if (url != null) this.url = url;
    if (title != null) this.title = title;
    if (favIconUrl != null) this.favIconUrl = favIconUrl;
    if (status != null) this.status = status;
    if (incognito != null) this.incognito = incognito;
    if (width != null) this.width = width;
    if (height != null) this.height = height;
    if (sessionId != null) this.sessionId = sessionId;
  }
  Tab.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The ID of the tab. Tab IDs are unique within a browser session. Under some
   * circumstances a Tab may not be assigned an ID, for example when querying
   * foreign tabs using the [sessions] API, in which case a session ID may be
   * present.
   */
  int get id => jsProxy['id'];
  set id(int value) => jsProxy['id'] = value;

  /**
   * The zero-based index of the tab within its window.
   */
  int get index => jsProxy['index'];
  set index(int value) => jsProxy['index'] = value;

  /**
   * The ID of the window the tab is contained within.
   */
  int get windowId => jsProxy['windowId'];
  set windowId(int value) => jsProxy['windowId'] = value;

  /**
   * The ID of the tab that opened this tab, if any. This property is only
   * present if the opener tab still exists.
   */
  int get openerTabId => jsProxy['openerTabId'];
  set openerTabId(int value) => jsProxy['openerTabId'] = value;

  /**
   * Whether the tab is highlighted.
   */
  bool get highlighted => jsProxy['highlighted'];
  set highlighted(bool value) => jsProxy['highlighted'] = value;

  /**
   * Whether the tab is active in its window. (Does not necessarily mean the
   * window is focused.)
   */
  bool get active => jsProxy['active'];
  set active(bool value) => jsProxy['active'] = value;

  /**
   * Whether the tab is pinned.
   */
  bool get pinned => jsProxy['pinned'];
  set pinned(bool value) => jsProxy['pinned'] = value;

  /**
   * The URL the tab is displaying. This property is only present if the
   * extension's manifest includes the `"tabs"` permission.
   */
  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;

  /**
   * The title of the tab. This property is only present if the extension's
   * manifest includes the `"tabs"` permission.
   */
  String get title => jsProxy['title'];
  set title(String value) => jsProxy['title'] = value;

  /**
   * The URL of the tab's favicon. This property is only present if the
   * extension's manifest includes the `"tabs"` permission. It may also be an
   * empty string if the tab is loading.
   */
  String get favIconUrl => jsProxy['favIconUrl'];
  set favIconUrl(String value) => jsProxy['favIconUrl'] = value;

  /**
   * Either _loading_ or _complete_.
   */
  String get status => jsProxy['status'];
  set status(String value) => jsProxy['status'] = value;

  /**
   * Whether the tab is in an incognito window.
   */
  bool get incognito => jsProxy['incognito'];
  set incognito(bool value) => jsProxy['incognito'] = value;

  /**
   * The width of the tab in pixels.
   */
  int get width => jsProxy['width'];
  set width(int value) => jsProxy['width'] = value;

  /**
   * The height of the tab in pixels.
   */
  int get height => jsProxy['height'];
  set height(int value) => jsProxy['height'] = value;

  /**
   * The session ID used to uniquely identify a Tab obtained from the [sessions]
   * API.
   */
  String get sessionId => jsProxy['sessionId'];
  set sessionId(String value) => jsProxy['sessionId'] = value;
}

/**
 * Details of the script or CSS to inject. Either the code or the file property
 * must be set, but both may not be set at the same time.
 */
class InjectDetails extends ChromeObject {
  InjectDetails({String code, String file, bool allFrames, String runAt}) {
    if (code != null) this.code = code;
    if (file != null) this.file = file;
    if (allFrames != null) this.allFrames = allFrames;
    if (runAt != null) this.runAt = runAt;
  }
  InjectDetails.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * JavaScript or CSS code to inject.
   */
  String get code => jsProxy['code'];
  set code(String value) => jsProxy['code'] = value;

  /**
   * JavaScript or CSS file to inject.
   */
  String get file => jsProxy['file'];
  set file(String value) => jsProxy['file'] = value;

  /**
   * If allFrames is `true`, implies that the JavaScript or CSS should be
   * injected into all frames of current page. By default, it's `false` and is
   * only injected into the top frame.
   */
  bool get allFrames => jsProxy['allFrames'];
  set allFrames(bool value) => jsProxy['allFrames'] = value;

  /**
   * The soonest that the JavaScript or CSS will be injected into the tab.
   * Defaults to "document_idle".
   * enum of `document_start`, `document_end`, `document_idle`
   */
  String get runAt => jsProxy['runAt'];
  set runAt(String value) => jsProxy['runAt'] = value;
}

class TabsConnectParams extends ChromeObject {
  TabsConnectParams({String name}) {
    if (name != null) this.name = name;
  }
  TabsConnectParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Will be passed into onConnect for content scripts that are listening for
   * the connection event.
   */
  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;
}

class TabsCreateParams extends ChromeObject {
  TabsCreateParams({int windowId, int index, String url, bool active, bool pinned, int openerTabId}) {
    if (windowId != null) this.windowId = windowId;
    if (index != null) this.index = index;
    if (url != null) this.url = url;
    if (active != null) this.active = active;
    if (pinned != null) this.pinned = pinned;
    if (openerTabId != null) this.openerTabId = openerTabId;
  }
  TabsCreateParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The window to create the new tab in. Defaults to the [current
   * window](windows.html#current-window).
   */
  int get windowId => jsProxy['windowId'];
  set windowId(int value) => jsProxy['windowId'] = value;

  /**
   * The position the tab should take in the window. The provided value will be
   * clamped to between zero and the number of tabs in the window.
   */
  int get index => jsProxy['index'];
  set index(int value) => jsProxy['index'] = value;

  /**
   * The URL to navigate the tab to initially. Fully-qualified URLs must include
   * a scheme (i.e. 'http://www.google.com', not 'www.google.com'). Relative
   * URLs will be relative to the current page within the extension. Defaults to
   * the New Tab Page.
   */
  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;

  /**
   * Whether the tab should become the active tab in the window. Does not affect
   * whether the window is focused (see [windows.update]). Defaults to [true].
   */
  bool get active => jsProxy['active'];
  set active(bool value) => jsProxy['active'] = value;

  /**
   * Whether the tab should be pinned. Defaults to [false]
   */
  bool get pinned => jsProxy['pinned'];
  set pinned(bool value) => jsProxy['pinned'] = value;

  /**
   * The ID of the tab that opened this tab. If specified, the opener tab must
   * be in the same window as the newly created tab.
   */
  int get openerTabId => jsProxy['openerTabId'];
  set openerTabId(int value) => jsProxy['openerTabId'] = value;
}

class TabsQueryParams extends ChromeObject {
  TabsQueryParams({bool active, bool pinned, bool highlighted, bool currentWindow, bool lastFocusedWindow, String status, String title, String url, int windowId, String windowType, int index}) {
    if (active != null) this.active = active;
    if (pinned != null) this.pinned = pinned;
    if (highlighted != null) this.highlighted = highlighted;
    if (currentWindow != null) this.currentWindow = currentWindow;
    if (lastFocusedWindow != null) this.lastFocusedWindow = lastFocusedWindow;
    if (status != null) this.status = status;
    if (title != null) this.title = title;
    if (url != null) this.url = url;
    if (windowId != null) this.windowId = windowId;
    if (windowType != null) this.windowType = windowType;
    if (index != null) this.index = index;
  }
  TabsQueryParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Whether the tabs are active in their windows.
   */
  bool get active => jsProxy['active'];
  set active(bool value) => jsProxy['active'] = value;

  /**
   * Whether the tabs are pinned.
   */
  bool get pinned => jsProxy['pinned'];
  set pinned(bool value) => jsProxy['pinned'] = value;

  /**
   * Whether the tabs are highlighted.
   */
  bool get highlighted => jsProxy['highlighted'];
  set highlighted(bool value) => jsProxy['highlighted'] = value;

  /**
   * Whether the tabs are in the [current window](windows.html#current-window).
   */
  bool get currentWindow => jsProxy['currentWindow'];
  set currentWindow(bool value) => jsProxy['currentWindow'] = value;

  /**
   * Whether the tabs are in the last focused window.
   */
  bool get lastFocusedWindow => jsProxy['lastFocusedWindow'];
  set lastFocusedWindow(bool value) => jsProxy['lastFocusedWindow'] = value;

  /**
   * Whether the tabs have completed loading.
   * enum of `loading`, `complete`
   */
  String get status => jsProxy['status'];
  set status(String value) => jsProxy['status'] = value;

  /**
   * Match page titles against a pattern.
   */
  String get title => jsProxy['title'];
  set title(String value) => jsProxy['title'] = value;

  /**
   * Match tabs against a [URL pattern](match_patterns.html). Note that fragment
   * identifiers are not matched.
   */
  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;

  /**
   * The ID of the parent window, or [windows.WINDOW_ID_CURRENT] for the
   * [current window](windows.html#current-window).
   */
  int get windowId => jsProxy['windowId'];
  set windowId(int value) => jsProxy['windowId'] = value;

  /**
   * The type of window the tabs are in.
   * enum of `normal`, `popup`, `panel`, `app`
   */
  String get windowType => jsProxy['windowType'];
  set windowType(String value) => jsProxy['windowType'] = value;

  /**
   * The position of the tabs within their windows.
   */
  int get index => jsProxy['index'];
  set index(int value) => jsProxy['index'] = value;
}

class TabsHighlightParams extends ChromeObject {
  TabsHighlightParams({int windowId, var tabs}) {
    if (windowId != null) this.windowId = windowId;
    if (tabs != null) this.tabs = tabs;
  }
  TabsHighlightParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The window that contains the tabs.
   */
  int get windowId => jsProxy['windowId'];
  set windowId(int value) => jsProxy['windowId'] = value;

  /**
   * One or more tab indices to highlight.
   */
  dynamic get tabs => jsProxy['tabs'];
  set tabs(var value) => jsProxy['tabs'] = jsify(value);
}

class TabsUpdateParams extends ChromeObject {
  TabsUpdateParams({String url, bool active, bool highlighted, bool pinned, int openerTabId}) {
    if (url != null) this.url = url;
    if (active != null) this.active = active;
    if (highlighted != null) this.highlighted = highlighted;
    if (pinned != null) this.pinned = pinned;
    if (openerTabId != null) this.openerTabId = openerTabId;
  }
  TabsUpdateParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * A URL to navigate the tab to.
   */
  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;

  /**
   * Whether the tab should be active. Does not affect whether the window is
   * focused (see [windows.update]).
   */
  bool get active => jsProxy['active'];
  set active(bool value) => jsProxy['active'] = value;

  /**
   * Adds or removes the tab from the current selection.
   */
  bool get highlighted => jsProxy['highlighted'];
  set highlighted(bool value) => jsProxy['highlighted'] = value;

  /**
   * Whether the tab should be pinned.
   */
  bool get pinned => jsProxy['pinned'];
  set pinned(bool value) => jsProxy['pinned'] = value;

  /**
   * The ID of the tab that opened this tab. If specified, the opener tab must
   * be in the same window as this tab.
   */
  int get openerTabId => jsProxy['openerTabId'];
  set openerTabId(int value) => jsProxy['openerTabId'] = value;
}

class TabsMoveParams extends ChromeObject {
  TabsMoveParams({int windowId, int index}) {
    if (windowId != null) this.windowId = windowId;
    if (index != null) this.index = index;
  }
  TabsMoveParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Defaults to the window the tab is currently in.
   */
  int get windowId => jsProxy['windowId'];
  set windowId(int value) => jsProxy['windowId'] = value;

  /**
   * The position to move the window to. -1 will place the tab at the end of the
   * window.
   */
  int get index => jsProxy['index'];
  set index(int value) => jsProxy['index'] = value;
}

class TabsReloadParams extends ChromeObject {
  TabsReloadParams({bool bypassCache}) {
    if (bypassCache != null) this.bypassCache = bypassCache;
  }
  TabsReloadParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Whether using any local cache. Default is false.
   */
  bool get bypassCache => jsProxy['bypassCache'];
  set bypassCache(bool value) => jsProxy['bypassCache'] = value;
}

class TabsCaptureVisibleTabParams extends ChromeObject {
  TabsCaptureVisibleTabParams({String format, int quality}) {
    if (format != null) this.format = format;
    if (quality != null) this.quality = quality;
  }
  TabsCaptureVisibleTabParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The format of the resulting image.  Default is jpeg.
   * enum of `jpeg`, `png`
   */
  String get format => jsProxy['format'];
  set format(String value) => jsProxy['format'] = value;

  /**
   * When format is 'jpeg', controls the quality of the resulting image.  This
   * value is ignored for PNG images.  As quality is decreased, the resulting
   * image will have more visual artifacts, and the number of bytes needed to
   * store it will decrease.
   */
  int get quality => jsProxy['quality'];
  set quality(int value) => jsProxy['quality'] = value;
}

Tab _createTab(JsObject jsProxy) => jsProxy == null ? null : new Tab.fromProxy(jsProxy);
Port _createPort(JsObject jsProxy) => jsProxy == null ? null : new Port.fromProxy(jsProxy);
Window _createWindow(JsObject jsProxy) => jsProxy == null ? null : new Window.fromProxy(jsProxy);
OnUpdatedEvent _createOnUpdatedEvent(int tabId, JsObject changeInfo, JsObject tab) =>
    new OnUpdatedEvent(tabId, mapify(changeInfo), _createTab(tab));
TabsOnMovedEvent _createOnMovedEvent(int tabId, JsObject moveInfo) =>
    new TabsOnMovedEvent(tabId, mapify(moveInfo));
OnSelectionChangedEvent _createOnSelectionChangedEvent(int tabId, JsObject selectInfo) =>
    new OnSelectionChangedEvent(tabId, mapify(selectInfo));
OnActiveChangedEvent _createOnActiveChangedEvent(int tabId, JsObject selectInfo) =>
    new OnActiveChangedEvent(tabId, mapify(selectInfo));
OnDetachedEvent _createOnDetachedEvent(int tabId, JsObject detachInfo) =>
    new OnDetachedEvent(tabId, mapify(detachInfo));
OnAttachedEvent _createOnAttachedEvent(int tabId, JsObject attachInfo) =>
    new OnAttachedEvent(tabId, mapify(attachInfo));
TabsOnRemovedEvent _createOnRemovedEvent(int tabId, JsObject removeInfo) =>
    new TabsOnRemovedEvent(tabId, mapify(removeInfo));
OnReplacedEvent _createOnReplacedEvent(int addedTabId, int removedTabId) =>
    new OnReplacedEvent(addedTabId, removedTabId);
