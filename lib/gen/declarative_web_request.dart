/* This file has been generated from declarative_web_request.json - do not edit */

/**
 * Use the `chrome.declarativeWebRequest` API to intercept, block, or modify
 * requests in-flight. It is significantly faster than the <a
 * href='webRequest.html'>`chrome.webRequest` API</a> because you can register
 * rules that are evaluated in the browser rather than the JavaScript engine
 * with reduces roundtrip latencies and allows higher efficiency.
 */
library chrome.declarativeWebRequest;

import 'events.dart';
import '../src/common.dart';

/**
 * Accessor for the `chrome.declarativeWebRequest` namespace.
 */
final ChromeDeclarativeWebRequest declarativeWebRequest = new ChromeDeclarativeWebRequest._();

class ChromeDeclarativeWebRequest extends ChromeApi {
  static final JsObject _declarativeWebRequest = chrome['declarativeWebRequest'];

  ChromeDeclarativeWebRequest._();

  bool get available => _declarativeWebRequest != null;

  Stream get onRequest => _onRequest.stream;

  final ChromeStreamController _onRequest =
      new ChromeStreamController.noArgs(_declarativeWebRequest, 'onRequest');

  /**
   * Fired when a message is sent via
   * [declarativeWebRequest.SendMessageToExtension] from an action of the
   * declarative web request API.
   */
  Stream<Map> get onMessage => _onMessage.stream;

  final ChromeStreamController<Map> _onMessage =
      new ChromeStreamController<Map>.oneArg(_declarativeWebRequest, 'onMessage', mapify);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.declarativeWebRequest' is not available");
  }
}

/**
 * Filters request headers for various criteria. Multiple criteria are evaluated
 * as a conjunction.
 */
class HeaderFilter extends ChromeObject {
  HeaderFilter({String namePrefix, String nameSuffix, var nameContains, String nameEquals, String valuePrefix, String valueSuffix, var valueContains, String valueEquals}) {
    if (namePrefix != null) this.namePrefix = namePrefix;
    if (nameSuffix != null) this.nameSuffix = nameSuffix;
    if (nameContains != null) this.nameContains = nameContains;
    if (nameEquals != null) this.nameEquals = nameEquals;
    if (valuePrefix != null) this.valuePrefix = valuePrefix;
    if (valueSuffix != null) this.valueSuffix = valueSuffix;
    if (valueContains != null) this.valueContains = valueContains;
    if (valueEquals != null) this.valueEquals = valueEquals;
  }
  HeaderFilter.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Matches if the header name starts with the specified string.
   */
  String get namePrefix => jsProxy['namePrefix'];
  set namePrefix(String value) => jsProxy['namePrefix'] = value;

  /**
   * Matches if the header name ends with the specified string.
   */
  String get nameSuffix => jsProxy['nameSuffix'];
  set nameSuffix(String value) => jsProxy['nameSuffix'] = value;

  /**
   * Matches if the header name contains all of the specified strings.
   */
  dynamic get nameContains => jsProxy['nameContains'];
  set nameContains(var value) => jsProxy['nameContains'] = jsify(value);

  /**
   * Matches if the header name is equal to the specified string.
   */
  String get nameEquals => jsProxy['nameEquals'];
  set nameEquals(String value) => jsProxy['nameEquals'] = value;

  /**
   * Matches if the header value starts with the specified string.
   */
  String get valuePrefix => jsProxy['valuePrefix'];
  set valuePrefix(String value) => jsProxy['valuePrefix'] = value;

  /**
   * Matches if the header value ends with the specified string.
   */
  String get valueSuffix => jsProxy['valueSuffix'];
  set valueSuffix(String value) => jsProxy['valueSuffix'] = value;

  /**
   * Matches if the header value contains all of the specified strings.
   */
  dynamic get valueContains => jsProxy['valueContains'];
  set valueContains(var value) => jsProxy['valueContains'] = jsify(value);

  /**
   * Matches if the header value is equal to the specified string.
   */
  String get valueEquals => jsProxy['valueEquals'];
  set valueEquals(String value) => jsProxy['valueEquals'] = value;
}

/**
 * Matches network events by various criteria.
 */
