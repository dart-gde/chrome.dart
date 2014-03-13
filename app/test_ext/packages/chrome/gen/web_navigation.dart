/* This file has been generated from web_navigation.json - do not edit */

/**
 * Use the `chrome.webNavigation` API to receive notifications about the status
 * of navigation requests in-flight.
 */
library chrome.webNavigation;

import '../src/common.dart';

/**
 * Accessor for the `chrome.webNavigation` namespace.
 */
final ChromeWebNavigation webNavigation = new ChromeWebNavigation._();

class ChromeWebNavigation extends ChromeApi {
  JsObject get _webNavigation => chrome['webNavigation'];

  /**
   * Fired when a navigation is about to occur.
   */
  Stream<Map> get onBeforeNavigate => _onBeforeNavigate.stream;
  ChromeStreamController<Map> _onBeforeNavigate;

  /**
   * Fired when a navigation is committed. The document (and the resources it
   * refers to, such as images and subframes) might still be downloading, but at
   * least part of the document has been received from the server and the
   * browser has decided to switch to the new document.
   */
  Stream<Map> get onCommitted => _onCommitted.stream;
  ChromeStreamController<Map> _onCommitted;

  /**
   * Fired when the page's DOM is fully constructed, but the referenced
   * resources may not finish loading.
   */
  Stream<Map> get onDOMContentLoaded => _onDOMContentLoaded.stream;
  ChromeStreamController<Map> _onDOMContentLoaded;

  /**
   * Fired when a document, including the resources it refers to, is completely
   * loaded and initialized.
   */
  Stream<Map> get onCompleted => _onCompleted.stream;
  ChromeStreamController<Map> _onCompleted;

  /**
   * Fired when an error occurs and the navigation is aborted. This can happen
   * if either a network error occurred, or the user aborted the navigation.
   */
  Stream<Map> get onErrorOccurred => _onErrorOccurred.stream;
  ChromeStreamController<Map> _onErrorOccurred;

  /**
   * Fired when a new window, or a new tab in an existing window, is created to
   * host a navigation.
   */
  Stream<Map> get onCreatedNavigationTarget => _onCreatedNavigationTarget.stream;
  ChromeStreamController<Map> _onCreatedNavigationTarget;

  /**
   * Fired when the reference fragment of a frame was updated. All future events
   * for that frame will use the updated URL.
   */
  Stream<Map> get onReferenceFragmentUpdated => _onReferenceFragmentUpdated.stream;
  ChromeStreamController<Map> _onReferenceFragmentUpdated;

  /**
   * Fired when the contents of the tab is replaced by a different (usually
   * previously pre-rendered) tab.
   */
  Stream<Map> get onTabReplaced => _onTabReplaced.stream;
  ChromeStreamController<Map> _onTabReplaced;

  /**
   * Fired when the frame's history was updated to a new URL. All future events
   * for that frame will use the updated URL.
   */
  Stream<Map> get onHistoryStateUpdated => _onHistoryStateUpdated.stream;
  ChromeStreamController<Map> _onHistoryStateUpdated;

  ChromeWebNavigation._() {
    var getApi = () => _webNavigation;
    _onBeforeNavigate = new ChromeStreamController<Map>.oneArg(getApi, 'onBeforeNavigate', mapify);
    _onCommitted = new ChromeStreamController<Map>.oneArg(getApi, 'onCommitted', mapify);
    _onDOMContentLoaded = new ChromeStreamController<Map>.oneArg(getApi, 'onDOMContentLoaded', mapify);
    _onCompleted = new ChromeStreamController<Map>.oneArg(getApi, 'onCompleted', mapify);
    _onErrorOccurred = new ChromeStreamController<Map>.oneArg(getApi, 'onErrorOccurred', mapify);
    _onCreatedNavigationTarget = new ChromeStreamController<Map>.oneArg(getApi, 'onCreatedNavigationTarget', mapify);
    _onReferenceFragmentUpdated = new ChromeStreamController<Map>.oneArg(getApi, 'onReferenceFragmentUpdated', mapify);
    _onTabReplaced = new ChromeStreamController<Map>.oneArg(getApi, 'onTabReplaced', mapify);
    _onHistoryStateUpdated = new ChromeStreamController<Map>.oneArg(getApi, 'onHistoryStateUpdated', mapify);
  }

  bool get available => _webNavigation != null;

  /**
   * Retrieves information about the given frame. A frame refers to an
   * &lt;iframe&gt; or a &lt;frame&gt; of a web page and is identified by a tab
   * ID and a frame ID.
   * 
   * [details] Information about the frame to retrieve information about.
   * 
   * Returns:
   * Information about the requested frame, null if the specified frame ID
   * and/or tab ID are invalid.
   */
  Future<Map> getFrame(WebNavigationGetFrameParams details) {
    if (_webNavigation == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Map>.oneArg(mapify);
    _webNavigation.callMethod('getFrame', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Retrieves information about all frames of a given tab.
   * 
   * [details] Information about the tab to retrieve all frames from.
   * 
   * Returns:
   * A list of frames in the given tab, null if the specified tab ID is invalid.
   */
  Future<List<Map>> getAllFrames(WebNavigationGetAllFramesParams details) {
    if (_webNavigation == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<Map>>.oneArg((e) => listify(e, mapify));
    _webNavigation.callMethod('getAllFrames', [jsify(details), completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.webNavigation' is not available");
  }
}

class WebNavigationGetFrameParams extends ChromeObject {
  WebNavigationGetFrameParams({int tabId, int processId, int frameId}) {
    if (tabId != null) this.tabId = tabId;
    if (processId != null) this.processId = processId;
    if (frameId != null) this.frameId = frameId;
  }
  WebNavigationGetFrameParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The ID of the tab in which the frame is.
   */
  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;

  /**
   * The ID of the process runs the renderer for this tab.
   */
  int get processId => jsProxy['processId'];
  set processId(int value) => jsProxy['processId'] = value;

  /**
   * The ID of the frame in the given tab.
   */
  int get frameId => jsProxy['frameId'];
  set frameId(int value) => jsProxy['frameId'] = value;
}

class WebNavigationGetAllFramesParams extends ChromeObject {
  WebNavigationGetAllFramesParams({int tabId}) {
    if (tabId != null) this.tabId = tabId;
  }
  WebNavigationGetAllFramesParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The ID of the tab.
   */
  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;
}
