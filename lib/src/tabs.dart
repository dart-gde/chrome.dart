library chrome.tabs;

import 'dart:async';

import 'package:js/js.dart' as js;

import 'common.dart';
import 'windows.dart';

/**
 * @param tab Details of the tab that was created.
 */
typedef void onTabCreatedCallback(Tab tab);

/**
 * @param tab Gives The state of the tab that was updated.
 * @param status The tab's new status if it has changed.
 * @param url The tab's new URL if it has changed.
 * @param pinned The tab's new pinned state if it has changed.
 * @param favIconUrl The tab's new favicon URL if it has changed.
 */
typedef void onTabUpdatedCallback(Tab tab, {
    TabStatus status,
    String url,
    bool pinned,
    String favIconUrl});

typedef void onTabMovedCallback(
    int tabId,
    int windowId,
    int fromIndex,
    int toIndex);

/**
 * @param tabId The ID of the tab that has become active.
 * @param windowId The ID of the window the active tab changed inside of.
 */
typedef void onTabActivatedCallback(int tabId, int windowId);

/**
 * @param windowId The window whose tabs changed.
 * @param tabIds All highlighted tabs in the window.
 */
typedef void onTabsHighlightedCallback(int windowId, List<int> tabIds);

typedef void onTabDetachedCallback(int tabId, int oldWindowId, int oldPosition);

typedef void onTabAttachedCallback(int tabId, int newWindowId, int newPosition);

/**
 * @param windowId The window whose tab is closed.
 * @param isWindowClosing True when the tab is being closed because its window
 *                        is being closed.
 */
typedef void onRemovedCallback(int tabId, int windowId, bool isWindowClosing);

typedef void onReplacedCallback(int addedTabdId, int removedTabId);

final Tabs tabs = new Tabs();

class Tabs {

  /**
   * Retrieves details about the specified tab.
   */
  Future<Tab> get(int tabId) {
    var completer =
        new ChromeCompleter.transform((tab) => new Tab(tab));
    js.scoped(() {
      js.context.chrome.tabs.get(tabId, completer.callback);
    });
    return completer.future;
  }

  /**
   * Gets the tab that this script call is being made from. May be undefined if
   * called from a non-tab context (for example: a background page or popup
   * view).
   */
  Future<Tab> getCurrent() {
    var completer =
        new ChromeCompleter.transform((tab) => new Tab(tab));
    js.scoped(() {
      js.context.chrome.tabs.getCurrent(completer.callback);
    });
    return completer.future;
  }

  /**
   * Sends a single message to the content script(s) in the specified tab. The
   * runtime.onMessage event is fired in each content script running in the
   * specified tab for the current extension.
   *
   * @returns The response object sent by the handler of the message.
   */
  Future sendMessage(int tabId, dynamic message) {
    var completer = new ChromeCompleter.oneArg();
    js.scoped(() {
      var jsMessage;
      if (message is Map) {
        jsMessage = js.map(message);
      } else if (message is Iterable) {
        jsMessage = js.array(message);
      } else {
        jsMessage = message;
      }
      js.context.chrome.tabs.sendMessage(tabId, jsMessage, completer.callback);
    });
    return completer.future;
  }

  /**
   * Creates a new tab. Note: This function can be used without requesting the
   * 'tabs' permission in the manifest.
   *
   * @param windowId The window to create the new tab in. Defaults to the
   *                 current window.
   * @param index The position the tab should take in the window. The provided
   *              value will be clamped to between zero and the number of tabs
   *              in the window.
   * @param url The URL to navigate the tab to initially. Fully-qualified URLs
   *            must include a scheme (i.e. 'http://www.google.com', not
   *            'www.google.com'). Relative URLs will be relative to the
   *            current page within the extension. Defaults to the New Tab Page.
   * @param active Whether the tab should become the active tab in the window.
   *               Defaults to true.
   * @param pinned Whether the tab should be pinned. Defaults to false.
   * @param openerTabId The ID of the tab that opened this tab. If specified,
   *                    the opener tab must be in the same window as the newly
   *                    created tab.
   *
   * @returns Details about the created tab. Will contain the ID of the new tab.
   */
  Future<Tab> create({int windowId, int index, String url, bool active, bool pinned}) {
    Map<String, dynamic> createProperties = {};
    if (windowId != null) {
      createProperties['windowId'] = windowId;
    }
    if (index != null) {
      createProperties['index'] = index;
    }
    if (url != null) {
      createProperties['url'] = url;
    }
    if (active != null) {
      createProperties['active'] = active;
    }
    if (pinned != null) {
      createProperties['pinned'] = pinned;
    }
    var completer = new ChromeCompleter.transform((tab) => new Tab(tab));
    js.scoped(() {
      js.context.chrome.tabs.create(js.map(createProperties), completer.callback);
    });
    return completer.future;
  }

