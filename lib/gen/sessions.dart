/* This file has been generated from sessions.json - do not edit */

/**
 * Use the `chrome.sessions` API to query and restore tabs and windows from a
 * browsing session.
 */
library chrome.sessions;

import 'tabs.dart';
import 'windows.dart';
import '../src/common.dart';

/**
 * Accessor for the `chrome.sessions` namespace.
 */
final ChromeSessions sessions = new ChromeSessions._();

class ChromeSessions extends ChromeApi {
  static final JsObject _sessions = chrome['sessions'];

  ChromeSessions._();

  bool get available => _sessions != null;

  /**
   * The maximum number of [Session] that will be included in a requested list.
   */
  int get MAX_SESSION_RESULTS => _sessions['MAX_SESSION_RESULTS'];

  /**
   * Gets the list of recently closed tabs and/or windows.
   * 
   * Returns:
   * The list of closed entries in reverse order that they were closed (the most
   * recently closed tab or window will be at index `0`).The entries may contain
   * either tabs or windows.
   */
  Future<List<Session>> getRecentlyClosed([Filter filter]) {
    if (_sessions == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<Session>>.oneArg((e) => listify(e, _createSession));
    _sessions.callMethod('getRecentlyClosed', [jsify(filter), completer.callback]);
    return completer.future;
  }

  /**
   * Retrieves all devices with synced sessions.
   * 
   * Returns:
   * The list of [Device] objects for each synced session, sorted in order from
   * device with most recently modified session to device with least recently
   * modified session. [tabs.Tab] objects are sorted by recency in the
   * [windows.Window] of the [Session] objects.
   */
  Future<List<Device>> getDevices([Filter filter]) {
    if (_sessions == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<Device>>.oneArg((e) => listify(e, _createDevice));
    _sessions.callMethod('getDevices', [jsify(filter), completer.callback]);
    return completer.future;
  }

  /**
   * Reopens a [windows.Window] or [tabs.Tab], with an optional callback to run
   * when the entry has been restored.
   * 
   * [sessionId] The [windows.Window.sessionId], or [tabs.Tab.sessionId] to
   * restore.
   * 
   * Returns:
   * A [Session] containing the restored [windows.Window] or [tabs.Tab] object.
   */
  Future<Session> restore([String sessionId]) {
    if (_sessions == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Session>.oneArg(_createSession);
    _sessions.callMethod('restore', [sessionId, completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.sessions' is not available");
  }
}

class Filter extends ChromeObject {
  Filter({int maxResults}) {
    if (maxResults != null) this.maxResults = maxResults;
  }
  Filter.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The maximum number of entries to be fetched in the requested list. Omit
   * this parameter to fetch the maximum number of entries
   * ([MAX_SESSION_RESULTS]).
   */
  int get maxResults => jsProxy['maxResults'];
  set maxResults(int value) => jsProxy['maxResults'] = value;
}

class Session extends ChromeObject {
  Session({int lastModified, Tab tab, Window window}) {
    if (lastModified != null) this.lastModified = lastModified;
    if (tab != null) this.tab = tab;
    if (window != null) this.window = window;
  }
  Session.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The time when the window or tab was closed or modified, represented in
   * milliseconds since the epoch.
   */
  int get lastModified => jsProxy['lastModified'];
  set lastModified(int value) => jsProxy['lastModified'] = value;

  /**
   * The [tabs.Tab], if this entry describes a tab. Either this or
   * [Session.window] will be set.
   */
  Tab get tab => _createTab(jsProxy['tab']);
  set tab(Tab value) => jsProxy['tab'] = jsify(value);

  /**
   * The [windows.Window], if this entry describes a window. Either this or
   * [Session.tab] will be set.
   */
  Window get window => _createWindow(jsProxy['window']);
  set window(Window value) => jsProxy['window'] = jsify(value);
}

class Device extends ChromeObject {
  Device({String info, List<Session> sessions}) {
    if (info != null) this.info = info;
    if (sessions != null) this.sessions = sessions;
  }
  Device.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Represents all information about a foreign device.
   */
  String get info => jsProxy['info'];
  set info(String value) => jsProxy['info'] = value;

  /**
   * A list of open window sessions for the foreign device, sorted from most
   * recently to least recently modified session.
   */
  List<Session> get sessions => listify(jsProxy['sessions'], _createSession);
  set sessions(List<Session> value) => jsProxy['sessions'] = jsify(value);
}

Session _createSession(JsObject jsProxy) => jsProxy == null ? null : new Session.fromProxy(jsProxy);
Device _createDevice(JsObject jsProxy) => jsProxy == null ? null : new Device.fromProxy(jsProxy);
Tab _createTab(JsObject jsProxy) => jsProxy == null ? null : new Tab.fromProxy(jsProxy);
Window _createWindow(JsObject jsProxy) => jsProxy == null ? null : new Window.fromProxy(jsProxy);
