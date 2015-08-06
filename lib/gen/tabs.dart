/* This file has been generated from tabs.json - do not edit */

/**
 * Use the `chrome.tabs` API to interact with the browser's tab system. You can
 * use this API to create, modify, and rearrange tabs in the browser.
 */
library chrome.tabs;

import 'extension_types.dart';
import 'runtime.dart';
import 'windows.dart';
import '../src/common.dart';

/**
 * Accessor for the `chrome.tabs` namespace.
 */
final ChromeTabs tabs = new ChromeTabs._();

class ChromeTabs extends ChromeApi {
  JsObject get _tabs => chrome['tabs'];

  /**
   * Fired when a tab is created. Note that the tab's URL may not be set at the
   * time this event fired, but you can listen to onUpdated events to be
   * notified when a URL is set.
   */
  Stream<Tab> get onCreated => _onCreated.stream;
  ChromeStreamController<Tab> _onCreated;

  /**
   * Fired when a tab is updated.
   */
  Stream<OnUpdatedEvent> get onUpdated => _onUpdated.stream;
  ChromeStreamController<OnUpdatedEvent> _onUpdated;

  /**
   * Fired when a tab is moved within a window. Only one move event is fired,
   * representing the tab the user directly moved. Move events are not fired for
   * the other tabs that must move in response. This event is not fired when a
   * tab is moved between windows. For that, see [tabs.onDetached].
   */
  Stream<TabsOnMovedEvent> get onMoved => _onMoved.stream;
  ChromeStreamController<TabsOnMovedEvent> _onMoved;

  /**
   * Fires when the selected tab in a window changes.
   */
  Stream<OnSelectionChangedEvent> get onSelectionChanged => _onSelectionChanged.stream;
  ChromeStreamController<OnSelectionChangedEvent> _onSelectionChanged;

  /**
   * Fires when the selected tab in a window changes. Note that the tab's URL
   * may not be set at the time this event fired, but you can listen to
   * [tabs.onUpdated] events to be notified when a URL is set.
   */
  Stream<OnActiveChangedEvent> get onActiveChanged => _onActiveChanged.stream;
  ChromeStreamController<OnActiveChangedEvent> _onActiveChanged;

  /**
   * Fires when the active tab in a window changes. Note that the tab's URL may
   * not be set at the time this event fired, but you can listen to onUpdated
   * events to be notified when a URL is set.
   */
  Stream<Map> get onActivated => _onActivated.stream;
  ChromeStreamController<Map> _onActivated;

  /**
   * Fired when the highlighted or selected tabs in a window changes.
   */
  Stream<Map> get onHighlightChanged => _onHighlightChanged.stream;
  ChromeStreamController<Map> _onHighlightChanged;

  /**
   * Fired when the highlighted or selected tabs in a window changes.
   */
  Stream<Map> get onHighlighted => _onHighlighted.stream;
  ChromeStreamController<Map> _onHighlighted;

  /**
   * Fired when a tab is detached from a window, for example because it is being
   * moved between windows.
   */
  Stream<OnDetachedEvent> get onDetached => _onDetached.stream;
  ChromeStreamController<OnDetachedEvent> _onDetached;

  /**
   * Fired when a tab is attached to a window, for example because it was moved
   * between windows.
   */
  Stream<OnAttachedEvent> get onAttached => _onAttached.stream;
  ChromeStreamController<OnAttachedEvent> _onAttached;

  /**
   * Fired when a tab is closed.
   */
  Stream<TabsOnRemovedEvent> get onRemoved => _onRemoved.stream;
  ChromeStreamController<TabsOnRemovedEvent> _onRemoved;

  /**
   * Fired when a tab is replaced with another tab due to prerendering or
   * instant.
   */
  Stream<OnReplacedEvent> get onReplaced => _onReplaced.stream;
  ChromeStreamController<OnReplacedEvent> _onReplaced;

  /**
   * Fired when a tab is zoomed.
   */
  Stream<Map> get onZoomChange => _onZoomChange.stream;
  ChromeStreamController<Map> _onZoomChange;

