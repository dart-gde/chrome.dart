library chrome.i18n;

import 'dart:async';

import 'package:js/js.dart' as js;
import 'package:js/js_wrapping.dart' as js_wrapping;

import 'common.dart';

final ChromeI18n i18n = new ChromeI18n();

// chrome.i18n

/**
 * An internationalized extension or app can be easily localized — adapted to
 * languages and regions that it didn't originally support.
 *
 * You need to put all of its user-visible strings into a file named
 * messages.json. Each time you add a new locale, you add a messages file under
 * a directory named _locales/localeCode, where localeCode is a code such as en
 * for English.
 */
class ChromeI18n {

  /**
   * Gets the localized string for the specified message. If the message is
   * missing, this method returns an empty string (''). If the format of the
   * getMessage() call is wrong — for example, messageName is not a string or
   * the substitutions array has more than 9 elements — this method returns
   * undefined.
   */
  String getMessage(String key, [List<String> substitutions]) {
    // TODO: use the substitutions param
    return chromeProxy.i18n.getMessage(key);
  }

  /**
   * Gets the accept-languages of the browser. This is different from the locale
   * used by the browser; to get the locale, use window.navigator.language.
   */
  Future<List<String>> getAcceptLanguages() {
    return js.scoped(() {
      Completer completer = new Completer();

      js.Callback callback = new js.Callback.once((var languages) {
        completer.complete(new js_wrapping.JsArrayToListAdapter.fromProxy(languages).toList());
      });

      chromeProxy.i18n.getAcceptLanguages(callback);

      return completer.future;
    });
  }

  /**
   * The extension or app ID; you might use this string to construct URLs.
   */
  String get extension_id => getMessage('@@extension_id');

  /**
   * The current locale; you might use this string to construct locale-specific URLs.
   */
  String get ui_locale => getMessage('@@ui_locale');

  /**
   * The text direction for the current locale, either "ltr" for left-to-right languages such as English or "rtl" for right-to-left languages such as Japanese.
   */
  String get bidi_dir => getMessage('@@bidi_dir');

  /**
   * If the @@bidi_dir is "ltr", then this is "rtl"; otherwise, it's "ltr".
   */
  String get bidi_reversed_dir => getMessage('@@bidi_reversed_dir');

  /**
   * If the @@bidi_dir is "ltr", then this is "left"; otherwise, it's "right".
   */
  String get bidi_start_edge => getMessage('@@bidi_start_edge');

  /**
   * If the @@bidi_dir is "ltr", then this is "right"; otherwise, it's "left".
   */
  String get bidi_end_edge => getMessage('@@bidi_end_edge');
}
