library chrome.tabs;

import 'dart:async';

import 'package:js/js.dart' as js;

import 'common.dart';
import 'windows.dart';

/// accessor for the `chrome.tabs` namespace.
final Tabs tabs = new Tabs._();

/**
 * Encapsulation of the `chrome.tabs` namespace.
 * The single instance of this class is accessed from the [tabs]
 * getter.
 */
class Tabs {

  Tabs._();

  get _tabs => chromeProxy.tabs;

  /**
   * Retrieves details about the specified tab.
   */
  Future<Tab> get(int tabId) {
    var completer =
        new ChromeCompleter.oneArg((tab) => new Tab(tab));
    js.scoped(() {
      _tabs.get(tabId, completer.callback);
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
        new ChromeCompleter.oneArg((tab) => new Tab(tab));
    js.scoped(() {
      _tabs.getCurrent(completer.callback);
    });
    return completer.future;
  }

  /**
   * Sends a single message to the content script(s) in the specified tab. The
   * runtime.onMessage event is fired in each content script running in the
   * specified tab for the current extension.
   *
   * Returns the response object sent by the handler of the message.
   */
  Future sendMessage(int tabId, dynamic message) {
    var completer = new ChromeCompleter.oneArg();
    js.scoped(() {
      _tabs.sendMessage(tabId, jsifyMessage(message), completer.callback);
    });
    return completer.future;
  }

  /**
   * Creates a new tab. Note: This function can be used without requesting the
   * 'tabs' permission in the manifest.
   */
  Future<Tab> create({
      int windowId,
      int index,
      String url,
      bool active,
      bool pinned,
      int openerTabId}) {
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
    if (openerTabId != null) {
      createProperties['openerTabId'] = openerTabId;
    }
    var completer = new ChromeCompleter.oneArg((tab) => new Tab(tab));
    js.scoped(() {
      _tabs.create(js.map(createProperties), completer.callback);
    });
    return completer.future;
  }

  /**
   * Duplicates a tab. Note: This function can be used without requesting the
   * 'tabs' permission in the manifest.
   */
  Future<Tab> duplicate(int tabId) {
    var completer = new ChromeCompleter.oneArg((tab) => new Tab(tab));
    js.scoped(() {
      _tabs.duplicate(tabId, completer.callback);
    });
    return completer.future;
  }

  /**
   * Gets all tabs that have the specified properties, or all tabs if no
   * properties are specified.
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
    var completer = new ChromeCompleter.oneArg((jsTabs) {
      List<Tab> tabs = [];

      for (int i = 0; i < jsTabs.length; i++ ) {
        tabs.add(new Tab(jsTabs[i]));
      }
      return tabs;
    });
    js.scoped(() {
      _tabs.query(js.map(queryInfo), completer.callback);
    });
    return completer.future;
  }

  /**
   * Highlights the given tabs.
   */
  Future<Window> highlight(List<int> tabIndices, {int windowId}) {
    Map<String, dynamic> highlightInfo = { 'tabs': js.array(tabIndices) };
    if (windowId != null) {
      highlightInfo['windowId'] = windowId;
    }
    var completer =
        new ChromeCompleter.oneArg((window) => new Window(window));
    js.scoped(() {
      _tabs.highlight(
          js.map(highlightInfo), completer.callback);
    });
    return completer.future;
  }

  /**
   * Modifies the properties of a tab. Properties that are not specified are
   * not modified. Note: This function can be used without requesting the
   * 'tabs' permission in the manifest.
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
        new ChromeCompleter.oneArg((tab) {
          if (tab != null) {
            return new Tab(tab);
          } else {
            return null;
          }
        });
    js.scoped(() {
      _tabs.update(
          tabId, js.map(updateProperties), completer.callback);
    });
    return completer.future;
  }

  /**
   * Moves one or more tabs to a new position within its window, or to a new
   * window. Note that tabs can only be moved to and from normal windows.
   */
  Future<List<Tab>> move(List<int> tabIds, int index, {int windowId}) {
    Map<String, dynamic> moveProperties = { 'index': index};
    if (windowId != null) {
      moveProperties['windowId'] = windowId;
    }
    var completer =
        new ChromeCompleter.oneArg((jsTabs) {
          List<Tab> tabs = [];
          // jsTabs can either be an array of tabs or a single tab
          if (jsTabs['length'] != null) {
            for (int i = 0; i < jsTabs.length; i++) {
              tabs.add(new Tab(jsTabs[i]));
            }
          } else {
            tabs.add(new Tab(jsTabs));
          }

          return tabs;
        });
    js.scoped(() {
      _tabs.move(
          js.array(tabIds), js.map(moveProperties), completer.callback);
    });
    return completer.future;
  }

  /**
   * Reload a tab.
   */
  Future reload({int tabId, bool bypassCache}) {
    var reloadProperties = {};

    if (bypassCache != null) {
      reloadProperties['bypassCache'] = bypassCache;
    }

    var completer = new ChromeCompleter.noArgs();
    js.scoped(() {
      _tabs.reload(
          tabId, js.map(reloadProperties), completer.callback);
    });
    return completer.future;
  }

  /**
   * Closes one or more tabs. Note: This function can be used without
   * requesting the 'tabs' permission in the manifest.
   */
  Future remove(List<int> tabIds) {
    var completer = new ChromeCompleter.noArgs();
    js.scoped(() {
      _tabs.remove(js.array(tabIds), completer.callback);
    });
    return completer.future;
  }

  /**
   * Detects the primary language of the content in a tab.
   *
   * Returns an ISO language code such as 'en' or 'fr'.
   */
  Future<String> detectLanguage({int tabId}) {
    var completer = new ChromeCompleter.oneArg();
    js.scoped(() {
      _tabs.detectLanguage(tabId, completer.callback);
    });
    return completer.future;
  }

  /**
   * Captures the visible area of the currently active tab in the specified
   * window. You must have host permission for the URL displayed by the tab.
   *
   * The default [format] is 'jpeg'.
   *
   * Returns a data URL which encodes an image of the visible area of the
   * captured tab. May be assigned to the 'src' property of an HTML Image
   * element for display.
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
      _tabs.captureVisibleTab(
          windowId, js.map(options), completer.callback);
    });
    return completer.future;
  }

  /**
   * Injects JavaScript code into a page. For details, see the programmatic
   * injection section of the content scripts doc. Either the [code] or the
   * [file] parameter must be set, but both may not be set at the same time.
   */
  Future<js.Proxy> executeScript({
      int tabId,
      String code,
      String file,
      bool allFrames,
      RunAt runAt}) {
    var completer = new ChromeCompleter.oneArg();
    js.scoped(() {
      _tabs.executeScript(
          tabId,
          _createInjectDetails(code, file, allFrames, runAt),
          completer.callback);
    });
    return completer.future;
  }

  /**
   * Injects CSS into a page. For details, see the programmatic injection
   * section of the content scripts doc. Either the [code] or the [file]
   * parameter must be set, but both may not be set at the same time.
   */
  Future insertCSS({
      int tabId,
      String code,
      String file,
      bool allFrames,
      RunAt runAt}) {
    var completer = new ChromeCompleter.noArgs();
    js.scoped(() {
      _tabs.insertCSS(
          tabId,
          _createInjectDetails(code, file, allFrames, runAt),
          completer.callback);
    });
    return completer.future;
  }

  final ChromeStreamController<Tab> _onCreated =
      new ChromeStreamController<Tab>.oneArg(
          () => chromeProxy.tabs.onCreated,
          (tab) => new Tab(tab));

  /**
   * Fired when a tab is created. Note that the tab's URL may not be set at the
   * time this event fired, but you can listen to [onUpdated] events to be
   * notified when a URL is set.
   */
  Stream<Tab> get onCreated => _onCreated.stream;

  final ChromeStreamController<TabUpdatedEvent> _onUpdated =
      new ChromeStreamController<TabUpdatedEvent>.threeArgs(
          () => chromeProxy.tabs.onUpdated,
          (tabId, changeInfo, tab) =>
              new TabUpdatedEvent(new Tab(tab), changeInfo));

  /**
   * Fired when a tab is updated.
   */
  Stream<TabUpdatedEvent> get onUpdated => _onUpdated.stream;

  final ChromeStreamController<TabMovedEvent> _onMoved =
      new ChromeStreamController<TabMovedEvent>.twoArgs(
          () => chromeProxy.tabs.onMoved,
          (tabId, moveInfo) =>
              new TabMovedEvent.moved(tabId, moveInfo));

  /**
   * Fired when a tab is moved within a window. Only one move event is fired,
   * representing the tab the user directly moved. Move events are not fired
   * for the other tabs that must move in response. This event is not fired
   * when a tab is moved between windows. For that, see [onDetached].
   */
  Stream<TabMovedEvent>  get onMoved => _onMoved.stream;

  final ChromeStreamController<TabActivatedEvent> _onActivated =
      new ChromeStreamController<TabActivatedEvent>.oneArg(
          () => chromeProxy.tabs.onActivated,
          (activeInfo) =>
              new TabActivatedEvent(activeInfo));

  /**
   * Fires when the active tab in a window changes. Note that the tab's URL may
   * not be set at the time this event fired, but you can listen to [onUpdated]
   * events to be notified when a URL is set.
   */
  Stream<TabActivatedEvent> get onActivated => _onActivated.stream;

  final ChromeStreamController<TabHighlightedEvent> _onHighlighted =
      new ChromeStreamController<TabHighlightedEvent>.oneArg(
          () => chromeProxy.tabs.onHighlighted,
          (highlightInfo) =>
              new TabHighlightedEvent(highlightInfo));
  /**
   * Fired when the highlighted or selected tabs in a window changes.
   */
  Stream<TabHighlightedEvent> get onHighlighted => _onHighlighted.stream;

  final ChromeStreamController<TabMovedEvent> _onDetached =
      new ChromeStreamController<TabMovedEvent>.twoArgs(
          () => chromeProxy.tabs.onDetached,
          (tabId, detachInfo) =>
              new TabMovedEvent.detached(tabId, detachInfo));

  /**
   * Fired when a tab is detached from a window, for example because it is
   * being moved between windows.
   */
  Stream<TabMovedEvent> get onDetached => _onDetached.stream;

  final ChromeStreamController<TabMovedEvent> _onAttached =
      new ChromeStreamController<TabMovedEvent>.twoArgs(
          () => chromeProxy.tabs.onAttached,
          (tabId, attachInfo) =>
              new TabMovedEvent.attached(tabId, attachInfo));
  /**
   * Fired when a tab is attached to a window, for example because it was moved
   * between windows.
   */
  Stream<TabMovedEvent> get onAttached => _onAttached.stream;

  final ChromeStreamController<TabRemovedEvent> _onRemoved =
      new ChromeStreamController<TabRemovedEvent>.twoArgs(
          () => chromeProxy.tabs.onRemoved,
          (tabId, removeInfo) =>
              new TabRemovedEvent(tabId, removeInfo));

  /**
   * Fired when a tab is closed. Note: A listener can be registered for this
   * event without requesting the 'tabs' permission in the manifest.
   */
  Stream<TabRemovedEvent> get onRemoved => _onRemoved.stream;

  final ChromeStreamController<TabReplacedEvent> _onReplaced =
      new ChromeStreamController<TabReplacedEvent>.twoArgs(
          () => chromeProxy.tabs.onReplaced,
          (addedTabId, removedTabId) =>
              new TabReplacedEvent(addedTabId, addedTabId));

  /**
   * Fired when a tab is replaced with another tab due to prerendering or
   * instant.
   */
  Stream<TabReplacedEvent> get onReplaced => _onReplaced.stream;

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
}

class Tab {
  final int id;
  final int index;
  final int windowId;
  final int openerTabId;
  final bool highlighted;
  final bool active;
  final bool pinned;
  final String url;
  final String title;
  final String favIconUrl;
  final TabStatus status;
  final bool incognito;

  const Tab._(
      this.id,
      this.index,
      this.windowId,
      this.openerTabId,
      this.highlighted,
      this.active,
      this.pinned,
      this.url,
      this.title,
      this.favIconUrl,
      this.status,
      this.incognito);


  Tab(tab) : this._(
      tab.id,
      tab.index,
      tab.windowId,
      tab['openerTabId'],
      tab.highlighted,
      tab.active,
      tab.pinned,
      tab['url'],
      tab['title'],
      tab['favIconUrl'],
      tab['status'] != null ? new TabStatus(tab['status']) : null,
      tab.incognito);
}

class TabStatus {
  final String _status;

  const TabStatus._(this._status);

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

  static const TabStatus LOADING = const TabStatus._('loading');
  static const TabStatus COMPLETE = const TabStatus._('complete');
}

class ImageFormat {
  final String _format;

  const ImageFormat._(this._format);

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

  static const ImageFormat JPEG = const ImageFormat._('jpeg');
  static const ImageFormat PNG = const ImageFormat._('png');
}

class RunAt {
  final String _runAt;

  const RunAt._(this._runAt);

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

  static const RunAt DOCUMENT_START = const RunAt._('document_start');
  static const RunAt DOCUMENT_END = const RunAt._('document_end');
  static const RunAt DOCUMENT_IDLE = const RunAt._('document_idle');
}

class TabUpdatedEvent {
  final Tab tab;
  final TabStatus status;
  final String url;
  final bool pinned;
  final String favIconUrl;

  const TabUpdatedEvent._(
      this.tab, this.status, this.url, this.pinned, this.favIconUrl);

  TabUpdatedEvent(tab, changeInfo) : this._(
      tab,
      changeInfo['status'] != null ? new TabStatus(changeInfo.status) : null,
      changeInfo['url'],
      changeInfo['pinned'],
      changeInfo['favIconUrl']);
}

class TabMovedEvent {
  final String type;
  final int tabId;
  final int windowId;
  final int fromIndex;
  final int toIndex;

  const TabMovedEvent._(
      this.type, this.tabId, this.windowId, this.fromIndex, this.toIndex);

  TabMovedEvent.moved(tabId, moveInfo) : this._(
      'moved', tabId, moveInfo.windowId, moveInfo.fromIndex, moveInfo.toIndex);


  TabMovedEvent.detached(tabId, detachInfo) : this._(
      'detached', tabId, detachInfo.oldWindowId, detachInfo.oldPosition, null);


  TabMovedEvent.attached(tabId, attachInfo) : this._(
      'attached', tabId, attachInfo.newWindowId, null, attachInfo.newPosition);
}

class TabActivatedEvent {
  final int tabId;
  final int windowId;

  const TabActivatedEvent._(this.tabId, this.windowId);

  TabActivatedEvent(activeInfo)
      : this._(activeInfo.tabId, activeInfo.windowId);
}

class TabHighlightedEvent {
  final List<int> tabIds;
  final int windowId;

  const TabHighlightedEvent._(this.tabIds, this.windowId);

  TabHighlightedEvent(highlightInfo)
      : this._(listify(highlightInfo.tabIds), highlightInfo.windowId);
}

class TabRemovedEvent {
  final int tabId;
  final int windowId;
  final bool isWindowClosing;

  const TabRemovedEvent._(this.tabId, this.windowId, this.isWindowClosing);

  TabRemovedEvent(tabId, removeInfo)
      : this._(tabId, removeInfo.windowId, removeInfo.isWindowClosing);
}

class TabReplacedEvent {
  final int addedTabId;
  final int removedTabId;

  TabReplacedEvent(this.addedTabId, this.removedTabId);
}
