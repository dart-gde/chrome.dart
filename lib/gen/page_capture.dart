/* This file has been generated from page_capture.json - do not edit */

/**
 * Use the `chrome.pageCapture` API to save a tab as MHTML.
 */
library chrome.pageCapture;

import '../src/common.dart';

/**
 * Accessor for the `chrome.pageCapture` namespace.
 */
final ChromePageCapture pageCapture = new ChromePageCapture._();

class ChromePageCapture extends ChromeApi {
  static final JsObject _pageCapture = chrome['pageCapture'];

  ChromePageCapture._();

  bool get available => _pageCapture != null;

  /**
   * Saves the content of the tab with given id as MHTML.
   * 
   * Returns:
   * The MHTML data as a Blob.
   */
  Future<dynamic> saveAsMHTML(PageCaptureSaveAsMHTMLParams details) {
    if (_pageCapture == null) _throwNotAvailable();

    var completer = new ChromeCompleter<dynamic>.oneArg();
    _pageCapture.callMethod('saveAsMHTML', [jsify(details), completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.pageCapture' is not available");
  }
}

class PageCaptureSaveAsMHTMLParams extends ChromeObject {
  PageCaptureSaveAsMHTMLParams({int tabId}) {
    if (tabId != null) this.tabId = tabId;
  }
  PageCaptureSaveAsMHTMLParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The id of the tab to save as MHTML.
   */
  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;
}
