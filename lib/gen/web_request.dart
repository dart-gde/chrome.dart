/* This file has been generated from web_request.json - do not edit */

/**
 * Use the `chrome.webRequest` API to observe and analyze traffic and to
 * intercept, block, or modify requests in-flight.
 */
library chrome.webRequest;

import '../src/common.dart';

/**
 * Accessor for the `chrome.webRequest` namespace.
 */
final ChromeWebRequest webRequest = new ChromeWebRequest._();

class ChromeWebRequest extends ChromeApi {
  JsObject get _webRequest => chrome['webRequest'];

  /**
   * Fired when a request is about to occur.
   */
  Stream<Map> get onBeforeRequest => _onBeforeRequest.stream;
  ChromeStreamController<Map> _onBeforeRequest;

  /**
   * Fired before sending an HTTP request, once the request headers are
   * available. This may occur after a TCP connection is made to the server, but
   * before any HTTP data is sent.
   */
  Stream<Map> get onBeforeSendHeaders => _onBeforeSendHeaders.stream;
  ChromeStreamController<Map> _onBeforeSendHeaders;

  /**
   * Fired just before a request is going to be sent to the server
   * (modifications of previous onBeforeSendHeaders callbacks are visible by the
   * time onSendHeaders is fired).
   */
  Stream<Map> get onSendHeaders => _onSendHeaders.stream;
  ChromeStreamController<Map> _onSendHeaders;

  /**
   * Fired when HTTP response headers of a request have been received.
   */
  Stream<Map> get onHeadersReceived => _onHeadersReceived.stream;
  ChromeStreamController<Map> _onHeadersReceived;

  /**
   * Fired when an authentication failure is received. The listener has three
   * options: it can provide authentication credentials, it can cancel the
   * request and display the error page, or it can take no action on the
   * challenge. If bad user credentials are provided, this may be called
   * multiple times for the same request. Note, only one of `'blocking'` or
   * `'asyncBlocking'` modes must be specified in the `extraInfoSpec` parameter.
   */
  Stream<OnAuthRequiredEvent> get onAuthRequired => _onAuthRequired.stream;
  ChromeStreamController<OnAuthRequiredEvent> _onAuthRequired;

  /**
   * Fired when the first byte of the response body is received. For HTTP
   * requests, this means that the status line and response headers are
   * available.
   */
  Stream<Map> get onResponseStarted => _onResponseStarted.stream;
  ChromeStreamController<Map> _onResponseStarted;

  /**
   * Fired when a server-initiated redirect is about to occur.
   */
  Stream<Map> get onBeforeRedirect => _onBeforeRedirect.stream;
  ChromeStreamController<Map> _onBeforeRedirect;

  /**
   * Fired when a request is completed.
   */
  Stream<Map> get onCompleted => _onCompleted.stream;
  ChromeStreamController<Map> _onCompleted;

  /**
   * Fired when an error occurs.
   */
  Stream<Map> get onErrorOccurred => _onErrorOccurred.stream;
  ChromeStreamController<Map> _onErrorOccurred;

  ChromeWebRequest._() {
    var getApi = () => _webRequest;
    _onBeforeRequest = new ChromeStreamController<Map>.oneArg(getApi, 'onBeforeRequest', mapify);
    _onBeforeSendHeaders = new ChromeStreamController<Map>.oneArg(getApi, 'onBeforeSendHeaders', mapify);
    _onSendHeaders = new ChromeStreamController<Map>.oneArg(getApi, 'onSendHeaders', mapify);
    _onHeadersReceived = new ChromeStreamController<Map>.oneArg(getApi, 'onHeadersReceived', mapify);
    _onAuthRequired = new ChromeStreamController<OnAuthRequiredEvent>.twoArgs(getApi, 'onAuthRequired', _createOnAuthRequiredEvent);
    _onResponseStarted = new ChromeStreamController<Map>.oneArg(getApi, 'onResponseStarted', mapify);
    _onBeforeRedirect = new ChromeStreamController<Map>.oneArg(getApi, 'onBeforeRedirect', mapify);
    _onCompleted = new ChromeStreamController<Map>.oneArg(getApi, 'onCompleted', mapify);
    _onErrorOccurred = new ChromeStreamController<Map>.oneArg(getApi, 'onErrorOccurred', mapify);
  }

  bool get available => _webRequest != null;

  /**
   * The maximum number of times that `handlerBehaviorChanged` can be called per
   * 10 minute sustained interval. `handlerBehaviorChanged` is an expensive
   * function call that shouldn't be called often.
   */
  int get MAX_HANDLER_BEHAVIOR_CHANGED_CALLS_PER_10_MINUTES => _webRequest['MAX_HANDLER_BEHAVIOR_CHANGED_CALLS_PER_10_MINUTES'];