  /**
   * Duplicates a tab. Note: This function can be used without requesting the
   * 'tabs' permission in the manifest.
   *
   * @param tabId The ID of the tab which is to be duplicated.
   *
   * @returns Details about the duplicated tab. The Tab object doesn't contain
   *          url, title and faviconUrl if the 'tabs' permission has not been
   *          requested.
   */
  Future<Tab> duplicate(int tabId) {
    var completer = new ChromeCompleter.transform((tab) => new Tab(tab));
    js.scoped(() {
      js.context.chrome.tabs.duplicate(tabId, completer.callback);
    });
    return completer.future;
  }

  /**
   * Gets all tabs that have the specified properties, or all tabs if no
   * properties are specified.
   *
   * @param active Whether the tabs are active in their windows.
   * @param pinned Whether the tabs are pinned.
   * @param highlighted Whether the tabs are highlighted.
   * @param Whether the tabs are in the current window.
   * @param lastFocusedWindow Whether the tabs are in the last focused window.
   * @param status Whether the tabs have completed loading.
   * @param title Match page titles against a pattern.
   * @param url Match tabs against a URL pattern. Note that fragment
   *            identifiers are not matched.
   * @param windowId The ID of the parent window, or windows.WINDOW_ID_CURRENT
   *                 for the current window.
   * @param windowType The type of window the tabs are in.
   * @param index The position of the tabs within their windows.
   */
  Future<List<Tab>> query({
      bool active,
      bool pinned,
      bool highlighted,
      bool currentWindow,
      bool lastFocusedWindow,
      TabStatus status,
      String title,
      String url,
      int windowId,
      WindowType windowType,
      int index}) {
    Map<String, dynamic> queryInfo = {};
    if (active != null) {
      queryInfo['active'] = active;
    }
    if (pinned != null) {
      queryInfo['pinned'] = pinned;
    }
    if (highlighted != null) {
      queryInfo['highlighted'] = highlighted;
    }
    if (currentWindow != null) {
      queryInfo['currentWindow'] = currentWindow;
    }
    if (lastFocusedWindow != null) {
      queryInfo['lastFocusedWindow'] = lastFocusedWindow;
    }
    if (status != null) {
      queryInfo['status'] = status.toString();
    }
    if (title != null) {
      queryInfo['title'] = title;
    }
    if (url != null) {
      queryInfo['url'] = url;
    }
    if (windowId != null) {
      queryInfo['windowId'] = windowId;
    }
    if (windowType != null) {
      queryInfo['windowType'] = windowType.toString();
    }
    if (index != null) {
      queryInfo['index'] = index;
    }
    var completer = new ChromeCompleter.transform((jsTabs) {
      List<Tab> tabs = [];

      for (js.Proxy tab in jsTabs) {
        tabs.add(new Tab(tab));
      }
      return tabs;
    });
    js.scoped(() {
      js.context.chrome.tabs.query(js.map(queryInfo), completer.callback);
    });
    return completer.future;
  }

  /**
   * Highlights the given tabs.
   *
   * @param tabs Tab indices to highlight.
   * @param windowId The window that contains the tabs.
   *
   * @returns Contains details about the window whose tabs were highlighted.
   */
  Future<Window> highlight(List<int> tabs, {int windowId}) {
    Map<String, dynamic> highlightInfo = { 'tabs': tabs };
    if (windowId != null) {
      highlightInfo['windowId'] = windowId;
    }
    var completer =
        new ChromeCompleter.transform((window) => new Window(window));
    js.scoped(() {
      js.context.chrome.tabs.highlight(
          js.map(highlightInfo), completer.callback);
    });
    return completer.future;
  }