class RequestMatcher extends ChromeObject {
  RequestMatcher({UrlFilter url, UrlFilter firstPartyForCookiesUrl, List<String> resourceType, List<String> contentType, List<String> excludeContentType, List<HeaderFilter> requestHeaders, List<HeaderFilter> excludeRequestHeaders, List<HeaderFilter> responseHeaders, List<HeaderFilter> excludeResponseHeaders, bool thirdPartyForCookies, List<String> stages}) {
    if (url != null) this.url = url;
    if (firstPartyForCookiesUrl != null) this.firstPartyForCookiesUrl = firstPartyForCookiesUrl;
    if (resourceType != null) this.resourceType = resourceType;
    if (contentType != null) this.contentType = contentType;
    if (excludeContentType != null) this.excludeContentType = excludeContentType;
    if (requestHeaders != null) this.requestHeaders = requestHeaders;
    if (excludeRequestHeaders != null) this.excludeRequestHeaders = excludeRequestHeaders;
    if (responseHeaders != null) this.responseHeaders = responseHeaders;
    if (excludeResponseHeaders != null) this.excludeResponseHeaders = excludeResponseHeaders;
    if (thirdPartyForCookies != null) this.thirdPartyForCookies = thirdPartyForCookies;
    if (stages != null) this.stages = stages;
  }
  RequestMatcher.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Matches if the conditions of the UrlFilter are fulfilled for the URL of the
   * request.
   */
  UrlFilter get url => _createUrlFilter(jsProxy['url']);
  set url(UrlFilter value) => jsProxy['url'] = jsify(value);

  /**
   * Matches if the conditions of the UrlFilter are fulfilled for the 'first
   * party' URL of the request. The 'first party' URL of a request, when
   * present, can be different from the request's target URL, and describes what
   * is considered 'first party' for the sake of third-party checks for cookies.
   */
  UrlFilter get firstPartyForCookiesUrl => _createUrlFilter(jsProxy['firstPartyForCookiesUrl']);
  set firstPartyForCookiesUrl(UrlFilter value) => jsProxy['firstPartyForCookiesUrl'] = jsify(value);

  /**
   * Matches if the request type of a request is contained in the list. Requests
   * that cannot match any of the types will be filtered out.
   */
  List<String> get resourceType => listify(jsProxy['resourceType']);
  set resourceType(List<String> value) => jsProxy['resourceType'] = jsify(value);

  /**
   * Matches if the MIME media type of a response (from the HTTP Content-Type
   * header) is contained in the list.
   */
  List<String> get contentType => listify(jsProxy['contentType']);
  set contentType(List<String> value) => jsProxy['contentType'] = jsify(value);

  /**
   * Matches if the MIME media type of a response (from the HTTP Content-Type
   * header) is _not_ contained in the list.
   */
  List<String> get excludeContentType => listify(jsProxy['excludeContentType']);
  set excludeContentType(List<String> value) => jsProxy['excludeContentType'] = jsify(value);

  /**
   * Matches if some of the request headers is matched by one of the
   * HeaderFilters.
   */
  List<HeaderFilter> get requestHeaders => listify(jsProxy['requestHeaders'], _createHeaderFilter);
  set requestHeaders(List<HeaderFilter> value) => jsProxy['requestHeaders'] = jsify(value);

  /**
   * Matches if none of the request headers is matched by any of the
   * HeaderFilters.
   */
  List<HeaderFilter> get excludeRequestHeaders => listify(jsProxy['excludeRequestHeaders'], _createHeaderFilter);
  set excludeRequestHeaders(List<HeaderFilter> value) => jsProxy['excludeRequestHeaders'] = jsify(value);

  /**
   * Matches if some of the response headers is matched by one of the
   * HeaderFilters.
   */
  List<HeaderFilter> get responseHeaders => listify(jsProxy['responseHeaders'], _createHeaderFilter);
  set responseHeaders(List<HeaderFilter> value) => jsProxy['responseHeaders'] = jsify(value);

  /**
   * Matches if none of the response headers is matched by any of the
   * HeaderFilters.
   */
  List<HeaderFilter> get excludeResponseHeaders => listify(jsProxy['excludeResponseHeaders'], _createHeaderFilter);
  set excludeResponseHeaders(List<HeaderFilter> value) => jsProxy['excludeResponseHeaders'] = jsify(value);

