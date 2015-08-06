/* This file has been generated from extension.json - do not edit */

/**
 * The `chrome.extension` API has utilities that can be used by any extension
 * page. It includes support for exchanging messages between an extension and
 * its content scripts or between extensions, as described in detail in [Message
 * Passing](messaging).
 */
library chrome.extension;

import 'runtime.dart';
import 'windows.dart';
import '../src/common.dart';

/**
 * Accessor for the `chrome.extension` namespace.
 */
final ChromeExtension extension = new ChromeExtension._();

class ChromeExtension extends ChromeApi {
  JsObject get _extension => chrome['extension'];

  /**
   * Fired when a request is sent from either an extension process or a content
   * script.
   */
  Stream<OnRequestEvent> get onRequest => _onRequest.stream;
  ChromeStreamController<OnRequestEvent> _onRequest;

  /**
   * Fired when a request is sent from another extension.
   */
  Stream<OnRequestExternalEvent> get onRequestExternal => _onRequestExternal.stream;
  ChromeStreamController<OnRequestExternalEvent> _onRequestExternal;

  ChromeExtension._() {
    var getApi = () => _extension;
    _onRequest = new ChromeStreamController<OnRequestEvent>.threeArgs(getApi, 'onRequest', _createOnRequestEvent);
    _onRequestExternal = new ChromeStreamController<OnRequestExternalEvent>.threeArgs(getApi, 'onRequestExternal', _createOnRequestExternalEvent);
  }

  bool get available => _extension != null;

  /**
   * Set for the lifetime of a callback if an ansychronous extension api has
   * resulted in an error. If no error has occured lastError will be
   * [undefined].
   */
  LastErrorExtension get lastError => _createLastErrorExtension(_extension['lastError']);

  /**
   * True for content scripts running inside incognito tabs, and for extension
   * pages running inside an incognito process. The latter only applies to
   * extensions with 'split' incognito_behavior.
   */
  bool get inIncognitoContext => _extension['inIncognitoContext'];

  /**
   * Sends a single request to other listeners within the extension. Similar to
   * [runtime.connect], but only sends a single request with an optional
   * response. The [extension.onRequest] event is fired in each page of the
   * extension.
   * 
   * [extensionId] The extension ID of the extension you want to connect to. If
   * omitted, default is your own extension.
   * 
   * Returns:
   * The JSON response object sent by the handler of the request. If an error
   * occurs while connecting to the extension, the callback will be called with
   * no arguments and [runtime.lastError] will be set to the error message.
   */
  Future<dynamic> sendRequest(dynamic request, [String extensionId]) {
    if (_extension == null) _throwNotAvailable();

    var completer = new ChromeCompleter<dynamic>.oneArg();
    _extension.callMethod('sendRequest', [extensionId, jsify(request), completer.callback]);
    return completer.future;
  }

  /**
   * Converts a relative path within an extension install directory to a
   * fully-qualified URL.
   * 
   * [path] A path to a resource within an extension expressed relative to its
   * install directory.
   * 
   * Returns:
   * The fully-qualified URL to the resource.
   */
  String getURL(String path) {
    if (_extension == null) _throwNotAvailable();

    return _extension.callMethod('getURL', [path]);
  }

  /**
   * Returns an array of the JavaScript 'window' objects for each of the pages
   * running inside the current extension.
   * 
   * Returns:
   * Array of global objects
   */
  List<Window> getViews([ExtensionGetViewsParams fetchProperties]) {
    if (_extension == null) _throwNotAvailable();

    var ret = _extension.callMethod('getViews', [jsify(fetchProperties)]);
    return ret;
  }

  /**
   * Returns the JavaScript 'window' object for the background page running
   * inside the current extension. Returns null if the extension has no
   * background page.
   */
  Window getBackgroundPage() {
    if (_extension == null) _throwNotAvailable();

    return _createWindow(_extension.callMethod('getBackgroundPage'));
  }

  /**
   * Returns an array of the JavaScript 'window' objects for each of the tabs
   * running inside the current extension. If `windowId` is specified, returns
   * only the 'window' objects of tabs attached to the specified window.
   * 
   * Returns:
   * Array of global window objects
   */
  List<Window> getExtensionTabs([int windowId]) {
    if (_extension == null) _throwNotAvailable();

    var ret = _extension.callMethod('getExtensionTabs', [windowId]);
    return ret;
  }