  /**
   * Modifies the properties of a tab. Properties that are not specified are
   * not modified. Note: This function can be used without requesting the
   * 'tabs' permission in the manifest.
   *
   * @param tabId Defaults to the selected tab of the current window.
   * @param url A URL to navigate the tab to.
   * @param active Whether the tab should be active.
   * @param highlighted Adds or removes the tab from the current selection.
   * @param pinned Whether the tab should be pinned.
   * @param openerTabId The ID of the tab that opened this tab. If specified,
   *                    the opener tab must be in the same window as this tab.
   *
   * @returns Details about the updated tab, or null if the 'tabs' permission
   *          has not been requested.
   */
  Future<Tab> update({
      int tabId,
      String url,
      bool active,
      bool highlighted,
      bool pinned,
      int openerTabId}) {
    Map<String, dynamic> updateProperties = {};
    if (url != null) {
      updateProperties['url'] = url;
    }
    if (active != null) {
      updateProperties['active'] = active;
    }
    if (highlighted != null) {
      updateProperties['highlighted'] = highlighted;
    }
    if (pinned != null) {
      updateProperties['pinned'] = pinned;
    }
    if (openerTabId != null) {
      updateProperties['openerTabId'] = openerTabId;
    }
    var completer =
        new ChromeCompleter.transform((tab) {
          if (tab != null) {
            return new Tab(tab);
          } else {
            return null;
          }
        });
    js.scoped(() {
      js.context.chrome.tabs.update(
          tabId, js.map(updateProperties), completer.callback);
    });
    return completer.future;
  }

  /**
   * Moves one or more tabs to a new position within its window, or to a new
   * window. Note that tabs can only be moved to and from normal
   * (window.type === "normal") windows.
   *
   * @param tabIds The tabs to move.
   * @param index The position to move the window to. -1 will place the tab at
   *              the end of the window.
   * @param windowId Defaults to the window the tab is currently in.
   *
   * @returns Details about the moved tabs.
   */
  Future<List<Tab>> move(List<int> tabIds, int index, {int windowId}) {
    Map<String, dynamic> moveProperties = { 'index': index};
    if (windowId != null) {
      moveProperties['windowId'] = windowId;
    }
    var completer =
        new ChromeCompleter.transform((jsTabs) {
          List<Tab> tabs = [];
          // jsTabs can either be an array of tabs or a single tab
          if (jsTabs.length != null) {
            for (tab in jsTabs) {
              tabs.add(new Tab(tab));
            }
          } else {
            tabs.add(new Tab(jsTabs));
          }

          return tabs;
        });
    js.scoped(() {
      js.context.chrome.tabs.move(
          js.array(tabIds), js.map(moveProperties), completer.callback);
    });
    return completer.future;
  }

  /**
   * Reload a tab.
   *
   * @param tabId The ID of the tab to reload; defaults to the selected tab of
   *              the current window.
   * @param bypassCache Whether using any local cache. Default is false.
   */
  Future reload({int tabId, bool bypassCache}) {
    var reloadProperties = {};
    if (bypassCache != null) {
      reloadProperties['bypassCache'] = bypassCache;
    }

    var completer = new ChromeCompleter.noArgs();
    js.scoped(() {
      js.context.chrome.tabs.reload(
          tabId, reloadProperties, completer.callback);
    });
    return completer.future;
  }

  /**
   * Closes one or more tabs. Note: This function can be used without
   * requesting the 'tabs' permission in the manifest.
   *
   * @param tabIds The list of tabs to close.
   */
  Future remove(List<int> tabIds) {
    var completer = new ChromeCompleter.noArgs();
    js.scoped(() {
      js.context.chrome.tabs.remove(js.array(tabIds), completer.callback);
    });
    return completer.future;
  }

  /**
   * Detects the primary language of the content in a tab.
   *
   * @param tabId Defaults to the active tab of the current window.
   *
   * @returns An ISO language code such as en or fr. For a complete list of
   *          languages supported by this method, see kLanguageInfoTable. The
   *          2nd to 4th columns will be checked and the first non-NULL value
   *          will be returned except for Simplified Chinese for which zh-CN
   *          will be returned. For an unknown language, und will be returned.
   */
  Future<String> detectLanguage({int tabId}) {
    var completer = new ChromeCompleter.oneArg();
    js.scoped(() {
      js.context.chrome.tabs.detectLanguage(tabId, completer.callback);
    });
    return completer.future;
  }

