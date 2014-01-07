/* This file has been generated from declarative_content.json - do not edit */

/**
 * Use the `chrome.declarativeContent` API to take actions depending on the
 * content of a page, without requiring permission to read the page's content.
 */
library chrome.declarativeContent;

import 'events.dart';
import '../src/common.dart';

/**
 * Accessor for the `chrome.declarativeContent` namespace.
 */
final ChromeDeclarativeContent declarativeContent = new ChromeDeclarativeContent._();

class ChromeDeclarativeContent extends ChromeApi {
  static final JsObject _declarativeContent = chrome['declarativeContent'];

  ChromeDeclarativeContent._();

  bool get available => _declarativeContent != null;

  Stream get onPageChanged => _onPageChanged.stream;

  final ChromeStreamController _onPageChanged =
      new ChromeStreamController.noArgs(_declarativeContent, 'onPageChanged');

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.declarativeContent' is not available");
  }
}

/**
 * Matches the state of a web page by various criteria.
 */
class PageStateMatcher extends ChromeObject {
  PageStateMatcher({UrlFilter pageUrl, List<String> css}) {
    if (pageUrl != null) this.pageUrl = pageUrl;
    if (css != null) this.css = css;
  }
  PageStateMatcher.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Matches if the condition of the UrlFilter are fulfilled for the top-level
   * URL of the page.
   */
  UrlFilter get pageUrl => _createUrlFilter(jsProxy['pageUrl']);
  set pageUrl(UrlFilter value) => jsProxy['pageUrl'] = jsify(value);

  /**
   * Matches if all of the CSS selectors in the array match displayed elements
   * in a frame with the same origin as the page's main frame.  All selectors in
   * this array must be [compound
   * selectors](http://www.w3.org/TR/selectors4/#compound) to speed up matching.
   * Note that listing hundreds of CSS selectors or CSS selectors that match
   * hundreds of times per page can still slow down web sites.
   */
  List<String> get css => listify(jsProxy['css']);
  set css(List<String> value) => jsProxy['css'] = jsify(value);
}

/**
 * Declarative event action that shows the extension's [][pageAction page
 * action] while the corresponding conditions are met.  This action can be used
 * without [host permissions](declare_permissions.html#host-permission), but the
 * extension must have a page action.  If the extension takes the
 * [activeTab](activeTab.html) permission, a click on the page action will grant
 * access to the active tab.
 */
class ShowPageAction extends ChromeObject {
  ShowPageAction();
  ShowPageAction.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

UrlFilter _createUrlFilter(JsObject jsProxy) => jsProxy == null ? null : new UrlFilter.fromProxy(jsProxy);