  /**
   * Retrieves the state of the extension's access to Incognito-mode (as
   * determined by the user-controlled 'Allowed in Incognito' checkbox.
   * 
   * Returns:
   * True if the extension has access to Incognito mode, false otherwise.
   */
  Future<bool> isAllowedIncognitoAccess() {
    if (_extension == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _extension.callMethod('isAllowedIncognitoAccess', [completer.callback]);
    return completer.future;
  }

  /**
   * Retrieves the state of the extension's access to the 'file://' scheme (as
   * determined by the user-controlled 'Allow access to File URLs' checkbox.
   * 
   * Returns:
   * True if the extension can access the 'file://' scheme, false otherwise.
   */
  Future<bool> isAllowedFileSchemeAccess() {
    if (_extension == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _extension.callMethod('isAllowedFileSchemeAccess', [completer.callback]);
    return completer.future;
  }

  /**
   * Sets the value of the ap CGI parameter used in the extension's update URL.
   * This value is ignored for extensions that are hosted in the Chrome
   * Extension Gallery.
   */
  void setUpdateUrlData(String data) {
    if (_extension == null) _throwNotAvailable();

    _extension.callMethod('setUpdateUrlData', [data]);
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.extension' is not available");
  }
}

/**
 * Fired when a request is sent from either an extension process or a content
 * script.
 */
class OnRequestEvent {
  /**
   * The request sent by the calling script.
   * `optional`
   * 
   * The request sent by the calling script.
   */
  final dynamic request;

  final MessageSender sender;

  /**
   * Function to call (at most once) when you have a response. The argument
   * should be any JSON-ifiable object, or undefined if there is no response. If
   * you have more than one `onRequest` listener in the same document, then only
   * one may send a response.
   */
  final dynamic sendResponse;

  OnRequestEvent(this.request, this.sender, this.sendResponse);
}

/**
 * Fired when a request is sent from another extension.
 */
class OnRequestExternalEvent {
  /**
   * The request sent by the calling script.
   * `optional`
   * 
   * The request sent by the calling script.
   */
  final dynamic request;

  final MessageSender sender;

  /**
   * Function to call when you have a response. The argument should be any
   * JSON-ifiable object, or undefined if there is no response.
   */
  final dynamic sendResponse;

  OnRequestExternalEvent(this.request, this.sender, this.sendResponse);
}

class LastErrorExtension extends ChromeObject {
  LastErrorExtension();
  LastErrorExtension.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Description of the error that has taken place.
   */
  String get message => jsProxy['message'];
}

/**
 * The type of extension view.
 * enum of `tab`, `notification`, `popup`
 */
class ViewType extends ChromeObject {
  ViewType();
  ViewType.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

class ExtensionGetViewsParams extends ChromeObject {
  ExtensionGetViewsParams({ViewType type, int windowId}) {
    if (type != null) this.type = type;
    if (windowId != null) this.windowId = windowId;
  }
  ExtensionGetViewsParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The type of view to get. If omitted, returns all views (including
   * background pages and tabs). Valid values: 'tab', 'notification', 'popup'.
   */
  ViewType get type => _createViewType(jsProxy['type']);
  set type(ViewType value) => jsProxy['type'] = jsify(value);

  /**
   * The window to restrict the search to. If omitted, returns all views.
   */
  int get windowId => jsProxy['windowId'];
  set windowId(int value) => jsProxy['windowId'] = value;
}

OnRequestEvent _createOnRequestEvent(JsObject request, JsObject sender, JsObject sendResponse) =>
    new OnRequestEvent(request, _createMessageSender(sender), sendResponse);
OnRequestExternalEvent _createOnRequestExternalEvent(JsObject request, JsObject sender, JsObject sendResponse) =>
    new OnRequestExternalEvent(request, _createMessageSender(sender), sendResponse);
LastErrorExtension _createLastErrorExtension(JsObject jsProxy) => jsProxy == null ? null : new LastErrorExtension.fromProxy(jsProxy);
Window _createWindow(JsObject jsProxy) => jsProxy == null ? null : new Window.fromProxy(jsProxy);
ViewType _createViewType(JsObject jsProxy) => jsProxy == null ? null : new ViewType.fromProxy(jsProxy);
MessageSender _createMessageSender(JsObject jsProxy) => jsProxy == null ? null : new MessageSender.fromProxy(jsProxy);