  /**
   * Captures the visible area of the currently active tab in the specified
   * window. You must have host permission for the URL displayed by the tab.
   *
   * @param windowId The target window. Defaults to the current window.
   * @param format The format of the resulting image. Default is jpeg.
   * @param quality When format is 'jpeg', controls the quality of the
   *                resulting image. This value is ignored for PNG images. As
   *                quality is decreased, the resulting image will have more
   *                visual artifacts, and the number of bytes needed to store
   *                it will decrease.
   *
   * @returns A data URL which encodes an image of the visible area of the
   *          captured tab. May be assigned to the 'src' property of an HTML
   *          Image element for display.
   */
  Future<String> captureVisibleTab({
      int windowId,
      ImageFormat format,
      int quality}) {
    var options = {};
    if (format != null) {
      options['format'] = format.toString();
    }
    if (quality != null) {
      options['quality'] = quality;
    }
    var completer = new ChromeCompleter.oneArg();
    js.scoped(() {
      js.context.chrome.tabs.captureVisibleTab(
          windowId, js.map(options), completer.callback);
    });
    return completer.future;
  }

  /**
   * Injects JavaScript code into a page. For details, see the programmatic
   * injection section of the content scripts doc. Either the code or the file
   * parameter must be set, but both may not be set at the same time.
   *
   * @param tabId The ID of the tab in which to run the script; defaults to the
   *              active tab of the current window.
   * @param code JavaScript or CSS code to inject.
   * @param file JavaScript or CSS file to inject.
   * @param allFrames If allFrames is true, implies that the JavaScript or CSS
   *                  should be injected into all frames of current page. By
   *                  default, it's false and will only be injected into the
   *                  top frame.
   * @param runAt The soonest that the JavaScript or CSS will be injected into
   *              the tab. Defaults to "document_idle".
   *
   * @returns The result of the script in every injected frame.
   */
  Future<js.Proxy> executeScript({
      int tabId,
      String code,
      String file,
      bool allFrames,
      RunAt runAt}) {
    var completer = new ChromeCompleter.oneArg();
    js.scoped(() {
      js.context.chrome.tabs.executeScript(
          tabId,
          _createInjectDetails(code, file, allFrames, runAt),
          completer.callback);
    });
    return completer.future;
  }

  /**
   * Injects CSS into a page. For details, see the programmatic injection
   * section of the content scripts doc. Either the code or the file
   * parameter must be set, but both may not be set at the same time.
   *
   * @param tabId The ID of the tab in which to run the script; defaults to the
   *              active tab of the current window.
   * @param code JavaScript or CSS code to inject.
   * @param file JavaScript or CSS file to inject.
   * @param allFrames If allFrames is true, implies that the JavaScript or CSS
   *                  should be injected into all frames of current page. By
   *                  default, it's false and will only be injected into the
   *                  top frame.
   * @param runAt The soonest that the JavaScript or CSS will be injected into
   *              the tab. Defaults to "document_idle".
   */
  Future insertCSS({
      int tabId,
      String code,
      String file,
      bool allFrames,
      RunAt runAt}) {
    var completer = new ChromeCompleter.noArgs();
    js.scoped(() {
      js.context.chrome.tabs.insertCSS(
          tabId,
          _createInjectDetails(code, file, allFrames, runAt),
          completer.callback);
    });
    return completer.future;
  }

  /**
   * Fired when a tab is created. Note that the tab's URL may not be set at the
   * time this event fired, but you can listen to onUpdated events to be
   * notified when a URL is set.
   */
  void onCreated(onTabCreatedCallback callback) {
    var jsCallback = new js.Callback.many((tab) {
      if (callback != null) {
        callback(new Tab(tab));
      }
    });

    js.scoped(() {
      js.context.chrome.tabs.onCreated.addListener(jsCallback);
    });
  }