  /**
   * Needs to be called when the behavior of the webRequest handlers has changed
   * to prevent incorrect handling due to caching. This function call is
   * expensive. Don't call it often.
   */
  Future handlerBehaviorChanged() {
    if (_webRequest == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _webRequest.callMethod('handlerBehaviorChanged', [completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.webRequest' is not available");
  }
}

/**
 * Fired when an authentication failure is received. The listener has three
 * options: it can provide authentication credentials, it can cancel the request
 * and display the error page, or it can take no action on the challenge. If bad
 * user credentials are provided, this may be called multiple times for the same
 * request. Note, only one of `'blocking'` or `'asyncBlocking'` modes must be
 * specified in the `extraInfoSpec` parameter.
 */
class OnAuthRequiredEvent {
  final Map details;

  /**
   * Only valid if `'asyncBlocking'` is specified as one of the
   * `OnAuthRequiredOptions`.
   * `optional`
   * 
   * Only valid if `'asyncBlocking'` is specified as one of the
   * `OnAuthRequiredOptions`.
   */
  final dynamic asyncCallback;

  OnAuthRequiredEvent(this.details, this.asyncCallback);
}

class ResourceType extends ChromeEnum {
  static const ResourceType MAIN_FRAME = const ResourceType._('main_frame');
  static const ResourceType SUB_FRAME = const ResourceType._('sub_frame');
  static const ResourceType STYLESHEET = const ResourceType._('stylesheet');
  static const ResourceType SCRIPT = const ResourceType._('script');
  static const ResourceType IMAGE = const ResourceType._('image');
  static const ResourceType FONT = const ResourceType._('font');
  static const ResourceType OBJECT = const ResourceType._('object');
  static const ResourceType XMLHTTPREQUEST = const ResourceType._('xmlhttprequest');
  static const ResourceType PING = const ResourceType._('ping');
  static const ResourceType CSP_REPORT = const ResourceType._('csp_report');
  static const ResourceType MEDIA = const ResourceType._('media');
  static const ResourceType WEBSOCKET = const ResourceType._('websocket');
  static const ResourceType OTHER = const ResourceType._('other');

  static const List<ResourceType> VALUES = const[MAIN_FRAME, SUB_FRAME, STYLESHEET, SCRIPT, IMAGE, FONT, OBJECT, XMLHTTPREQUEST, PING, CSP_REPORT, MEDIA, WEBSOCKET, OTHER];

  const ResourceType._(String str): super(str);
}

class OnBeforeRequestOptions extends ChromeEnum {
  static const OnBeforeRequestOptions BLOCKING = const OnBeforeRequestOptions._('blocking');
  static const OnBeforeRequestOptions REQUEST_BODY = const OnBeforeRequestOptions._('requestBody');

  static const List<OnBeforeRequestOptions> VALUES = const[BLOCKING, REQUEST_BODY];

  const OnBeforeRequestOptions._(String str): super(str);
}

class OnBeforeSendHeadersOptions extends ChromeEnum {
  static const OnBeforeSendHeadersOptions REQUEST_HEADERS = const OnBeforeSendHeadersOptions._('requestHeaders');
  static const OnBeforeSendHeadersOptions BLOCKING = const OnBeforeSendHeadersOptions._('blocking');

  static const List<OnBeforeSendHeadersOptions> VALUES = const[REQUEST_HEADERS, BLOCKING];

  const OnBeforeSendHeadersOptions._(String str): super(str);
}

class OnSendHeadersOptions extends ChromeEnum {
  static const OnSendHeadersOptions REQUEST_HEADERS = const OnSendHeadersOptions._('requestHeaders');

  static const List<OnSendHeadersOptions> VALUES = const[REQUEST_HEADERS];

  const OnSendHeadersOptions._(String str): super(str);
}

class OnHeadersReceivedOptions extends ChromeEnum {
  static const OnHeadersReceivedOptions BLOCKING = const OnHeadersReceivedOptions._('blocking');
  static const OnHeadersReceivedOptions RESPONSE_HEADERS = const OnHeadersReceivedOptions._('responseHeaders');

  static const List<OnHeadersReceivedOptions> VALUES = const[BLOCKING, RESPONSE_HEADERS];

  const OnHeadersReceivedOptions._(String str): super(str);
}

class OnAuthRequiredOptions extends ChromeEnum {
  static const OnAuthRequiredOptions RESPONSE_HEADERS = const OnAuthRequiredOptions._('responseHeaders');
  static const OnAuthRequiredOptions BLOCKING = const OnAuthRequiredOptions._('blocking');
  static const OnAuthRequiredOptions ASYNC_BLOCKING = const OnAuthRequiredOptions._('asyncBlocking');

  static const List<OnAuthRequiredOptions> VALUES = const[RESPONSE_HEADERS, BLOCKING, ASYNC_BLOCKING];

  const OnAuthRequiredOptions._(String str): super(str);
}

class OnResponseStartedOptions extends ChromeEnum {
  static const OnResponseStartedOptions RESPONSE_HEADERS = const OnResponseStartedOptions._('responseHeaders');

  static const List<OnResponseStartedOptions> VALUES = const[RESPONSE_HEADERS];

  const OnResponseStartedOptions._(String str): super(str);
}

class OnBeforeRedirectOptions extends ChromeEnum {
  static const OnBeforeRedirectOptions RESPONSE_HEADERS = const OnBeforeRedirectOptions._('responseHeaders');

  static const List<OnBeforeRedirectOptions> VALUES = const[RESPONSE_HEADERS];

  const OnBeforeRedirectOptions._(String str): super(str);
}

class OnCompletedOptions extends ChromeEnum {
  static const OnCompletedOptions RESPONSE_HEADERS = const OnCompletedOptions._('responseHeaders');

  static const List<OnCompletedOptions> VALUES = const[RESPONSE_HEADERS];

  const OnCompletedOptions._(String str): super(str);
}

class AuthCredentialsWebRequest extends ChromeObject {
  AuthCredentialsWebRequest({String username, String password}) {
    if (username != null) this.username = username;
    if (password != null) this.password = password;
  }
  AuthCredentialsWebRequest.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get username => jsProxy['username'];
  set username(String value) => jsProxy['username'] = value;

  String get password => jsProxy['password'];
  set password(String value) => jsProxy['password'] = value;
}

/**
 * An object describing filters to apply to webRequest events.
 */
class RequestFilter extends ChromeObject {
  RequestFilter({List<String> urls, List<ResourceType> types, int tabId, int windowId}) {
    if (urls != null) this.urls = urls;
    if (types != null) this.types = types;
    if (tabId != null) this.tabId = tabId;
    if (windowId != null) this.windowId = windowId;
  }
  RequestFilter.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * A list of URLs or URL patterns. Requests that cannot match any of the URLs
   * will be filtered out.
   */
  List<String> get urls => listify(jsProxy['urls']);
  set urls(List<String> value) => jsProxy['urls'] = jsify(value);

  /**
   * A list of request types. Requests that cannot match any of the types will
   * be filtered out.
   */
  List<ResourceType> get types => listify(jsProxy['types'], _createResourceType);
  set types(List<ResourceType> value) => jsProxy['types'] = jsify(value);

  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;

  int get windowId => jsProxy['windowId'];
  set windowId(int value) => jsProxy['windowId'] = value;
}

/**
 * An array of HTTP headers. Each header is represented as a dictionary
 * containing the keys `name` and either `value` or `binaryValue`.
 */
class HttpHeaders extends ChromeObject {
  HttpHeaders();
  HttpHeaders.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

/**
 * Returns value for event handlers that have the 'blocking' extraInfoSpec
 * applied. Allows the event handler to modify network requests.
 */
class BlockingResponse extends ChromeObject {
  BlockingResponse({bool cancel, String redirectUrl, HttpHeaders requestHeaders, HttpHeaders responseHeaders, AuthCredentialsWebRequest authCredentials}) {
    if (cancel != null) this.cancel = cancel;
    if (redirectUrl != null) this.redirectUrl = redirectUrl;
    if (requestHeaders != null) this.requestHeaders = requestHeaders;
    if (responseHeaders != null) this.responseHeaders = responseHeaders;
    if (authCredentials != null) this.authCredentials = authCredentials;
  }
  BlockingResponse.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * If true, the request is cancelled. This prevents the request from being
   * sent. This can be used as a response to the onBeforeRequest,
   * onBeforeSendHeaders, onHeadersReceived and onAuthRequired events.
   */
  bool get cancel => jsProxy['cancel'];
  set cancel(bool value) => jsProxy['cancel'] = value;

  /**
   * Only used as a response to the onBeforeRequest and onHeadersReceived
   * events. If set, the original request is prevented from being sent/completed
   * and is instead redirected to the given URL. Redirections to non-HTTP
   * schemes such as `data:` are allowed. Redirects initiated by a redirect
   * action use the original request method for the redirect, with one
   * exception: If the redirect is initiated at the onHeadersReceived stage,
   * then the redirect will be issued using the GET method. Redirects from URLs
   * with `ws://` and `wss://` schemes are <b>ignored</b>.
   */
  String get redirectUrl => jsProxy['redirectUrl'];
  set redirectUrl(String value) => jsProxy['redirectUrl'] = value;

  /**
   * Only used as a response to the onBeforeSendHeaders event. If set, the
   * request is made with these request headers instead.
   */
  HttpHeaders get requestHeaders => _createHttpHeaders(jsProxy['requestHeaders']);
  set requestHeaders(HttpHeaders value) => jsProxy['requestHeaders'] = jsify(value);

  /**
   * Only used as a response to the onHeadersReceived event. If set, the server
   * is assumed to have responded with these response headers instead. Only
   * return `responseHeaders` if you really want to modify the headers in order
   * to limit the number of conflicts (only one extension may modify
   * `responseHeaders` for each request).
   */
  HttpHeaders get responseHeaders => _createHttpHeaders(jsProxy['responseHeaders']);
  set responseHeaders(HttpHeaders value) => jsProxy['responseHeaders'] = jsify(value);

  /**
   * Only used as a response to the onAuthRequired event. If set, the request is
   * made using the supplied credentials.
   */
  AuthCredentialsWebRequest get authCredentials => _createAuthCredentialsWebRequest(jsProxy['authCredentials']);
  set authCredentials(AuthCredentialsWebRequest value) => jsProxy['authCredentials'] = jsify(value);
}

/**
 * Contains data uploaded in a URL request.
 */
class UploadData extends ChromeObject {
  UploadData({var bytes, String file}) {
    if (bytes != null) this.bytes = bytes;
    if (file != null) this.file = file;
  }
  UploadData.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * An ArrayBuffer with a copy of the data.
   */
  dynamic get bytes => jsProxy['bytes'];
  set bytes(var value) => jsProxy['bytes'] = jsify(value);

  /**
   * A string with the file's path and name.
   */
  String get file => jsProxy['file'];
  set file(String value) => jsProxy['file'] = value;
}

/**
 * Contains data passed within form data. For urlencoded form it is stored as
 * string if data is utf-8 string and as ArrayBuffer otherwise. For form-data it
 * is ArrayBuffer. If form-data represents uploading file, it is string with
 * filename, if the filename is provided.
 */
class FormDataItem extends ChromeObject {
  FormDataItem();
  FormDataItem.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

class RequestBodyWebRequest extends ChromeObject {
  RequestBodyWebRequest({String error, Map formData, List<UploadData> raw}) {
    if (error != null) this.error = error;
    if (formData != null) this.formData = formData;
    if (raw != null) this.raw = raw;
  }
  RequestBodyWebRequest.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Errors when obtaining request body data.
   */
  String get error => jsProxy['error'];
  set error(String value) => jsProxy['error'] = value;

  /**
   * If the request method is POST and the body is a sequence of key-value pairs
   * encoded in UTF8, encoded as either multipart/form-data, or
   * application/x-www-form-urlencoded, this dictionary is present and for each
   * key contains the list of all values for that key. If the data is of another
   * media type, or if it is malformed, the dictionary is not present. An
   * example value of this dictionary is {'key': ['value1', 'value2']}.
   */
  Map get formData => mapify(jsProxy['formData']);
  set formData(Map value) => jsProxy['formData'] = jsify(value);

  /**
   * If the request method is PUT or POST, and the body is not already parsed in
   * formData, then the unparsed request body elements are contained in this
   * array.
   */
  List<UploadData> get raw => listify(jsProxy['raw'], _createUploadData);
  set raw(List<UploadData> value) => jsProxy['raw'] = jsify(value);
}

class ChallengerWebRequest extends ChromeObject {
  ChallengerWebRequest({String host, int port}) {
    if (host != null) this.host = host;
    if (port != null) this.port = port;
  }
  ChallengerWebRequest.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get host => jsProxy['host'];
  set host(String value) => jsProxy['host'] = value;

  int get port => jsProxy['port'];
  set port(int value) => jsProxy['port'] = value;
}

OnAuthRequiredEvent _createOnAuthRequiredEvent(JsObject details, JsObject asyncCallback) =>
    new OnAuthRequiredEvent(mapify(details), asyncCallback);
ResourceType _createResourceType(String value) => ResourceType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
HttpHeaders _createHttpHeaders(JsObject jsProxy) => jsProxy == null ? null : new HttpHeaders.fromProxy(jsProxy);
AuthCredentialsWebRequest _createAuthCredentialsWebRequest(JsObject jsProxy) => jsProxy == null ? null : new AuthCredentialsWebRequest.fromProxy(jsProxy);
UploadData _createUploadData(JsObject jsProxy) => jsProxy == null ? null : new UploadData.fromProxy(jsProxy);