  /**
   * If set to true, matches requests that are subject to third-party cookie
   * policies. If set to false, matches all other requests.
   */
  bool get thirdPartyForCookies => jsProxy['thirdPartyForCookies'];
  set thirdPartyForCookies(bool value) => jsProxy['thirdPartyForCookies'] = value;

  /**
   * Contains a list of strings describing stages. Allowed values are
   * 'onBeforeRequest', 'onBeforeSendHeaders', 'onHeadersReceived',
   * 'onAuthRequired'. If this attribute is present, then it limits the
   * applicable stages to those listed. Note that the whole condition is only
   * applicable in stages compatible with all attributes.
   */
  List<String> get stages => listify(jsProxy['stages']);
  set stages(List<String> value) => jsProxy['stages'] = jsify(value);
}

/**
 * Declarative event action that cancels a network request.
 */
class CancelRequest extends ChromeObject {
  CancelRequest();
  CancelRequest.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

/**
 * Declarative event action that redirects a network request.
 */
class RedirectRequest extends ChromeObject {
  RedirectRequest({String redirectUrl}) {
    if (redirectUrl != null) this.redirectUrl = redirectUrl;
  }
  RedirectRequest.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Destination to where the request is redirected.
   */
  String get redirectUrl => jsProxy['redirectUrl'];
  set redirectUrl(String value) => jsProxy['redirectUrl'] = value;
}

/**
 * Declarative event action that redirects a network request to a transparent
 * image.
 */
class RedirectToTransparentImage extends ChromeObject {
  RedirectToTransparentImage();
  RedirectToTransparentImage.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

/**
 * Declarative event action that redirects a network request to an empty
 * document.
 */
class RedirectToEmptyDocument extends ChromeObject {
  RedirectToEmptyDocument();
  RedirectToEmptyDocument.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

/**
 * Redirects a request by applying a regular expression on the URL. The regular
 * expressions use the [RE2 syntax](http://code.google.com/p/re2/wiki/Syntax).
 */
class RedirectByRegEx extends ChromeObject {
  RedirectByRegEx({String from, String to}) {
    if (from != null) this.from = from;
    if (to != null) this.to = to;
  }
  RedirectByRegEx.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * A match pattern that may contain capture groups. Capture groups are
   * referenced in the Perl syntax ($1, $2, ...) instead of the RE2 syntax (\1,
   * \2, ...) in order to be closer to JavaScript Regular Expressions.
   */
  String get from => jsProxy['from'];
  set from(String value) => jsProxy['from'] = value;

  /**
   * Destination pattern.
   */
  String get to => jsProxy['to'];
  set to(String value) => jsProxy['to'] = value;
}

/**
 * Sets the request header of the specified name to the specified value. If a
 * header with the specified name did not exist before, a new one is created.
 * Header name comparison is always case-insensitive. Each request header name
 * occurs only once in each request.
 */
class SetRequestHeader extends ChromeObject {
  SetRequestHeader({String name, String value}) {
    if (name != null) this.name = name;
    if (value != null) this.value = value;
  }
  SetRequestHeader.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * HTTP request header name.
   */
  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  /**
   * HTTP request header value.
   */
  String get value => jsProxy['value'];
  set value(String value) => jsProxy['value'] = value;
}

/**
 * Removes the request header of the specified name. Do not use SetRequestHeader
 * and RemoveRequestHeader with the same header name on the same request. Each
 * request header name occurs only once in each request.
 */
class RemoveRequestHeader extends ChromeObject {
  RemoveRequestHeader({String name}) {
    if (name != null) this.name = name;
  }
  RemoveRequestHeader.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * HTTP request header name (case-insensitive).
   */
  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;
}

/**
 * Adds the response header to the response of this web request. As multiple
 * response headers may share the same name, you need to first remove and then
 * add a new response header in order to replace one.
 */
class AddResponseHeader extends ChromeObject {
  AddResponseHeader({String name, String value}) {
    if (name != null) this.name = name;
    if (value != null) this.value = value;
  }
  AddResponseHeader.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * HTTP response header name.
   */
  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  /**
   * HTTP response header value.
   */
  String get value => jsProxy['value'];
  set value(String value) => jsProxy['value'] = value;
}

/**
 * Removes all response headers of the specified names and values.
 */
class RemoveResponseHeader extends ChromeObject {
  RemoveResponseHeader({String name, String value}) {
    if (name != null) this.name = name;
    if (value != null) this.value = value;
  }
  RemoveResponseHeader.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * HTTP request header name (case-insensitive).
   */
  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  /**
   * HTTP request header value (case-insensitive).
   */
  String get value => jsProxy['value'];
  set value(String value) => jsProxy['value'] = value;
}

/**
 * Masks all rules that match the specified criteria.
 */
class IgnoreRules extends ChromeObject {
  IgnoreRules({int lowerPriorityThan, String hasTag}) {
    if (lowerPriorityThan != null) this.lowerPriorityThan = lowerPriorityThan;
    if (hasTag != null) this.hasTag = hasTag;
  }
  IgnoreRules.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * If set, rules with a lower priority than the specified value are ignored.
   * This boundary is not persisted, it affects only rules and their actions of
   * the same network request stage.
   */
  int get lowerPriorityThan => jsProxy['lowerPriorityThan'];
  set lowerPriorityThan(int value) => jsProxy['lowerPriorityThan'] = value;