  /**
   * Fired when a tab is updated.
   */
  void onUpdated(onTabUpdatedCallback callback) {
    var jsCallback = new js.Callback.many((tabId, changeInfo, tab) {
      if (callback != null) {
        var status;
        if (changeInfo['status'] != null) {
          status = new TabStatus(changeInfo['status']);
        }
        callback(new Tab(tab),
            status: status,
            url: changeInfo['url'],
            pinned: changeInfo['pinned'],
            favIconUrl: changeInfo['favIconUrl']);
      }
    });

    js.scoped(() {
      js.context.chrome.tabs.onUpdated.addListener(jsCallback);
    });
  }

  /**
   * Fired when a tab is moved within a window. Only one move event is fired,
   * representing the tab the user directly moved. Move events are not fired
   * for the other tabs that must move in response. This event is not fired
   * when a tab is moved between windows. For that, see onDetached.
   */
  void onMoved(onTabMovedCallback callback) {
    var jsCallback = new js.Callback.many((tabId, moveInfo) {
      if (callback != null) {
        callback(tabId, moveInfo.windowId,
            moveInfo.fromIndex, moveInfo.toIndex);
      }
    });

    js.scoped(() {
      js.context.chrome.tabs.onMoved.addListener(jsCallback);
    });
  }

  /**
   * Fires when the active tab in a window changes. Note that the tab's URL may
   * not be set at the time this event fired, but you can listen to onUpdated
   * events to be notified when a URL is set.
   */
  void onActivated(onTabActivatedCallback callback) {
    var jsCallback = new js.Callback.many((tabId, windowId) {
      if (callback != null) {
        callback(tabId, windowId);
      }
    });

    js.scoped(() {
      js.context.chrome.tabs.onActivated.addListener(jsCallback);
    });
  }

  /**
   * Fired when the highlighted or selected tabs in a window changes.
   */
  void onHighlighted(onTabActivatedCallback callback) {
    var jsCallback = new js.Callback.many((windowId, jsTabIds) {
      var tabIds = [].addAll(jsTabIds);
      if (callback != null) {
        callback(windowId, tabIds);
      }
    });

    js.scoped(() {
      js.context.chrome.tabs.onHighlighted.addListener(jsCallback);
    });
  }

  /**
   * Fired when a tab is detached from a window, for example because it is
   * being moved between windows.
   */
  void onDetached(onTabDetachedCallback callback) {
    var jsCallback = new js.Callback.many((tabId, detachInfo) {
      if (callback != null) {
        callback(tabId, detachInfo.oldWindowId, detachInfo.oldPosition);
      }
    });

    js.scoped(() {
      js.context.chrome.tabs.onDetached.addListener(jsCallback);
    });
  }

  /**
   * Fired when a tab is attached to a window, for example because it was moved
   * between windows.
   */
  void onAttached(onTabAttachedCallback callback) {
    var jsCallback = new js.Callback.many((tabId, attachInfo) {
      if (callback != null) {
        callback(tabId, attachInfo.newWindowId, attachInfo.newPosition);
      }
    });

    js.scoped(() {
      js.context.chrome.tabs.onAttached.addListener(jsCallback);
    });
  }

  /**
   * Fired when a tab is closed. Note: A listener can be registered for this
   * event without requesting the 'tabs' permission in the manifest.
   */
  void onRemoved(onRemovedCallback callback) {
    var jsCallback = new js.Callback.many((tabId, removeInfo) {
      if (callback != null) {
        callback(tabId, removeInfo.windowId, removeInfo.isWindowClosing);
      }
    });

    js.scoped(() {
      js.context.chrome.tabs.onRemoved.addListener(jsCallback);
    });
  }

  /**
   * Fired when a tab is replaced with another tab due to prerendering or
   * instant.
   */
  void onReplaced(onReplacedCallback callback) {
    var jsCallback = new js.Callback.many((addedTabId, removedTabId) {
      if (callback != null) {
        callback(addedTabId, removedTabId);
      }
    });

    js.scoped(() {
      js.context.chrome.tabs.onReplaced.addListener(jsCallback);
    });
  }

  js.Proxy _createInjectDetails(
      String code,
      String file,
      bool allFrames,
      RunAt runAt) {
    var injectDetails = {};
    if (code != null) {
      injectDetails['code'] = code;
    }
    if (file != null) {
      injectDetails['file'] = file;
    }
    if (allFrames != null) {
      injectDetails['allFrames'] = allFrames;
    }
    if (runAt != null) {
      injectDetails['runAt'] = runAt.toString();
    }
    return js.map(injectDetails);
  }

