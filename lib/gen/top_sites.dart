/* This file has been generated from top_sites.json - do not edit */

/**
 * Use the `chrome.topSites` API to access the top sites that are displayed on
 * the new tab page.
 */
library chrome.topSites;

import '../src/common.dart';

/**
 * Accessor for the `chrome.topSites` namespace.
 */
final ChromeTopSites topSites = new ChromeTopSites._();

class ChromeTopSites extends ChromeApi {
  static final JsObject _topSites = chrome['topSites'];

  ChromeTopSites._();

  bool get available => _topSites != null;

  /**
   * Gets a list of top sites.
   */
  Future<List<MostVisitedURL>> get() {
    if (_topSites == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<MostVisitedURL>>.oneArg((e) => listify(e, _createMostVisitedURL));
    _topSites.callMethod('get', [completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.topSites' is not available");
  }
}

/**
 * An object encapsulating a most visited URL, such as the URLs on the new tab
 * page.
 */
class MostVisitedURL extends ChromeObject {
  MostVisitedURL({String url, String title}) {
    if (url != null) this.url = url;
    if (title != null) this.title = title;
  }
  MostVisitedURL.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The most visited URL.
   */
  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;

  /**
   * The title of the page
   */
  String get title => jsProxy['title'];
  set title(String value) => jsProxy['title'] = value;
}

MostVisitedURL _createMostVisitedURL(JsObject jsProxy) => jsProxy == null ? null : new MostVisitedURL.fromProxy(jsProxy);
