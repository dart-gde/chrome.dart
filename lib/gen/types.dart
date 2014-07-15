/* This file has been generated from types.json - do not edit */

/**
 * The `chrome.types` API contains type declarations for Chrome.
 */
library chrome.types;

import '../src/common.dart';

/**
 * Accessor for the `chrome.types` namespace.
 */
final ChromeTypes types = new ChromeTypes._();

class ChromeTypes extends ChromeApi {
  JsObject get _types => chrome['types'];

  ChromeTypes._();

  bool get available => _types != null;

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.types' is not available");
  }
}

/**
 * An interface that allows access to a Chrome browser setting. See
 * [accessibilityFeatures] for an example.
 */
class ChromeSetting extends ChromeObject {
  ChromeSetting();
  ChromeSetting.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Gets the value of a setting.
   * 
   * [details] Which setting to consider.
   * 
   * Returns:
   * Details of the currently effective value.
   */
  Future<Map> get(TypesGetParams details) {
    var completer = new ChromeCompleter<Map>.oneArg(mapify);
    jsProxy.callMethod('get', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Sets the value of a setting.
   * 
   * [details] Which setting to change.
   */
  Future set(TypesSetParams details) {
    var completer = new ChromeCompleter.noArgs();
    jsProxy.callMethod('set', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Clears the setting, restoring any default value.
   * 
   * [details] Which setting to clear.
   */
  Future clear(TypesClearParams details) {
    var completer = new ChromeCompleter.noArgs();
    jsProxy.callMethod('clear', [jsify(details), completer.callback]);
    return completer.future;
  }
}

/**
 * Details about the format and quality of an image.
 */
class ImageDetails extends ChromeObject {
  ImageDetails({String format, int quality}) {
    if (format != null) this.format = format;
    if (quality != null) this.quality = quality;
  }
  ImageDetails.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The format of the resulting image.  Default is `"jpeg"`.
   * enum of `jpeg`, `png`
   */
  String get format => jsProxy['format'];
  set format(String value) => jsProxy['format'] = value;

  /**
   * When format is `"jpeg"`, controls the quality of the resulting image.  This
   * value is ignored for PNG images.  As quality is decreased, the resulting
   * image will have more visual artifacts, and the number of bytes needed to
   * store it will decrease.
   */
  int get quality => jsProxy['quality'];
  set quality(int value) => jsProxy['quality'] = value;
}

class TypesGetParams extends ChromeObject {
  TypesGetParams({bool incognito}) {
    if (incognito != null) this.incognito = incognito;
  }
  TypesGetParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Whether to return the value that applies to the incognito session (default
   * false).
   */
  bool get incognito => jsProxy['incognito'];
  set incognito(bool value) => jsProxy['incognito'] = value;
}

class TypesSetParams extends ChromeObject {
  TypesSetParams({var value, String scope}) {
    if (value != null) this.value = value;
    if (scope != null) this.scope = scope;
  }
  TypesSetParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The value of the setting. <br/>Note that every setting has a specific value
   * type, which is described together with the setting. An extension should
   * _not_ set a value of a different type.
   */
  dynamic get value => jsProxy['value'];
  set value(var value) => jsProxy['value'] = jsify(value);

  /**
   * Where to set the setting (default: regular). One of<ul><li>[regular]:
   * setting for the regular profile (which is inherited by the incognito
   * profile if not overridden elsewhere),</li><li>[regular_only]: setting for
   * the regular profile only (not inherited by the incognito
   * profile),</li><li>[incognito_persistent]: setting for the incognito profile
   * that survives browser restarts (overrides regular
   * preferences),</li><li>[incognito_session_only]: setting for the incognito
   * profile that can only be set during an incognito session and is deleted
   * when the incognito session ends (overrides regular and incognito_persistent
   * preferences).</li></ul>
   * enum of `regular`, `regular_only`, `incognito_persistent`,
   * `incognito_session_only`
   */
  String get scope => jsProxy['scope'];
  set scope(String value) => jsProxy['scope'] = value;
}

class TypesClearParams extends ChromeObject {
  TypesClearParams({String scope}) {
    if (scope != null) this.scope = scope;
  }
  TypesClearParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Where to clear the setting (default: regular). One of<ul><li>[regular]:
   * setting for the regular profile (which is inherited by the incognito
   * profile if not overridden elsewhere),</li><li>[regular_only]: setting for
   * the regular profile only (not inherited by the incognito
   * profile),</li><li>[incognito_persistent]: setting for the incognito profile
   * that survives browser restarts (overrides regular
   * preferences),</li><li>[incognito_session_only]: setting for the incognito
   * profile that can only be set during an incognito session and is deleted
   * when the incognito session ends (overrides regular and incognito_persistent
   * preferences).</li></ul>
   * enum of `regular`, `regular_only`, `incognito_persistent`,
   * `incognito_session_only`
   */
  String get scope => jsProxy['scope'];
  set scope(String value) => jsProxy['scope'] = value;
}