  ChromeTabs._() {
    var getApi = () => _tabs;
    _onCreated = new ChromeStreamController<Tab>.oneArg(getApi, 'onCreated', _createTab);
    _onUpdated = new ChromeStreamController<OnUpdatedEvent>.threeArgs(getApi, 'onUpdated', _createOnUpdatedEvent);
    _onMoved = new ChromeStreamController<TabsOnMovedEvent>.twoArgs(getApi, 'onMoved', _createOnMovedEvent);
    _onSelectionChanged = new ChromeStreamController<OnSelectionChangedEvent>.twoArgs(getApi, 'onSelectionChanged', _createOnSelectionChangedEvent);
    _onActiveChanged = new ChromeStreamController<OnActiveChangedEvent>.twoArgs(getApi, 'onActiveChanged', _createOnActiveChangedEvent);
    _onActivated = new ChromeStreamController<Map>.oneArg(getApi, 'onActivated', mapify);
    _onHighlightChanged = new ChromeStreamController<Map>.oneArg(getApi, 'onHighlightChanged', mapify);
    _onHighlighted = new ChromeStreamController<Map>.oneArg(getApi, 'onHighlighted', mapify);
    _onDetached = new ChromeStreamController<OnDetachedEvent>.twoArgs(getApi, 'onDetached', _createOnDetachedEvent);
    _onAttached = new ChromeStreamController<OnAttachedEvent>.twoArgs(getApi, 'onAttached', _createOnAttachedEvent);
    _onRemoved = new ChromeStreamController<TabsOnRemovedEvent>.twoArgs(getApi, 'onRemoved', _createOnRemovedEvent);
    _onReplaced = new ChromeStreamController<OnReplacedEvent>.twoArgs(getApi, 'onReplaced', _createOnReplacedEvent);
    _onZoomChange = new ChromeStreamController<Map>.oneArg(getApi, 'onZoomChange', mapify);
  }

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
   * Script Messaging](messaging).
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
   * Sends a single request to the content script(s) in the specified tab, with
   * an optional callback to run when a response is sent back.  The
   * [extension.onRequest] event is fired in each content script running in the
   * specified tab for the current extension.
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
  Future<dynamic> sendMessage(int tabId, dynamic message, [TabsSendMessageParams options]) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter<dynamic>.oneArg();
    _tabs.callMethod('sendMessage', [tabId, jsify(message), jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Gets the tab that is selected in the specified window.
   * 
   * [windowId] Defaults to the [current window](windows#current-window).
   */
  Future<Tab> getSelected([int windowId]) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Tab>.oneArg(_createTab);
    _tabs.callMethod('getSelected', [windowId, completer.callback]);
    return completer.future;
  }

  /**
   * Gets details about all tabs in the specified window.
   * 
   * [windowId] Defaults to the [current window](windows#current-window).
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
   * window](windows#current-window).
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
   * window](windows#current-window).
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
   * window. You must have <a href='declare_permissions'><all_urls></a>
   * permission to use this method.
   * 
   * [windowId] The target window. Defaults to the [current
   * window](windows#current-window).
   * 
   * Returns:
   * A data URL which encodes an image of the visible area of the captured tab.
   * May be assigned to the 'src' property of an HTML Image element for display.
   */
  Future<String> captureVisibleTab([int windowId, ImageDetails options]) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter<String>.oneArg();
    _tabs.callMethod('captureVisibleTab', [windowId, jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Injects JavaScript code into a page. For details, see the [programmatic
   * injection](content_scripts#pi) section of the content scripts doc.
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
   * injection](content_scripts#pi) section of the content scripts doc.
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
   * Zooms a specified tab.
   * 
   * [tabId] The ID of the tab to zoom; defaults to the active tab of the
   * current window.
   * 
   * [zoomFactor] The new zoom factor. Use a value of 0 here to set the tab to
   * its current default zoom factor. Values greater than zero specify a
   * (possibly non-default) zoom factor for the tab.
   */
  Future setZoom(dynamic zoomFactor, [int tabId]) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _tabs.callMethod('setZoom', [tabId, jsify(zoomFactor), completer.callback]);
    return completer.future;
  }

  /**
   * Gets the current zoom factor of a specified tab.
   * 
   * [tabId] The ID of the tab to get the current zoom factor from; defaults to
   * the active tab of the current window.
   * 
   * Returns:
   * The tab's current zoom factor.
   */
  Future<dynamic> getZoom([int tabId]) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter<dynamic>.oneArg();
    _tabs.callMethod('getZoom', [tabId, completer.callback]);
    return completer.future;
  }

  /**
   * Sets the zoom settings for a specified tab, which define how zoom changes
   * are handled. These settings are reset to defaults upon navigating the tab.
   * 
   * [tabId] The ID of the tab to change the zoom settings for; defaults to the
   * active tab of the current window.
   * 
   * [zoomSettings] Defines how zoom changes are handled and at what scope.
   */
  Future setZoomSettings(ZoomSettings zoomSettings, [int tabId]) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _tabs.callMethod('setZoomSettings', [tabId, jsify(zoomSettings), completer.callback]);
    return completer.future;
  }

  /**
   * Gets the current zoom settings of a specified tab.
   * 
   * [tabId] The ID of the tab to get the current zoom settings from; defaults
   * to the active tab of the current window.
   * 
   * Returns:
   * The tab's current zoom settings.
   */
  Future<ZoomSettings> getZoomSettings([int tabId]) {
    if (_tabs == null) _throwNotAvailable();

    var completer = new ChromeCompleter<ZoomSettings>.oneArg(_createZoomSettings);
    _tabs.callMethod('getZoomSettings', [tabId, completer.callback]);
    return completer.future;
  }

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
 * is moved between windows. For that, see [tabs.onDetached].
 */
class TabsOnMovedEvent {
  final int tabId;

  final Map moveInfo;

  TabsOnMovedEvent(this.tabId, this.moveInfo);
}

/**
 * Fires when the selected tab in a window changes.
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
 * Fires when the selected tab in a window changes. Note that the tab's URL may
 * not be set at the time this event fired, but you can listen to
 * [tabs.onUpdated] events to be notified when a URL is set.
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
  Tab({int id, int index, int windowId, int openerTabId, bool selected, bool highlighted, bool active, bool pinned, String url, String title, String favIconUrl, String status, bool incognito, int width, int height, String sessionId}) {
    if (id != null) this.id = id;
    if (index != null) this.index = index;
    if (windowId != null) this.windowId = windowId;
    if (openerTabId != null) this.openerTabId = openerTabId;
    if (selected != null) this.selected = selected;
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
   * Whether the tab is selected.
   */
  bool get selected => jsProxy['selected'];
  set selected(bool value) => jsProxy['selected'] = value;

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
 * Defines how zoom changes are handled, i.e. which entity is responsible for
 * the actual scaling of the page; defaults to `automatic`.
 * enum of `{name: automatic, description: Zoom changes are handled
 * automatically by the browser.}`, `{name: manual, description: Overrides the
 * automatic handling of zoom changes. The <code>onZoomChange</code> event will
 * still be dispatched, and it is the responsibility of the extension to listen
 * for this event and manually scale the page. This mode does not support
 * <code>per-origin</code> zooming, and will thus ignore the <code>scope</code>
 * zoom setting and assume <code>per-tab</code>.}`, `{name: disabled,
 * description: Disables all zooming in the tab. The tab will revert to the
 * default zoom level, and all attempted zoom changes will be ignored.}`
 */
class ZoomSettingsMode extends ChromeObject {
  ZoomSettingsMode();
  ZoomSettingsMode.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

/**
 * Defines whether zoom changes will persist for the page's origin, or only take
 * effect in this tab; defaults to `per-origin` when in `automatic` mode, and
 * `per-tab` otherwise.
 * enum of `{name: per-origin, description: Zoom changes will persist in the
 * zoomed page's origin, i.e. all other tabs navigated to that same origin will
 * be zoomed as well. Moreover, <code>per-origin</code> zoom changes are saved
 * with the origin, meaning that when navigating to other pages in the same
 * origin, they will all be zoomed to the same zoom factor. The
 * <code>per-origin</code> scope is only available in the <code>automatic</code>
 * mode.}`, `{name: per-tab, description: Zoom changes only take effect in this
 * tab, and zoom changes in other tabs will not affect the zooming of this tab.
 * Also, <code>per-tab</code> zoom changes are reset on navigation; navigating a
 * tab will always load pages with their <code>per-origin</code> zoom factors.}`
 */
class ZoomSettingsScope extends ChromeObject {
  ZoomSettingsScope();
  ZoomSettingsScope.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

/**
 * Defines how zoom changes in a tab are handled and at what scope.
 */
class ZoomSettings extends ChromeObject {
  ZoomSettings({ZoomSettingsMode mode, ZoomSettingsScope scope, var defaultZoomFactor}) {
    if (mode != null) this.mode = mode;
    if (scope != null) this.scope = scope;
    if (defaultZoomFactor != null) this.defaultZoomFactor = defaultZoomFactor;
  }
  ZoomSettings.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Defines how zoom changes are handled, i.e. which entity is responsible for
   * the actual scaling of the page; defaults to `automatic`.
   */
  ZoomSettingsMode get mode => _createZoomSettingsMode(jsProxy['mode']);
  set mode(ZoomSettingsMode value) => jsProxy['mode'] = jsify(value);

  /**
   * Defines whether zoom changes will persist for the page's origin, or only
   * take effect in this tab; defaults to `per-origin` when in `automatic` mode,
   * and `per-tab` otherwise.
   */
  ZoomSettingsScope get scope => _createZoomSettingsScope(jsProxy['scope']);
  set scope(ZoomSettingsScope value) => jsProxy['scope'] = jsify(value);

  /**
   * Used to return the default zoom level for the current tab in calls to
   * tabs.getZoomSettings.
   */
  dynamic get defaultZoomFactor => jsProxy['defaultZoomFactor'];
  set defaultZoomFactor(var value) => jsProxy['defaultZoomFactor'] = jsify(value);
}

/**
 * Whether the tabs have completed loading.
 * enum of `loading`, `complete`
 */
class TabStatus extends ChromeObject {
  TabStatus();
  TabStatus.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

/**
 * The type of window.
 * enum of `normal`, `popup`, `panel`, `app`
 */
class TabsWindowType extends ChromeObject {
  TabsWindowType();
  TabsWindowType.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

class TabsConnectParams extends ChromeObject {
  TabsConnectParams({String name, int frameId}) {
    if (name != null) this.name = name;
    if (frameId != null) this.frameId = frameId;
  }
  TabsConnectParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Will be passed into onConnect for content scripts that are listening for
   * the connection event.
   */
  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  /**
   * Open a port to a specific [frame](webNavigation#frame_ids) identified by
   * `frameId` instead of all frames in the tab.
   */
  int get frameId => jsProxy['frameId'];
  set frameId(int value) => jsProxy['frameId'] = value;
}

class TabsSendMessageParams extends ChromeObject {
  TabsSendMessageParams({int frameId}) {
    if (frameId != null) this.frameId = frameId;
  }
  TabsSendMessageParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Send a message to a specific [frame](webNavigation#frame_ids) identified by
   * `frameId` instead of all frames in the tab.
   */
  int get frameId => jsProxy['frameId'];
  set frameId(int value) => jsProxy['frameId'] = value;
}

class TabsCreateParams extends ChromeObject {
  TabsCreateParams({int windowId, int index, String url, bool active, bool selected, bool pinned, int openerTabId}) {
    if (windowId != null) this.windowId = windowId;
    if (index != null) this.index = index;
    if (url != null) this.url = url;
    if (active != null) this.active = active;
    if (selected != null) this.selected = selected;
    if (pinned != null) this.pinned = pinned;
    if (openerTabId != null) this.openerTabId = openerTabId;
  }
  TabsCreateParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The window to create the new tab in. Defaults to the [current
   * window](windows#current-window).
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
   * Whether the tab should become the selected tab in the window. Defaults to
   * [true]
   */
  bool get selected => jsProxy['selected'];
  set selected(bool value) => jsProxy['selected'] = value;

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
  TabsQueryParams({bool active, bool pinned, bool highlighted, bool currentWindow, bool lastFocusedWindow, TabStatus status, String title, var url, int windowId, TabsWindowType windowType, int index}) {
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
   * Whether the tabs are in the [current window](windows#current-window).
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
   */
  TabStatus get status => _createTabStatus(jsProxy['status']);
  set status(TabStatus value) => jsProxy['status'] = jsify(value);

  /**
   * Match page titles against a pattern.
   */
  String get title => jsProxy['title'];
  set title(String value) => jsProxy['title'] = value;

  /**
   * Match tabs against one or more [URL patterns](match_patterns). Note that
   * fragment identifiers are not matched.
   */
  dynamic get url => jsProxy['url'];
  set url(var value) => jsProxy['url'] = jsify(value);

  /**
   * The ID of the parent window, or [windows.WINDOW_ID_CURRENT] for the
   * [current window](windows#current-window).
   */
  int get windowId => jsProxy['windowId'];
  set windowId(int value) => jsProxy['windowId'] = value;

  /**
   * The type of window the tabs are in.
   */
  TabsWindowType get windowType => _createWindowType(jsProxy['windowType']);
  set windowType(TabsWindowType value) => jsProxy['windowType'] = jsify(value);

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
  TabsUpdateParams({String url, bool active, bool highlighted, bool selected, bool pinned, int openerTabId}) {
    if (url != null) this.url = url;
    if (active != null) this.active = active;
    if (highlighted != null) this.highlighted = highlighted;
    if (selected != null) this.selected = selected;
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
   * Whether the tab should be selected.
   */
  bool get selected => jsProxy['selected'];
  set selected(bool value) => jsProxy['selected'] = value;

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

Tab _createTab(JsObject jsProxy) => jsProxy == null ? null : new Tab.fromProxy(jsProxy);
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
Port _createPort(JsObject jsProxy) => jsProxy == null ? null : new Port.fromProxy(jsProxy);
Window _createWindow(JsObject jsProxy) => jsProxy == null ? null : new Window.fromProxy(jsProxy);
ZoomSettings _createZoomSettings(JsObject jsProxy) => jsProxy == null ? null : new ZoomSettings.fromProxy(jsProxy);
ZoomSettingsMode _createZoomSettingsMode(JsObject jsProxy) => jsProxy == null ? null : new ZoomSettingsMode.fromProxy(jsProxy);
ZoomSettingsScope _createZoomSettingsScope(JsObject jsProxy) => jsProxy == null ? null : new ZoomSettingsScope.fromProxy(jsProxy);
TabStatus _createTabStatus(JsObject jsProxy) => jsProxy == null ? null : new TabStatus.fromProxy(jsProxy);
TabsWindowType _createWindowType(JsObject jsProxy) => jsProxy == null ? null : new TabsWindowType.fromProxy(jsProxy);