  /**
   * If set, rules with the specified tag are ignored. This ignoring is not
   * persisted, it affects only rules and their actions of the same network
   * request stage. Note that rules are executed in descending order of their
   * priorities. This action affects rules of lower priority than the current
   * rule. Rules with the same priority may or may not be ignored.
   */
  String get hasTag => jsProxy['hasTag'];
  set hasTag(String value) => jsProxy['hasTag'] = value;
}

/**
 * Triggers the [declarativeWebRequest.onMessage] event.
 */
class SendMessageToExtension extends ChromeObject {
  SendMessageToExtension({String message}) {
    if (message != null) this.message = message;
  }
  SendMessageToExtension.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The value that will be passed in the `message` attribute of the dictionary
   * that is passed to the event handler.
   */
  String get message => jsProxy['message'];
  set message(String value) => jsProxy['message'] = value;
}

/**
 * A filter or specification of a cookie in HTTP Requests.
 */
class RequestCookie extends ChromeObject {
  RequestCookie({String name, String value}) {
    if (name != null) this.name = name;
    if (value != null) this.value = value;
  }
  RequestCookie.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Name of a cookie.
   */
  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  /**
   * Value of a cookie, may be padded in double-quotes.
   */
  String get value => jsProxy['value'];
  set value(String value) => jsProxy['value'] = value;
}

/**
 * A specification of a cookie in HTTP Responses.
 */
class ResponseCookie extends ChromeObject {
  ResponseCookie({String name, String value, String expires, var maxAge, String domain, String path, String secure, String httpOnly}) {
    if (name != null) this.name = name;
    if (value != null) this.value = value;
    if (expires != null) this.expires = expires;
    if (maxAge != null) this.maxAge = maxAge;
    if (domain != null) this.domain = domain;
    if (path != null) this.path = path;
    if (secure != null) this.secure = secure;
    if (httpOnly != null) this.httpOnly = httpOnly;
  }
  ResponseCookie.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Name of a cookie.
   */
  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  /**
   * Value of a cookie, may be padded in double-quotes.
   */
  String get value => jsProxy['value'];
  set value(String value) => jsProxy['value'] = value;

  /**
   * Value of the Expires cookie attribute.
   */
  String get expires => jsProxy['expires'];
  set expires(String value) => jsProxy['expires'] = value;

  /**
   * Value of the Max-Age cookie attribute
   */
  dynamic get maxAge => jsProxy['maxAge'];
  set maxAge(var value) => jsProxy['maxAge'] = jsify(value);

  /**
   * Value of the Domain cookie attribute.
   */
  String get domain => jsProxy['domain'];
  set domain(String value) => jsProxy['domain'] = value;

  /**
   * Value of the Path cookie attribute.
   */
  String get path => jsProxy['path'];
  set path(String value) => jsProxy['path'] = value;

  /**
   * Existence of the Secure cookie attribute.
   */
  String get secure => jsProxy['secure'];
  set secure(String value) => jsProxy['secure'] = value;

