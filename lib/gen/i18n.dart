/* This file has been generated from i18n.json - do not edit */

/**
 * Use the `chrome.i18n` infrastructure to implement internationalization across
 * your whole app or extension.
 */
library chrome.i18n;

import '../src/common.dart';

/**
 * Accessor for the `chrome.i18n` namespace.
 */
final ChromeI18N i18n = new ChromeI18N._();

class ChromeI18N extends ChromeApi {
  JsObject get _i18n => chrome['i18n'];

  ChromeI18N._();

  bool get available => _i18n != null;

  /**
   * Gets the accept-languages of the browser. This is different from the locale
   * used by the browser; to get the locale, use [i18n.getUILanguage].
   * 
   * Returns:
   * Array of the accept languages of the browser, such as en-US,en,zh-CN
   */
  Future<List<String>> getAcceptLanguages() {
    if (_i18n == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<String>>.oneArg(listify);
    _i18n.callMethod('getAcceptLanguages', [completer.callback]);
    return completer.future;
  }

  /**
   * Gets the localized string for the specified message. If the message is
   * missing, this method returns an empty string (''). If the format of the
   * `getMessage()` call is wrong - for example, _messageName_ is not a string
   * or the _substitutions_ array has more than 9 elements - this method returns
   * `undefined`.
   * 
   * [messageName] The name of the message, as specified in the <a
   * href='i18n-messages'>`messages.json`</a> file.
   * 
   * [substitutions] Up to 9 substitution strings, if the message requires any.
   * 
   * Returns:
   * Message localized for current locale.
   */
  String getMessage(String messageName, [dynamic substitutions]) {
    if (_i18n == null) _throwNotAvailable();

    return _i18n.callMethod('getMessage', [messageName, jsify(substitutions)]);
  }

  /**
   * Gets the browser UI language of the browser. This is different from
   * [i18n.getAcceptLanguages] which returns the preferred user languages.
   * 
   * Returns:
   * The browser UI language code such as en-US or fr-FR.
   */
  String getUILanguage() {
    if (_i18n == null) _throwNotAvailable();

    return _i18n.callMethod('getUILanguage');
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.i18n' is not available");
  }
}
