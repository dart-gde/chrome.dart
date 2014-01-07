/* This file has been generated from font_settings.json - do not edit */

/**
 * Use the `chrome.fontSettings` API to manage Chrome's font settings.
 */
library chrome.fontSettings;

import '../src/common.dart';

/**
 * Accessor for the `chrome.fontSettings` namespace.
 */
final ChromeFontSettings fontSettings = new ChromeFontSettings._();

class ChromeFontSettings extends ChromeApi {
  static final JsObject _fontSettings = chrome['fontSettings'];

  ChromeFontSettings._();

  bool get available => _fontSettings != null;

  /**
   * Clears the font set by this extension, if any.
   */
  Future clearFont(FontSettingsClearFontParams details) {
    if (_fontSettings == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _fontSettings.callMethod('clearFont', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Gets the font for a given script and generic font family.
   */
  Future<Map> getFont(FontSettingsGetFontParams details) {
    if (_fontSettings == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Map>.oneArg(mapify);
    _fontSettings.callMethod('getFont', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Sets the font for a given script and generic font family.
   */
  Future setFont(FontSettingsSetFontParams details) {
    if (_fontSettings == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _fontSettings.callMethod('setFont', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Gets a list of fonts on the system.
   */
  Future<List<FontName>> getFontList() {
    if (_fontSettings == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<FontName>>.oneArg((e) => listify(e, _createFontName));
    _fontSettings.callMethod('getFontList', [completer.callback]);
    return completer.future;
  }

  /**
   * Clears the default font size set by this extension, if any.
   * 
   * [details] This parameter is currently unused.
   */
  Future clearDefaultFontSize([FontSettingsClearDefaultFontSizeParams details]) {
    if (_fontSettings == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _fontSettings.callMethod('clearDefaultFontSize', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Gets the default font size.
   * 
   * [details] This parameter is currently unused.
   */
  Future<Map> getDefaultFontSize([FontSettingsGetDefaultFontSizeParams details]) {
    if (_fontSettings == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Map>.oneArg(mapify);
    _fontSettings.callMethod('getDefaultFontSize', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Sets the default font size.
   */
  Future setDefaultFontSize(FontSettingsSetDefaultFontSizeParams details) {
    if (_fontSettings == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _fontSettings.callMethod('setDefaultFontSize', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Clears the default fixed font size set by this extension, if any.
   * 
   * [details] This parameter is currently unused.
   */
  Future clearDefaultFixedFontSize([FontSettingsClearDefaultFixedFontSizeParams details]) {
    if (_fontSettings == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _fontSettings.callMethod('clearDefaultFixedFontSize', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Gets the default size for fixed width fonts.
   * 
   * [details] This parameter is currently unused.
   */
  Future<Map> getDefaultFixedFontSize([FontSettingsGetDefaultFixedFontSizeParams details]) {
    if (_fontSettings == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Map>.oneArg(mapify);
    _fontSettings.callMethod('getDefaultFixedFontSize', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Sets the default size for fixed width fonts.
   */
  Future setDefaultFixedFontSize(FontSettingsSetDefaultFixedFontSizeParams details) {
    if (_fontSettings == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _fontSettings.callMethod('setDefaultFixedFontSize', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Clears the minimum font size set by this extension, if any.
   * 
   * [details] This parameter is currently unused.
   */
  Future clearMinimumFontSize([FontSettingsClearMinimumFontSizeParams details]) {
    if (_fontSettings == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _fontSettings.callMethod('clearMinimumFontSize', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Gets the minimum font size.
   * 
   * [details] This parameter is currently unused.
   */
  Future<Map> getMinimumFontSize([FontSettingsGetMinimumFontSizeParams details]) {
    if (_fontSettings == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Map>.oneArg(mapify);
    _fontSettings.callMethod('getMinimumFontSize', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Sets the minimum font size.
   */
  Future setMinimumFontSize(FontSettingsSetMinimumFontSizeParams details) {
    if (_fontSettings == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _fontSettings.callMethod('setMinimumFontSize', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Fired when a font setting changes.
   */
  Stream<Map> get onFontChanged => _onFontChanged.stream;

  final ChromeStreamController<Map> _onFontChanged =
      new ChromeStreamController<Map>.oneArg(_fontSettings, 'onFontChanged', mapify);

  /**
   * Fired when the default font size setting changes.
   */
  Stream<Map> get onDefaultFontSizeChanged => _onDefaultFontSizeChanged.stream;

  final ChromeStreamController<Map> _onDefaultFontSizeChanged =
      new ChromeStreamController<Map>.oneArg(_fontSettings, 'onDefaultFontSizeChanged', mapify);

  /**
   * Fired when the default fixed font size setting changes.
   */
  Stream<Map> get onDefaultFixedFontSizeChanged => _onDefaultFixedFontSizeChanged.stream;

  final ChromeStreamController<Map> _onDefaultFixedFontSizeChanged =
      new ChromeStreamController<Map>.oneArg(_fontSettings, 'onDefaultFixedFontSizeChanged', mapify);

  /**
   * Fired when the minimum font size setting changes.
   */
  Stream<Map> get onMinimumFontSizeChanged => _onMinimumFontSizeChanged.stream;

  final ChromeStreamController<Map> _onMinimumFontSizeChanged =
      new ChromeStreamController<Map>.oneArg(_fontSettings, 'onMinimumFontSizeChanged', mapify);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.fontSettings' is not available");
  }
}

/**
 * Represents a font name.
 */
class FontName extends ChromeObject {
  FontName({String fontId, String displayName}) {
    if (fontId != null) this.fontId = fontId;
    if (displayName != null) this.displayName = displayName;
  }
  FontName.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The font ID.
   */
  String get fontId => jsProxy['fontId'];
  set fontId(String value) => jsProxy['fontId'] = value;

  /**
   * The display name of the font.
   */
  String get displayName => jsProxy['displayName'];
  set displayName(String value) => jsProxy['displayName'] = value;
}

/**
 * An ISO 15924 script code. The default, or global, script is represented by
 * script code "Zyyy".
 * enum of `Afak`, `Arab`, `Armi`, `Armn`, `Avst`, `Bali`, `Bamu`, `Bass`,
 * `Batk`, `Beng`, `Blis`, `Bopo`, `Brah`, `Brai`, `Bugi`, `Buhd`, `Cakm`,
 * `Cans`, `Cari`, `Cham`, `Cher`, `Cirt`, `Copt`, `Cprt`, `Cyrl`, `Cyrs`,
 * `Deva`, `Dsrt`, `Dupl`, `Egyd`, `Egyh`, `Egyp`, `Elba`, `Ethi`, `Geor`,
 * `Geok`, `Glag`, `Goth`, `Gran`, `Grek`, `Gujr`, `Guru`, `Hang`, `Hani`,
 * `Hano`, `Hans`, `Hant`, `Hebr`, `Hluw`, `Hmng`, `Hung`, `Inds`, `Ital`,
 * `Java`, `Jpan`, `Jurc`, `Kali`, `Khar`, `Khmr`, `Khoj`, `Knda`, `Kpel`,
 * `Kthi`, `Lana`, `Laoo`, `Latf`, `Latg`, `Latn`, `Lepc`, `Limb`, `Lina`,
 * `Linb`, `Lisu`, `Loma`, `Lyci`, `Lydi`, `Mand`, `Mani`, `Maya`, `Mend`,
 * `Merc`, `Mero`, `Mlym`, `Moon`, `Mong`, `Mroo`, `Mtei`, `Mymr`, `Narb`,
 * `Nbat`, `Nkgb`, `Nkoo`, `Nshu`, `Ogam`, `Olck`, `Orkh`, `Orya`, `Osma`,
 * `Palm`, `Perm`, `Phag`, `Phli`, `Phlp`, `Phlv`, `Phnx`, `Plrd`, `Prti`,
 * `Rjng`, `Roro`, `Runr`, `Samr`, `Sara`, `Sarb`, `Saur`, `Sgnw`, `Shaw`,
 * `Shrd`, `Sind`, `Sinh`, `Sora`, `Sund`, `Sylo`, `Syrc`, `Syre`, `Syrj`,
 * `Syrn`, `Tagb`, `Takr`, `Tale`, `Talu`, `Taml`, `Tang`, `Tavt`, `Telu`,
 * `Teng`, `Tfng`, `Tglg`, `Thaa`, `Thai`, `Tibt`, `Tirh`, `Ugar`, `Vaii`,
 * `Visp`, `Wara`, `Wole`, `Xpeo`, `Xsux`, `Yiii`, `Zmth`, `Zsym`, `Zyyy`
 */
class ScriptCode extends ChromeObject {
  ScriptCode();
  ScriptCode.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

/**
 * A CSS generic font family.
 * enum of `standard`, `sansserif`, `serif`, `fixed`, `cursive`, `fantasy`
 */
class GenericFamily extends ChromeObject {
  GenericFamily();
  GenericFamily.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

/**
 * One of<br>[not_controllable]: cannot be controlled by any
 * extension<br>[controlled_by_other_extensions]: controlled by extensions with
 * higher precedence<br>[controllable_by_this_extension]: can be controlled by
 * this extension<br>[controlled_by_this_extension]: controlled by this
 * extension
 * enum of `not_controllable`, `controlled_by_other_extensions`,
 * `controllable_by_this_extension`, `controlled_by_this_extension`
 */
class LevelOfControl extends ChromeObject {
  LevelOfControl();
  LevelOfControl.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

class FontSettingsClearFontParams extends ChromeObject {
  FontSettingsClearFontParams({ScriptCode script, GenericFamily genericFamily}) {
    if (script != null) this.script = script;
    if (genericFamily != null) this.genericFamily = genericFamily;
  }
  FontSettingsClearFontParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The script for which the font should be cleared. If omitted, the global
   * script font setting is cleared.
   */
  ScriptCode get script => _createScriptCode(jsProxy['script']);
  set script(ScriptCode value) => jsProxy['script'] = jsify(value);

  /**
   * The generic font family for which the font should be cleared.
   */
  GenericFamily get genericFamily => _createGenericFamily(jsProxy['genericFamily']);
  set genericFamily(GenericFamily value) => jsProxy['genericFamily'] = jsify(value);
}

class FontSettingsGetFontParams extends ChromeObject {
  FontSettingsGetFontParams({ScriptCode script, GenericFamily genericFamily}) {
    if (script != null) this.script = script;
    if (genericFamily != null) this.genericFamily = genericFamily;
  }
  FontSettingsGetFontParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The script for which the font should be retrieved. If omitted, the font
   * setting for the global script (script code "Zyyy") is retrieved.
   */
  ScriptCode get script => _createScriptCode(jsProxy['script']);
  set script(ScriptCode value) => jsProxy['script'] = jsify(value);

  /**
   * The generic font family for which the font should be retrieved.
   */
  GenericFamily get genericFamily => _createGenericFamily(jsProxy['genericFamily']);
  set genericFamily(GenericFamily value) => jsProxy['genericFamily'] = jsify(value);
}

class FontSettingsSetFontParams extends ChromeObject {
  FontSettingsSetFontParams({ScriptCode script, GenericFamily genericFamily, String fontId}) {
    if (script != null) this.script = script;
    if (genericFamily != null) this.genericFamily = genericFamily;
    if (fontId != null) this.fontId = fontId;
  }
  FontSettingsSetFontParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The script code which the font should be set. If omitted, the font setting
   * for the global script (script code "Zyyy") is set.
   */
  ScriptCode get script => _createScriptCode(jsProxy['script']);
  set script(ScriptCode value) => jsProxy['script'] = jsify(value);

  /**
   * The generic font family for which the font should be set.
   */
  GenericFamily get genericFamily => _createGenericFamily(jsProxy['genericFamily']);
  set genericFamily(GenericFamily value) => jsProxy['genericFamily'] = jsify(value);

  /**
   * The font ID. The empty string means to fallback to the global script font
   * setting.
   */
  String get fontId => jsProxy['fontId'];
  set fontId(String value) => jsProxy['fontId'] = value;
}

class FontSettingsClearDefaultFontSizeParams extends ChromeObject {
  FontSettingsClearDefaultFontSizeParams();
  FontSettingsClearDefaultFontSizeParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

class FontSettingsGetDefaultFontSizeParams extends ChromeObject {
  FontSettingsGetDefaultFontSizeParams();
  FontSettingsGetDefaultFontSizeParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

class FontSettingsSetDefaultFontSizeParams extends ChromeObject {
  FontSettingsSetDefaultFontSizeParams({int pixelSize}) {
    if (pixelSize != null) this.pixelSize = pixelSize;
  }
  FontSettingsSetDefaultFontSizeParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The font size in pixels.
   */
  int get pixelSize => jsProxy['pixelSize'];
  set pixelSize(int value) => jsProxy['pixelSize'] = value;
}

class FontSettingsClearDefaultFixedFontSizeParams extends ChromeObject {
  FontSettingsClearDefaultFixedFontSizeParams();
  FontSettingsClearDefaultFixedFontSizeParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

class FontSettingsGetDefaultFixedFontSizeParams extends ChromeObject {
  FontSettingsGetDefaultFixedFontSizeParams();
  FontSettingsGetDefaultFixedFontSizeParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

class FontSettingsSetDefaultFixedFontSizeParams extends ChromeObject {
  FontSettingsSetDefaultFixedFontSizeParams({int pixelSize}) {
    if (pixelSize != null) this.pixelSize = pixelSize;
  }
  FontSettingsSetDefaultFixedFontSizeParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The font size in pixels.
   */
  int get pixelSize => jsProxy['pixelSize'];
  set pixelSize(int value) => jsProxy['pixelSize'] = value;
}

class FontSettingsClearMinimumFontSizeParams extends ChromeObject {
  FontSettingsClearMinimumFontSizeParams();
  FontSettingsClearMinimumFontSizeParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

class FontSettingsGetMinimumFontSizeParams extends ChromeObject {
  FontSettingsGetMinimumFontSizeParams();
  FontSettingsGetMinimumFontSizeParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

class FontSettingsSetMinimumFontSizeParams extends ChromeObject {
  FontSettingsSetMinimumFontSizeParams({int pixelSize}) {
    if (pixelSize != null) this.pixelSize = pixelSize;
  }
  FontSettingsSetMinimumFontSizeParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The font size in pixels.
   */
  int get pixelSize => jsProxy['pixelSize'];
  set pixelSize(int value) => jsProxy['pixelSize'] = value;
}

FontName _createFontName(JsObject jsProxy) => jsProxy == null ? null : new FontName.fromProxy(jsProxy);
ScriptCode _createScriptCode(JsObject jsProxy) => jsProxy == null ? null : new ScriptCode.fromProxy(jsProxy);
GenericFamily _createGenericFamily(JsObject jsProxy) => jsProxy == null ? null : new GenericFamily.fromProxy(jsProxy);