  // TODO(DrMarcII): add listener methods
}

class Tab {
  final js.Proxy _tab;

  Tab(this._tab) {
    js.retain(_tab);
  }

  /**
   * The ID of the tab. Tab IDs are unique within a browser session.
   */
  int get id {
    return _tab.id as int;
  }

  /**
   * The zero-based index of the tab within its window.
   */
  int get index {
    return _tab.index as int;
  }

  /**
   * The ID of the window the tab is contained within.
   */
  int get windowId {
    return _tab.windowId as int;
  }

  /**
   * The ID of the tab that opened this tab, if any. This will only be present
   * if the opener tab still exists.
   */
  int get openerTabId {
    return _tab.openerTabId as int;
  }

  /**
   * Whether the tab is highlighted.
   */
  bool get highlighted {
    return _tab.highlighted as bool;
  }

  /**
   * Whether the tab is active in its window.
   */
  bool get active {
    return _tab.active as bool;
  }

  /**
   * Whether the tab is pinned.
   */
  bool get pinned {
    return _tab.pinned as bool;
  }

  /**
   * The URL the tab is displaying. This will only be present if the extension
   * has the 'tabs' or 'webNavigation' permission.
   */
  String get url {
    return _tab.url as String;
  }

  /**
   * The title of the tab. This will only be present if the extension has the
   * 'tabs' or 'webNavigation' permission. It may also be an empty string if
   * the tab is loading.
   */
  String get title {
    return _tab.title as String;
  }

  /**
   * The URL of the tab's favicon. This will only be present if the extension
   * has the 'tabs' or 'webNavigation' permission. It may also be an empty
   * string if the tab is loading.
   */
  String get favIconUrl {
    return _tab.favIconUrl as String;
  }

  /**
   * Either loading or complete.
   */
  TabStatus get status {
    var status = _tab.status;
    if (status != null) {
      return new TabStatus(status);
    } else {
      return null;
    }
  }

  /**
   * Whether the tab is in an incognito window.
   */
  bool get incognito {
    return _tab.incognito as bool;
  }

  /**
   * Release the {@link js.Proxy} to the underlying javascript tab object.
   * Ideally this method should be called after last use for any Tab object.
   */
  void release() {
    js.release(_tab);
  }
}

class TabStatus {
  final String _status;

  const TabStatus._internal(this._status);

  factory TabStatus(String status) {
    switch(status.toLowerCase()) {
      case 'loading':
        return LOADING;
      case 'complete':
        return COMPLETE;
      default:
        throw 'Unknown TabStatus: $status';
    }
  }

  String toString() {
    return _status;
  }

  static const TabStatus LOADING = const TabStatus._internal('loading');
  static const TabStatus COMPLETE = const TabStatus._internal('complete');
}

class ImageFormat {
  final String _format;

  const ImageFormat._internal(this._format);

  factory ImageFormat(String format) {
    switch(format.toLowerCase()) {
      case 'jpeg':
        return JPEG;
      case 'png':
        return PNG;
      default:
        throw 'Unknown ImageFormat: $format';
    }
  }

  String toString() {
    return _format;
  }

  static const ImageFormat JPEG = const ImageFormat._internal('jpeg');
  static const ImageFormat PNG = const ImageFormat._internal('png');
}

class RunAt {
  final String _runAt;

  const RunAt._internal(this._runAt);

  factory RunAt(String runAt) {
    switch(runAt.toLowerCase()) {
      case 'document_start':
        return DOCUMENT_START;
      case 'document_end':
        return DOCUMENT_END;
      case 'document_idle':
        return DOCUMENT_IDLE;
      default:
        throw 'Unknown RunAt: $runAt';
    }
  }

  String toString() {
    return _runAt;
  }

  static const RunAt DOCUMENT_START = const RunAt._internal('document_start');
  static const RunAt DOCUMENT_END = const RunAt._internal('document_end');
  static const RunAt DOCUMENT_IDLE = const RunAt._internal('document_idle');
}