  /**
   * Existence of the HttpOnly cookie attribute.
   */
  String get httpOnly => jsProxy['httpOnly'];
  set httpOnly(String value) => jsProxy['httpOnly'] = value;
}

/**
 * A filter of a cookie in HTTP Responses.
 */
class FilterResponseCookie extends ChromeObject {
  FilterResponseCookie({String name, String value, String expires, var maxAge, String domain, String path, String secure, String httpOnly, int ageUpperBound, int ageLowerBound, bool sessionCookie}) {
    if (name != null) this.name = name;
    if (value != null) this.value = value;
    if (expires != null) this.expires = expires;
    if (maxAge != null) this.maxAge = maxAge;
    if (domain != null) this.domain = domain;
    if (path != null) this.path = path;
    if (secure != null) this.secure = secure;
    if (httpOnly != null) this.httpOnly = httpOnly;
    if (ageUpperBound != null) this.ageUpperBound = ageUpperBound;
    if (ageLowerBound != null) this.ageLowerBound = ageLowerBound;
    if (sessionCookie != null) this.sessionCookie = sessionCookie;
  }
  FilterResponseCookie.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Name of a cookie.
   */
  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  /**
   * Value of a cookie, may be padded in double-quotes.
   */
  String get value => jsProxy['value'];
  set value(String value) => jsProxy['value'] = value;

  /**
   * Value of the Expires cookie attribute.
   */
  String get expires => jsProxy['expires'];
  set expires(String value) => jsProxy['expires'] = value;

  /**
   * Value of the Max-Age cookie attribute
   */
  dynamic get maxAge => jsProxy['maxAge'];
  set maxAge(var value) => jsProxy['maxAge'] = jsify(value);

  /**
   * Value of the Domain cookie attribute.
   */
  String get domain => jsProxy['domain'];
  set domain(String value) => jsProxy['domain'] = value;

  /**
   * Value of the Path cookie attribute.
   */
  String get path => jsProxy['path'];
  set path(String value) => jsProxy['path'] = value;

  /**
   * Existence of the Secure cookie attribute.
   */
  String get secure => jsProxy['secure'];
  set secure(String value) => jsProxy['secure'] = value;

  /**
   * Existence of the HttpOnly cookie attribute.
   */
  String get httpOnly => jsProxy['httpOnly'];
  set httpOnly(String value) => jsProxy['httpOnly'] = value;

  /**
   * Inclusive upper bound on the cookie lifetime (specified in seconds after
   * current time). Only cookies whose expiration date-time is in the interval
   * [now, now + ageUpperBound] fulfill this criterion. Session cookies and
   * cookies whose expiration date-time is in the past do not meet the criterion
   * of this filter. The cookie lifetime is calculated from either 'max-age' or
   * 'expires' cookie attributes. If both are specified, 'max-age' is used to
   * calculate the cookie lifetime.
   */
  int get ageUpperBound => jsProxy['ageUpperBound'];
  set ageUpperBound(int value) => jsProxy['ageUpperBound'] = value;

  /**
   * Inclusive lower bound on the cookie lifetime (specified in seconds after
   * current time). Only cookies whose expiration date-time is set to 'now +
   * ageLowerBound' or later fulfill this criterion. Session cookies do not meet
   * the criterion of this filter. The cookie lifetime is calculated from either
   * 'max-age' or 'expires' cookie attributes. If both are specified, 'max-age'
   * is used to calculate the cookie lifetime.
   */
  int get ageLowerBound => jsProxy['ageLowerBound'];
  set ageLowerBound(int value) => jsProxy['ageLowerBound'] = value;

