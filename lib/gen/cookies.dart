/* This file has been generated from cookies.json - do not edit */

/**
 * Use the `chrome.cookies` API to query and modify cookies, and to be notified
 * when they change.
 */
library chrome.cookies;

import '../src/common.dart';

/**
 * Accessor for the `chrome.cookies` namespace.
 */
final ChromeCookies cookies = new ChromeCookies._();

class ChromeCookies extends ChromeApi {
  static final JsObject _cookies = chrome['cookies'];

  ChromeCookies._();

  bool get available => _cookies != null;

  /**
   * Retrieves information about a single cookie. If more than one cookie of the
   * same name exists for the given URL, the one with the longest path will be
   * returned. For cookies with the same path length, the cookie with the
   * earliest creation time will be returned.
   * 
   * [details] Details to identify the cookie being retrieved.
   * 
   * Returns:
   * Contains details about the cookie. This parameter is null if no such cookie
   * was found.
   */
  Future<Cookie> get(CookiesGetParams details) {
    if (_cookies == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Cookie>.oneArg(_createCookie);
    _cookies.callMethod('get', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Retrieves all cookies from a single cookie store that match the given
   * information.  The cookies returned will be sorted, with those with the
   * longest path first.  If multiple cookies have the same path length, those
   * with the earliest creation time will be first.
   * 
   * [details] Information to filter the cookies being retrieved.
   * 
   * Returns:
   * All the existing, unexpired cookies that match the given cookie info.
   */
  Future<List<Cookie>> getAll(CookiesGetAllParams details) {
    if (_cookies == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<Cookie>>.oneArg((e) => listify(e, _createCookie));
    _cookies.callMethod('getAll', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Sets a cookie with the given cookie data; may overwrite equivalent cookies
   * if they exist.
   * 
   * [details] Details about the cookie being set.
   * 
   * Returns:
   * Contains details about the cookie that's been set.  If setting failed for
   * any reason, this will be "null", and "chrome.runtime.lastError" will be
   * set.
   */
  Future<Cookie> set(CookiesSetParams details) {
    if (_cookies == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Cookie>.oneArg(_createCookie);
    _cookies.callMethod('set', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Deletes a cookie by name.
   * 
   * [details] Information to identify the cookie to remove.
   * 
   * Returns:
   * Contains details about the cookie that's been removed.  If removal failed
   * for any reason, this will be "null", and "chrome.runtime.lastError" will be
   * set.
   */
  Future<Map> remove(CookiesRemoveParams details) {
    if (_cookies == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Map>.oneArg(mapify);
    _cookies.callMethod('remove', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Lists all existing cookie stores.
   * 
   * Returns:
   * All the existing cookie stores.
   */
  Future<List<CookieStore>> getAllCookieStores() {
    if (_cookies == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<CookieStore>>.oneArg((e) => listify(e, _createCookieStore));
    _cookies.callMethod('getAllCookieStores', [completer.callback]);
    return completer.future;
  }

  /**
   * Fired when a cookie is set or removed. As a special case, note that
   * updating a cookie's properties is implemented as a two step process: the
   * cookie to be updated is first removed entirely, generating a notification
   * with "cause" of "overwrite" .  Afterwards, a new cookie is written with the
   * updated values, generating a second notification with "cause" "explicit".
   */
  Stream<Map> get onChanged => _onChanged.stream;

  final ChromeStreamController<Map> _onChanged =
      new ChromeStreamController<Map>.oneArg(_cookies, 'onChanged', mapify);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.cookies' is not available");
  }
}

/**
 * Represents information about an HTTP cookie.
 */
class Cookie extends ChromeObject {
  Cookie({String name, String value, String domain, bool hostOnly, String path, bool secure, bool httpOnly, bool session, var expirationDate, String storeId}) {
    if (name != null) this.name = name;
    if (value != null) this.value = value;
    if (domain != null) this.domain = domain;
    if (hostOnly != null) this.hostOnly = hostOnly;
    if (path != null) this.path = path;
    if (secure != null) this.secure = secure;
    if (httpOnly != null) this.httpOnly = httpOnly;
    if (session != null) this.session = session;
    if (expirationDate != null) this.expirationDate = expirationDate;
    if (storeId != null) this.storeId = storeId;
  }
  Cookie.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The name of the cookie.
   */
  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  /**
   * The value of the cookie.
   */
  String get value => jsProxy['value'];
  set value(String value) => jsProxy['value'] = value;

  /**
   * The domain of the cookie (e.g. "www.google.com", "example.com").
   */
  String get domain => jsProxy['domain'];
  set domain(String value) => jsProxy['domain'] = value;

  /**
   * True if the cookie is a host-only cookie (i.e. a request's host must
   * exactly match the domain of the cookie).
   */
  bool get hostOnly => jsProxy['hostOnly'];
  set hostOnly(bool value) => jsProxy['hostOnly'] = value;

  /**
   * The path of the cookie.
   */
  String get path => jsProxy['path'];
  set path(String value) => jsProxy['path'] = value;

  /**
   * True if the cookie is marked as Secure (i.e. its scope is limited to secure
   * channels, typically HTTPS).
   */
  bool get secure => jsProxy['secure'];
  set secure(bool value) => jsProxy['secure'] = value;

  /**
   * True if the cookie is marked as HttpOnly (i.e. the cookie is inaccessible
   * to client-side scripts).
   */
  bool get httpOnly => jsProxy['httpOnly'];
  set httpOnly(bool value) => jsProxy['httpOnly'] = value;

  /**
   * True if the cookie is a session cookie, as opposed to a persistent cookie
   * with an expiration date.
   */
  bool get session => jsProxy['session'];
  set session(bool value) => jsProxy['session'] = value;

  /**
   * The expiration date of the cookie as the number of seconds since the UNIX
   * epoch. Not provided for session cookies.
   */
  dynamic get expirationDate => jsProxy['expirationDate'];
  set expirationDate(var value) => jsProxy['expirationDate'] = jsify(value);

  /**
   * The ID of the cookie store containing this cookie, as provided in
   * getAllCookieStores().
   */
  String get storeId => jsProxy['storeId'];
  set storeId(String value) => jsProxy['storeId'] = value;
}

/**
 * Represents a cookie store in the browser. An incognito mode window, for
 * instance, uses a separate cookie store from a non-incognito window.
 */
class CookieStore extends ChromeObject {
  CookieStore({String id, List<int> tabIds}) {
    if (id != null) this.id = id;
    if (tabIds != null) this.tabIds = tabIds;
  }
  CookieStore.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The unique identifier for the cookie store.
   */
  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  /**
   * Identifiers of all the browser tabs that share this cookie store.
   */
  List<int> get tabIds => listify(jsProxy['tabIds']);
  set tabIds(List<int> value) => jsProxy['tabIds'] = jsify(value);
}

class CookiesGetParams extends ChromeObject {
  CookiesGetParams({String url, String name, String storeId}) {
    if (url != null) this.url = url;
    if (name != null) this.name = name;
    if (storeId != null) this.storeId = storeId;
  }
  CookiesGetParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The URL with which the cookie to retrieve is associated. This argument may
   * be a full URL, in which case any data following the URL path (e.g. the
   * query string) is simply ignored. If host permissions for this URL are not
   * specified in the manifest file, the API call will fail.
   */
  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;

  /**
   * The name of the cookie to retrieve.
   */
  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  /**
   * The ID of the cookie store in which to look for the cookie. By default, the
   * current execution context's cookie store will be used.
   */
  String get storeId => jsProxy['storeId'];
  set storeId(String value) => jsProxy['storeId'] = value;
}

class CookiesGetAllParams extends ChromeObject {
  CookiesGetAllParams({String url, String name, String domain, String path, bool secure, bool session, String storeId}) {
    if (url != null) this.url = url;
    if (name != null) this.name = name;
    if (domain != null) this.domain = domain;
    if (path != null) this.path = path;
    if (secure != null) this.secure = secure;
    if (session != null) this.session = session;
    if (storeId != null) this.storeId = storeId;
  }
  CookiesGetAllParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Restricts the retrieved cookies to those that would match the given URL.
   */
  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;

  /**
   * Filters the cookies by name.
   */
  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  /**
   * Restricts the retrieved cookies to those whose domains match or are
   * subdomains of this one.
   */
  String get domain => jsProxy['domain'];
  set domain(String value) => jsProxy['domain'] = value;

  /**
   * Restricts the retrieved cookies to those whose path exactly matches this
   * string.
   */
  String get path => jsProxy['path'];
  set path(String value) => jsProxy['path'] = value;

  /**
   * Filters the cookies by their Secure property.
   */
  bool get secure => jsProxy['secure'];
  set secure(bool value) => jsProxy['secure'] = value;

  /**
   * Filters out session vs. persistent cookies.
   */
  bool get session => jsProxy['session'];
  set session(bool value) => jsProxy['session'] = value;

  /**
   * The cookie store to retrieve cookies from. If omitted, the current
   * execution context's cookie store will be used.
   */
  String get storeId => jsProxy['storeId'];
  set storeId(String value) => jsProxy['storeId'] = value;
}

class CookiesSetParams extends ChromeObject {
  CookiesSetParams({String url, String name, String value, String domain, String path, bool secure, bool httpOnly, var expirationDate, String storeId}) {
    if (url != null) this.url = url;
    if (name != null) this.name = name;
    if (value != null) this.value = value;
    if (domain != null) this.domain = domain;
    if (path != null) this.path = path;
    if (secure != null) this.secure = secure;
    if (httpOnly != null) this.httpOnly = httpOnly;
    if (expirationDate != null) this.expirationDate = expirationDate;
    if (storeId != null) this.storeId = storeId;
  }
  CookiesSetParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The request-URI to associate with the setting of the cookie. This value can
   * affect the default domain and path values of the created cookie. If host
   * permissions for this URL are not specified in the manifest file, the API
   * call will fail.
   */
  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;

  /**
   * The name of the cookie. Empty by default if omitted.
   */
  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  /**
   * The value of the cookie. Empty by default if omitted.
   */
  String get value => jsProxy['value'];
  set value(String value) => jsProxy['value'] = value;

  /**
   * The domain of the cookie. If omitted, the cookie becomes a host-only
   * cookie.
   */
  String get domain => jsProxy['domain'];
  set domain(String value) => jsProxy['domain'] = value;

  /**
   * The path of the cookie. Defaults to the path portion of the url parameter.
   */
  String get path => jsProxy['path'];
  set path(String value) => jsProxy['path'] = value;

  /**
   * Whether the cookie should be marked as Secure. Defaults to false.
   */
  bool get secure => jsProxy['secure'];
  set secure(bool value) => jsProxy['secure'] = value;

  /**
   * Whether the cookie should be marked as HttpOnly. Defaults to false.
   */
  bool get httpOnly => jsProxy['httpOnly'];
  set httpOnly(bool value) => jsProxy['httpOnly'] = value;

  /**
   * The expiration date of the cookie as the number of seconds since the UNIX
   * epoch. If omitted, the cookie becomes a session cookie.
   */
  dynamic get expirationDate => jsProxy['expirationDate'];
  set expirationDate(var value) => jsProxy['expirationDate'] = jsify(value);

  /**
   * The ID of the cookie store in which to set the cookie. By default, the
   * cookie is set in the current execution context's cookie store.
   */
  String get storeId => jsProxy['storeId'];
  set storeId(String value) => jsProxy['storeId'] = value;
}

class CookiesRemoveParams extends ChromeObject {
  CookiesRemoveParams({String url, String name, String storeId}) {
    if (url != null) this.url = url;
    if (name != null) this.name = name;
    if (storeId != null) this.storeId = storeId;
  }
  CookiesRemoveParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The URL associated with the cookie. If host permissions for this URL are
   * not specified in the manifest file, the API call will fail.
   */
  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;

  /**
   * The name of the cookie to remove.
   */
  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  /**
   * The ID of the cookie store to look in for the cookie. If unspecified, the
   * cookie is looked for by default in the current execution context's cookie
   * store.
   */
  String get storeId => jsProxy['storeId'];
  set storeId(String value) => jsProxy['storeId'] = value;
}

Cookie _createCookie(JsObject jsProxy) => jsProxy == null ? null : new Cookie.fromProxy(jsProxy);
CookieStore _createCookieStore(JsObject jsProxy) => jsProxy == null ? null : new CookieStore.fromProxy(jsProxy);
