/* This file has been generated from runtime.json - do not edit */

/**
 * Use the `chrome.runtime` API to retrieve the background page, return details
 * about the manifest, and listen for and respond to events in the app or
 * extension lifecycle. You can also use this API to convert the relative path
 * of URLs to fully-qualified URLs.
 */
library chrome.runtime;

import '../src/files.dart';
import 'events.dart';
import 'tabs.dart';
import 'windows.dart';
import '../src/common.dart';

/**
 * Accessor for the `chrome.runtime` namespace.
 */
final ChromeRuntime runtime = new ChromeRuntime._();

class ChromeRuntime extends ChromeApi {
  JsObject get _runtime => chrome['runtime'];

  /**
   * Fired when a profile that has this extension installed first starts up.
   * This event is not fired when an incognito profile is started, even if this
   * extension is operating in 'split' incognito mode.
   */
  Stream get onStartup => _onStartup.stream;
  ChromeStreamController _onStartup;

  /**
   * Fired when the extension is first installed, when the extension is updated
   * to a new version, and when Chrome is updated to a new version.
   */
  Stream<Map> get onInstalled => _onInstalled.stream;
  ChromeStreamController<Map> _onInstalled;

  /**
   * Sent to the event page just before it is unloaded. This gives the extension
   * opportunity to do some clean up. Note that since the page is unloading, any
   * asynchronous operations started while handling this event are not
   * guaranteed to complete. If more activity for the event page occurs before
   * it gets unloaded the onSuspendCanceled event will be sent and the page
   * won't be unloaded.
   */
  Stream get onSuspend => _onSuspend.stream;
  ChromeStreamController _onSuspend;

  /**
   * Sent after onSuspend to indicate that the app won't be unloaded after all.
   */
  Stream get onSuspendCanceled => _onSuspendCanceled.stream;
  ChromeStreamController _onSuspendCanceled;

  /**
   * Fired when an update is available, but isn't installed immediately because
   * the app is currently running. If you do nothing, the update will be
   * installed the next time the background page gets unloaded, if you want it
   * to be installed sooner you can explicitly call chrome.runtime.reload().
   */
  Stream<Map<String, dynamic>> get onUpdateAvailable => _onUpdateAvailable.stream;
  ChromeStreamController<Map<String, dynamic>> _onUpdateAvailable;

  /**
   * Fired when a Chrome update is available, but isn't installed immediately
   * because a browser restart is required.
   */
  Stream get onBrowserUpdateAvailable => _onBrowserUpdateAvailable.stream;
  ChromeStreamController _onBrowserUpdateAvailable;

  /**
   * Fired when a connection is made from either an extension process or a
   * content script.
   */
  Stream<Port> get onConnect => _onConnect.stream;
  ChromeStreamController<Port> _onConnect;

  /**
   * Fired when a connection is made from another extension.
   */
  Stream<Port> get onConnectExternal => _onConnectExternal.stream;
  ChromeStreamController<Port> _onConnectExternal;

  /**
   * Fired when a message is sent from either an extension process or a content
   * script.
   */
  Stream<OnMessageEvent> get onMessage => _onMessage.stream;
  ChromeStreamController<OnMessageEvent> _onMessage;

  /**
   * Fired when a message is sent from another extension/app. Cannot be used in
   * a content script.
   */
  Stream<OnMessageExternalEvent> get onMessageExternal => _onMessageExternal.stream;
  ChromeStreamController<OnMessageExternalEvent> _onMessageExternal;

  /**
   * Fired when an app or the device that it runs on needs to be restarted. The
   * app should close all its windows at its earliest convenient time to let the
   * restart to happen. If the app does nothing, a restart will be enforced
   * after a 24-hour grace period has passed. Currently, this event is only
   * fired for Chrome OS kiosk apps.
   */
  Stream<String> get onRestartRequired => _onRestartRequired.stream;
  ChromeStreamController<String> _onRestartRequired;

  ChromeRuntime._() {
    var getApi = () => _runtime;
    _onStartup = new ChromeStreamController.noArgs(getApi, 'onStartup');
    _onInstalled = new ChromeStreamController<Map>.oneArg(getApi, 'onInstalled', mapify);
    _onSuspend = new ChromeStreamController.noArgs(getApi, 'onSuspend');
    _onSuspendCanceled = new ChromeStreamController.noArgs(getApi, 'onSuspendCanceled');
    _onUpdateAvailable = new ChromeStreamController<Map<String, dynamic>>.oneArg(getApi, 'onUpdateAvailable', mapify);
    _onBrowserUpdateAvailable = new ChromeStreamController.noArgs(getApi, 'onBrowserUpdateAvailable');
    _onConnect = new ChromeStreamController<Port>.oneArg(getApi, 'onConnect', _createPort);
    _onConnectExternal = new ChromeStreamController<Port>.oneArg(getApi, 'onConnectExternal', _createPort);
    _onMessage = new ChromeStreamController<OnMessageEvent>.threeArgs(getApi, 'onMessage', _createOnMessageEvent);
    _onMessageExternal = new ChromeStreamController<OnMessageExternalEvent>.threeArgs(getApi, 'onMessageExternal', _createOnMessageExternalEvent);
    _onRestartRequired = new ChromeStreamController<String>.oneArg(getApi, 'onRestartRequired', selfConverter);
  }