  /**
   * Filters session cookies. Session cookies have no lifetime specified in any
   * of 'max-age' or 'expires' attributes.
   */
  bool get sessionCookie => jsProxy['sessionCookie'];
  set sessionCookie(bool value) => jsProxy['sessionCookie'] = value;
}

/**
 * Adds a cookie to the request or overrides a cookie, in case another cookie of
 * the same name exists already. Note that it is preferred to use the Cookies
 * API because this is computationally less expensive.
 */
class AddRequestCookie extends ChromeObject {
  AddRequestCookie({RequestCookie cookie}) {
    if (cookie != null) this.cookie = cookie;
  }
  AddRequestCookie.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Cookie to be added to the request. No field may be undefined.
   */
  RequestCookie get cookie => _createRequestCookie(jsProxy['cookie']);
  set cookie(RequestCookie value) => jsProxy['cookie'] = jsify(value);
}

/**
 * Adds a cookie to the response or overrides a cookie, in case another cookie
 * of the same name exists already. Note that it is preferred to use the Cookies
 * API because this is computationally less expensive.
 */
class AddResponseCookie extends ChromeObject {
  AddResponseCookie({ResponseCookie cookie}) {
    if (cookie != null) this.cookie = cookie;
  }
  AddResponseCookie.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Cookie to be added to the response. The name and value need to be
   * specified.
   */
  ResponseCookie get cookie => _createResponseCookie(jsProxy['cookie']);
  set cookie(ResponseCookie value) => jsProxy['cookie'] = jsify(value);
}

/**
 * Edits one or more cookies of request. Note that it is preferred to use the
 * Cookies API because this is computationally less expensive.
 */
class EditRequestCookie extends ChromeObject {
  EditRequestCookie({RequestCookie filter, RequestCookie modification}) {
    if (filter != null) this.filter = filter;
    if (modification != null) this.modification = modification;
  }
  EditRequestCookie.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Filter for cookies that will be modified. All empty entries are ignored.
   */
  RequestCookie get filter => _createRequestCookie(jsProxy['filter']);
  set filter(RequestCookie value) => jsProxy['filter'] = jsify(value);

  /**
   * Attributes that shall be overridden in cookies that machted the filter.
   * Attributes that are set to an empty string are removed.
   */
  RequestCookie get modification => _createRequestCookie(jsProxy['modification']);
  set modification(RequestCookie value) => jsProxy['modification'] = jsify(value);
}

/**
 * Edits one or more cookies of response. Note that it is preferred to use the
 * Cookies API because this is computationally less expensive.
 */
class EditResponseCookie extends ChromeObject {
  EditResponseCookie({FilterResponseCookie filter, ResponseCookie modification}) {
    if (filter != null) this.filter = filter;
    if (modification != null) this.modification = modification;
  }
  EditResponseCookie.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Filter for cookies that will be modified. All empty entries are ignored.
   */
  FilterResponseCookie get filter => _createFilterResponseCookie(jsProxy['filter']);
  set filter(FilterResponseCookie value) => jsProxy['filter'] = jsify(value);

  /**
   * Attributes that shall be overridden in cookies that machted the filter.
   * Attributes that are set to an empty string are removed.
   */
  ResponseCookie get modification => _createResponseCookie(jsProxy['modification']);
  set modification(ResponseCookie value) => jsProxy['modification'] = jsify(value);
}

/**
 * Removes one or more cookies of request. Note that it is preferred to use the
 * Cookies API because this is computationally less expensive.
 */
class RemoveRequestCookie extends ChromeObject {
  RemoveRequestCookie({RequestCookie filter}) {
    if (filter != null) this.filter = filter;
  }
  RemoveRequestCookie.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Filter for cookies that will be removed. All empty entries are ignored.
   */
  RequestCookie get filter => _createRequestCookie(jsProxy['filter']);
  set filter(RequestCookie value) => jsProxy['filter'] = jsify(value);
}

/**
 * Removes one or more cookies of response. Note that it is preferred to use the
 * Cookies API because this is computationally less expensive.
 */
class RemoveResponseCookie extends ChromeObject {
  RemoveResponseCookie({FilterResponseCookie filter}) {
    if (filter != null) this.filter = filter;
  }
  RemoveResponseCookie.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Filter for cookies that will be removed. All empty entries are ignored.
   */
  FilterResponseCookie get filter => _createFilterResponseCookie(jsProxy['filter']);
  set filter(FilterResponseCookie value) => jsProxy['filter'] = jsify(value);
}

UrlFilter _createUrlFilter(JsObject jsProxy) => jsProxy == null ? null : new UrlFilter.fromProxy(jsProxy);
HeaderFilter _createHeaderFilter(JsObject jsProxy) => jsProxy == null ? null : new HeaderFilter.fromProxy(jsProxy);
RequestCookie _createRequestCookie(JsObject jsProxy) => jsProxy == null ? null : new RequestCookie.fromProxy(jsProxy);
ResponseCookie _createResponseCookie(JsObject jsProxy) => jsProxy == null ? null : new ResponseCookie.fromProxy(jsProxy);
FilterResponseCookie _createFilterResponseCookie(JsObject jsProxy) => jsProxy == null ? null : new FilterResponseCookie.fromProxy(jsProxy);
