/* This file has been generated from browser.idl - do not edit */

/**
 * Use the `chrome.browser` API to interact with the Chrome browser associated
 * with the current application and Chrome profile.
 */
library chrome.browser;

import '../src/common.dart';

/**
 * Accessor for the `chrome.browser` namespace.
 */
final ChromeBrowser browser = new ChromeBrowser._();

class ChromeBrowser extends ChromeApi {
  JsObject get _browser => chrome['browser'];

  ChromeBrowser._();

  bool get available => _browser != null;

  /**
   * Opens a new tab in a browser window associated with the current application
   * and Chrome profile. If no browser window for the Chrome profile is opened,
   * a new one is opened prior to creating the new tab. [options] - Configures
   * how the tab should be opened. [callback] - Called when the tab was
   * successfully created, or failed to be created. If failed,
   * [runtime.lastError] will be set.
   */
  Future openTab(OpenTabOptions options) {
    if (_browser == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _browser.callMethod('openTab', [jsify(options), completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.browser' is not available");
  }
}

/**
 * Options for the [openTab] function.
 */
class OpenTabOptions extends ChromeObject {
  OpenTabOptions({String url}) {
    if (url != null) this.url = url;
  }
  OpenTabOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;
}