  bool get available => _runtime != null;

  /**
   * This will be defined during an API method callback if there was an error
   */
  LastErrorRuntime get lastError => _createLastErrorRuntime(_runtime['lastError']);

  /**
   * The ID of the extension/app.
   */
  String get id => _runtime['id'];

  /**
   * Retrieves the JavaScript 'window' object for the background page running
   * inside the current extension/app. If the background page is an event page,
   * the system will ensure it is loaded before calling the callback. If there
   * is no background page, an error is set.
   * 
   * Returns:
   * The JavaScript 'window' object for the background page.
   */
  Future<Window> getBackgroundPage() {
    if (_runtime == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Window>.oneArg(_createWindow);
    _runtime.callMethod('getBackgroundPage', [completer.callback]);
    return completer.future;
  }

  /**
   * Returns details about the app or extension from the manifest. The object
   * returned is a serialization of the full [manifest file](manifest.html).
   * 
   * Returns:
   * The manifest details.
   */
  Map<String, dynamic> getManifest() {
    if (_runtime == null) _throwNotAvailable();

    return mapify(_runtime.callMethod('getManifest'));
  }

  /**
   * Converts a relative path within an app/extension install directory to a
   * fully-qualified URL.
   * 
   * [path] A path to a resource within an app/extension expressed relative to
   * its install directory.
   * 
   * Returns:
   * The fully-qualified URL to the resource.
   */
  String getURL(String path) {
    if (_runtime == null) _throwNotAvailable();

    return _runtime.callMethod('getURL', [path]);
  }

  /**
   * Sets the URL to be visited upon uninstallation. This may be used to clean
   * up server-side data, do analytics, and implement surveys. Maximum 255
   * characters.
   */
  void setUninstallUrl(String url) {
    if (_runtime == null) _throwNotAvailable();

    _runtime.callMethod('setUninstallUrl', [url]);
  }

  /**
   * Reloads the app or extension.
   */
  void reload() {
    if (_runtime == null) _throwNotAvailable();

    _runtime.callMethod('reload');
  }

  /**
   * Requests an update check for this app/extension.
   * 
   * Returns:
   * [status] Result of the update check.
   * enum of `throttled`, `no_update`, `update_available`
   * [details] If an update is available, this contains more information about
   * the available update.
   */
  Future<RequestUpdateCheckResult> requestUpdateCheck() {
    if (_runtime == null) _throwNotAvailable();

    var completer = new ChromeCompleter<RequestUpdateCheckResult>.twoArgs(RequestUpdateCheckResult._create);
    _runtime.callMethod('requestUpdateCheck', [completer.callback]);
    return completer.future;
  }

  /**
   * Restart the ChromeOS device when the app runs in kiosk mode. Otherwise,
   * it's no-op.
   */
  void restart() {
    if (_runtime == null) _throwNotAvailable();

    _runtime.callMethod('restart');
  }

  /**
   * Attempts to connect to other listeners within the extension/app (such as
   * the background page), or other extensions/apps. This is useful for content
   * scripts connecting to their extension processes. Note that this does not
   * connect to any listeners in a content script. Extensions may connect to
   * content scripts embedded in tabs via [tabs.connect.]
   * 
   * [extensionId] The ID of the extension/app you want to connect to. If
   * omitted, default is your own extension.
   * 
   * Returns:
   * Port through which messages can be sent and received. The port's
   * [][runtime.Port onDisconnect] event is fired if the extension/app does not
   * exist.
   */
  Port connect([String extensionId, RuntimeConnectParams connectInfo]) {
    if (_runtime == null) _throwNotAvailable();

    return _createPort(_runtime.callMethod('connect', [extensionId, jsify(connectInfo)]));
  }

  /**
   * Connects to a native application in the host machine.
   * 
   * [application] The name of the registered application to connect to.
   * 
   * Returns:
   * Port through which messages can be sent and received with the application
   */
  Port connectNative(String application) {
    if (_runtime == null) _throwNotAvailable();

    return _createPort(_runtime.callMethod('connectNative', [application]));
  }

  /**
   * Sends a single message to onMessage event listeners within the extension
   * (or another extension/app). Similar to chrome.runtime.connect, but only
   * sends a single message with an optional response. The [runtime.onMessage]
   * event is fired in each extension page of the extension. Note that
   * extensions cannot send messages to content scripts using this method. To
   * send messages to content scripts, use [tabs.sendMessage.]
   * 
   * [extensionId] The extension ID of the extension you want to connect to. If
   * omitted, default is your own extension.
   * 
   * Returns:
   * The JSON response object sent by the handler of the message. If an error
   * occurs while connecting to the extension, the callback will be called with
   * no arguments and [runtime.lastError] will be set to the error message.
   */
  Future<dynamic> sendMessage(dynamic message, [String extensionId, RuntimeSendMessageParams options]) {
    if (_runtime == null) _throwNotAvailable();

    var completer = new ChromeCompleter<dynamic>.oneArg();
    _runtime.callMethod('sendMessage', [extensionId, jsify(message), jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Send a single message to a native application.
   * 
   * [application] The name of the native messaging host.
   * 
   * [message] The message that will be passed to the native messaging host.
   * 
   * Returns:
   * The response message send by the native messaging host. If an error occurs
   * while connecting to the native messaging host, the callback will be called
   * with no arguments and [runtime.lastError] will be set to the error message.
   */
  Future<dynamic> sendNativeMessage(String application, Map<String, dynamic> message) {
    if (_runtime == null) _throwNotAvailable();

    var completer = new ChromeCompleter<dynamic>.oneArg();
    _runtime.callMethod('sendNativeMessage', [application, jsify(message), completer.callback]);
    return completer.future;
  }

  /**
   * Returns information about the current platform.
   */
  Future<Map> getPlatformInfo() {
    if (_runtime == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Map>.oneArg(mapify);
    _runtime.callMethod('getPlatformInfo', [completer.callback]);
    return completer.future;
  }

  /**
   * Returns a DirectoryEntry for the package directory.
   */
  Future<DirectoryEntry> getPackageDirectoryEntry() {
    if (_runtime == null) _throwNotAvailable();

    var completer = new ChromeCompleter<DirectoryEntry>.oneArg(_createDirectoryEntry);
    _runtime.callMethod('getPackageDirectoryEntry', [completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.runtime' is not available");
  }
}

/**
 * Fired when a message is sent from either an extension process or a content
 * script.
 */
class OnMessageEvent {
  /**
   * The message sent by the calling script.
   * `optional`
   * 
   * The message sent by the calling script.
   */
  final dynamic message;

  final MessageSender sender;

  /**
   * Function to call (at most once) when you have a response. The argument
   * should be any JSON-ifiable object. If you have more than one `onMessage`
   * listener in the same document, then only one may send a response. This
   * function becomes invalid when the event listener returns, unless you return
   * true from the event listener to indicate you wish to send a response
   * asynchronously (this will keep the message channel open to the other end
   * until `sendResponse` is called).
   */
  final dynamic sendResponse;

  OnMessageEvent(this.message, this.sender, this.sendResponse);
}

/**
 * Fired when a message is sent from another extension/app. Cannot be used in a
 * content script.
 */
class OnMessageExternalEvent {
  /**
   * The message sent by the calling script.
   * `optional`
   * 
   * The message sent by the calling script.
   */
  final dynamic message;

  final MessageSender sender;

  /**
   * Function to call (at most once) when you have a response. The argument
   * should be any JSON-ifiable object. If you have more than one `onMessage`
   * listener in the same document, then only one may send a response. This
   * function becomes invalid when the event listener returns, unless you return
   * true from the event listener to indicate you wish to send a response
   * asynchronously (this will keep the message channel open to the other end
   * until `sendResponse` is called).
   */
  final dynamic sendResponse;

  OnMessageExternalEvent(this.message, this.sender, this.sendResponse);
}

class LastErrorRuntime extends ChromeObject {
  LastErrorRuntime();
  LastErrorRuntime.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Details about the error which occurred.
   */
  String get message => jsProxy['message'];
}

/**
 * An object which allows two way communication with other pages.
 */
class Port extends ChromeObject {
  Port({String name, var disconnect, ChromeEvent onDisconnect, ChromeEvent onMessage, var postMessage, MessageSender sender}) {
    if (name != null) this.name = name;
    if (disconnect != null) this.disconnect = disconnect;
    if (onDisconnect != null) this.onDisconnect = onDisconnect;
    if (onMessage != null) this.onMessage = onMessage;
    if (postMessage != null) this.postMessage = postMessage;
    if (sender != null) this.sender = sender;
  }
  Port.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  dynamic get disconnect => jsProxy['disconnect'];
  set disconnect(var value) => jsProxy['disconnect'] = jsify(value);

  ChromeEvent get onDisconnect => _createEvent(jsProxy['onDisconnect']);
  set onDisconnect(ChromeEvent value) => jsProxy['onDisconnect'] = jsify(value);

  ChromeEvent get onMessage => _createEvent(jsProxy['onMessage']);
  set onMessage(ChromeEvent value) => jsProxy['onMessage'] = jsify(value);

  dynamic get postMessage => jsProxy['postMessage'];
  set postMessage(var value) => jsProxy['postMessage'] = jsify(value);

  /**
   * This property will <b>only</b> be present on ports passed to
   * onConnect/onConnectExternal listeners.
   */
  MessageSender get sender => _createMessageSender(jsProxy['sender']);
  set sender(MessageSender value) => jsProxy['sender'] = jsify(value);
}

/**
 * An object containing information about the script context that sent a message
 * or request.
 */
class MessageSender extends ChromeObject {
  MessageSender({Tab tab, String id, String url, String tlsChannelId}) {
    if (tab != null) this.tab = tab;
    if (id != null) this.id = id;
    if (url != null) this.url = url;
    if (tlsChannelId != null) this.tlsChannelId = tlsChannelId;
  }
  MessageSender.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The [tabs.Tab] which opened the connection, if any. This property will
   * *only* be present when the connection was opened from a tab (including
   * content scripts), and *only* if the receiver is an extension, not an app.
   */
  Tab get tab => _createTab(jsProxy['tab']);
  set tab(Tab value) => jsProxy['tab'] = jsify(value);

  /**
   * The ID of the extension or app that opened the connection, if any.
   */
  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  /**
   * The URL of the page or frame that opened the connection, if any. This
   * property will *only* be present when the connection was opened from a tab
   * or content script.
   */
  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;

  /**
   * The TLS channel ID of the web page that opened the connection, if requested
   * by the extension or app, and if available.
   */
  String get tlsChannelId => jsProxy['tlsChannelId'];
  set tlsChannelId(String value) => jsProxy['tlsChannelId'] = value;
}

class RuntimeConnectParams extends ChromeObject {
  RuntimeConnectParams({String name, bool includeTlsChannelId}) {
    if (name != null) this.name = name;
    if (includeTlsChannelId != null) this.includeTlsChannelId = includeTlsChannelId;
  }
  RuntimeConnectParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Will be passed into onConnect for processes that are listening for the
   * connection event.
   */
  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  /**
   * Whether the TLS channel ID will be passed into onConnectExternal for
   * processes that are listening for the connection event.
   */
  bool get includeTlsChannelId => jsProxy['includeTlsChannelId'];
  set includeTlsChannelId(bool value) => jsProxy['includeTlsChannelId'] = value;
}

class RuntimeSendMessageParams extends ChromeObject {
  RuntimeSendMessageParams({bool includeTlsChannelId}) {
    if (includeTlsChannelId != null) this.includeTlsChannelId = includeTlsChannelId;
  }
  RuntimeSendMessageParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Whether the TLS channel ID will be passed into onMessageExternal for
   * processes that are listening for the connection event.
   */
  bool get includeTlsChannelId => jsProxy['includeTlsChannelId'];
  set includeTlsChannelId(bool value) => jsProxy['includeTlsChannelId'] = value;
}

/**
 * The return type for [requestUpdateCheck].
 */
class RequestUpdateCheckResult {
  static RequestUpdateCheckResult _create(status, details) {
    return new RequestUpdateCheckResult._(status, mapify(details));
  }

  String status;
  Map details;

  RequestUpdateCheckResult._(this.status, this.details);
}

Port _createPort(JsObject jsProxy) => jsProxy == null ? null : new Port.fromProxy(jsProxy);
OnMessageEvent _createOnMessageEvent(JsObject message, JsObject sender, JsObject sendResponse) =>
    new OnMessageEvent(message, _createMessageSender(sender), sendResponse);
OnMessageExternalEvent _createOnMessageExternalEvent(JsObject message, JsObject sender, JsObject sendResponse) =>
    new OnMessageExternalEvent(message, _createMessageSender(sender), sendResponse);
LastErrorRuntime _createLastErrorRuntime(JsObject jsProxy) => jsProxy == null ? null : new LastErrorRuntime.fromProxy(jsProxy);
Window _createWindow(JsObject jsProxy) => jsProxy == null ? null : new Window.fromProxy(jsProxy);
DirectoryEntry _createDirectoryEntry(JsObject jsProxy) => jsProxy == null ? null : new CrDirectoryEntry.fromProxy(jsProxy);
ChromeEvent _createEvent(JsObject jsProxy) => jsProxy == null ? null : new ChromeEvent.fromProxy(jsProxy);
MessageSender _createMessageSender(JsObject jsProxy) => jsProxy == null ? null : new MessageSender.fromProxy(jsProxy);
Tab _createTab(JsObject jsProxy) => jsProxy == null ? null : new Tab.fromProxy(jsProxy);
