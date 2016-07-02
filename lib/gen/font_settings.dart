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
  JsObject get _fontSettings => chrome['fontSettings'];

  /**
   * Fired when a font setting changes.
   */
  Stream<Map> get onFontChanged => _onFontChanged.stream;
  ChromeStreamController<Map> _onFontChanged;

  /**
   * Fired when the default font size setting changes.
   */
  Stream<Map> get onDefaultFontSizeChanged => _onDefaultFontSizeChanged.stream;
  ChromeStreamController<Map> _onDefaultFontSizeChanged;

  /**
   * Fired when the default fixed font size setting changes.
   */
  Stream<Map> get onDefaultFixedFontSizeChanged => _onDefaultFixedFontSizeChanged.stream;
  ChromeStreamController<Map> _onDefaultFixedFontSizeChanged;

  /**
   * Fired when the minimum font size setting changes.
   */
  Stream<Map> get onMinimumFontSizeChanged => _onMinimumFontSizeChanged.stream;
  ChromeStreamController<Map> _onMinimumFontSizeChanged;

  ChromeFontSettings._() {
    var getApi = () => _fontSettings;
    _onFontChanged = new ChromeStreamController<Map>.oneArg(getApi, 'onFontChanged', mapify);
    _onDefaultFontSizeChanged = new ChromeStreamController<Map>.oneArg(getApi, 'onDefaultFontSizeChanged', mapify);
    _onDefaultFixedFontSizeChanged = new ChromeStreamController<Map>.oneArg(getApi, 'onDefaultFixedFontSizeChanged', mapify);
    _onMinimumFontSizeChanged = new ChromeStreamController<Map>.oneArg(getApi, 'onMinimumFontSizeChanged', mapify);
  }

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

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.fontSettings' is not available");
  }
}

/**
 * An ISO 15924 script code. The default, or global, script is represented by
 * script code "Zyyy".
 */
class ScriptCode extends ChromeEnum {
  static const ScriptCode _AFAK = const ScriptCode._('Afak');
  static const ScriptCode _ARAB = const ScriptCode._('Arab');
  static const ScriptCode _ARMI = const ScriptCode._('Armi');
  static const ScriptCode _ARMN = const ScriptCode._('Armn');
  static const ScriptCode _AVST = const ScriptCode._('Avst');
  static const ScriptCode _BALI = const ScriptCode._('Bali');
  static const ScriptCode _BAMU = const ScriptCode._('Bamu');
  static const ScriptCode _BASS = const ScriptCode._('Bass');
  static const ScriptCode _BATK = const ScriptCode._('Batk');
  static const ScriptCode _BENG = const ScriptCode._('Beng');
  static const ScriptCode _BLIS = const ScriptCode._('Blis');
  static const ScriptCode _BOPO = const ScriptCode._('Bopo');
  static const ScriptCode _BRAH = const ScriptCode._('Brah');
  static const ScriptCode _BRAI = const ScriptCode._('Brai');
  static const ScriptCode _BUGI = const ScriptCode._('Bugi');
  static const ScriptCode _BUHD = const ScriptCode._('Buhd');
  static const ScriptCode _CAKM = const ScriptCode._('Cakm');
  static const ScriptCode _CANS = const ScriptCode._('Cans');
  static const ScriptCode _CARI = const ScriptCode._('Cari');
  static const ScriptCode _CHAM = const ScriptCode._('Cham');
  static const ScriptCode _CHER = const ScriptCode._('Cher');
  static const ScriptCode _CIRT = const ScriptCode._('Cirt');
  static const ScriptCode _COPT = const ScriptCode._('Copt');
  static const ScriptCode _CPRT = const ScriptCode._('Cprt');
  static const ScriptCode _CYRL = const ScriptCode._('Cyrl');
  static const ScriptCode _CYRS = const ScriptCode._('Cyrs');
  static const ScriptCode _DEVA = const ScriptCode._('Deva');
  static const ScriptCode _DSRT = const ScriptCode._('Dsrt');
  static const ScriptCode _DUPL = const ScriptCode._('Dupl');
  static const ScriptCode _EGYD = const ScriptCode._('Egyd');
  static const ScriptCode _EGYH = const ScriptCode._('Egyh');
  static const ScriptCode _EGYP = const ScriptCode._('Egyp');
  static const ScriptCode _ELBA = const ScriptCode._('Elba');
  static const ScriptCode _ETHI = const ScriptCode._('Ethi');
  static const ScriptCode _GEOR = const ScriptCode._('Geor');
  static const ScriptCode _GEOK = const ScriptCode._('Geok');
  static const ScriptCode _GLAG = const ScriptCode._('Glag');
  static const ScriptCode _GOTH = const ScriptCode._('Goth');
  static const ScriptCode _GRAN = const ScriptCode._('Gran');
  static const ScriptCode _GREK = const ScriptCode._('Grek');
  static const ScriptCode _GUJR = const ScriptCode._('Gujr');
  static const ScriptCode _GURU = const ScriptCode._('Guru');
  static const ScriptCode _HANG = const ScriptCode._('Hang');
  static const ScriptCode _HANI = const ScriptCode._('Hani');
  static const ScriptCode _HANO = const ScriptCode._('Hano');
  static const ScriptCode _HANS = const ScriptCode._('Hans');
  static const ScriptCode _HANT = const ScriptCode._('Hant');
  static const ScriptCode _HEBR = const ScriptCode._('Hebr');
  static const ScriptCode _HLUW = const ScriptCode._('Hluw');
  static const ScriptCode _HMNG = const ScriptCode._('Hmng');
  static const ScriptCode _HUNG = const ScriptCode._('Hung');
  static const ScriptCode _INDS = const ScriptCode._('Inds');
  static const ScriptCode _ITAL = const ScriptCode._('Ital');
  static const ScriptCode _JAVA = const ScriptCode._('Java');
  static const ScriptCode _JPAN = const ScriptCode._('Jpan');
  static const ScriptCode _JURC = const ScriptCode._('Jurc');
  static const ScriptCode _KALI = const ScriptCode._('Kali');
  static const ScriptCode _KHAR = const ScriptCode._('Khar');
  static const ScriptCode _KHMR = const ScriptCode._('Khmr');
  static const ScriptCode _KHOJ = const ScriptCode._('Khoj');
  static const ScriptCode _KNDA = const ScriptCode._('Knda');
  static const ScriptCode _KPEL = const ScriptCode._('Kpel');
  static const ScriptCode _KTHI = const ScriptCode._('Kthi');
  static const ScriptCode _LANA = const ScriptCode._('Lana');
  static const ScriptCode _LAOO = const ScriptCode._('Laoo');
  static const ScriptCode _LATF = const ScriptCode._('Latf');
  static const ScriptCode _LATG = const ScriptCode._('Latg');
  static const ScriptCode _LATN = const ScriptCode._('Latn');
  static const ScriptCode _LEPC = const ScriptCode._('Lepc');
  static const ScriptCode _LIMB = const ScriptCode._('Limb');
  static const ScriptCode _LINA = const ScriptCode._('Lina');
  static const ScriptCode _LINB = const ScriptCode._('Linb');
  static const ScriptCode _LISU = const ScriptCode._('Lisu');
  static const ScriptCode _LOMA = const ScriptCode._('Loma');
  static const ScriptCode _LYCI = const ScriptCode._('Lyci');
  static const ScriptCode _LYDI = const ScriptCode._('Lydi');
  static const ScriptCode _MAND = const ScriptCode._('Mand');
  static const ScriptCode _MANI = const ScriptCode._('Mani');
  static const ScriptCode _MAYA = const ScriptCode._('Maya');
  static const ScriptCode _MEND = const ScriptCode._('Mend');
  static const ScriptCode _MERC = const ScriptCode._('Merc');
  static const ScriptCode _MERO = const ScriptCode._('Mero');
  static const ScriptCode _MLYM = const ScriptCode._('Mlym');
  static const ScriptCode _MOON = const ScriptCode._('Moon');
  static const ScriptCode _MONG = const ScriptCode._('Mong');
  static const ScriptCode _MROO = const ScriptCode._('Mroo');
  static const ScriptCode _MTEI = const ScriptCode._('Mtei');
  static const ScriptCode _MYMR = const ScriptCode._('Mymr');
  static const ScriptCode _NARB = const ScriptCode._('Narb');
  static const ScriptCode _NBAT = const ScriptCode._('Nbat');
  static const ScriptCode _NKGB = const ScriptCode._('Nkgb');
  static const ScriptCode _NKOO = const ScriptCode._('Nkoo');
  static const ScriptCode _NSHU = const ScriptCode._('Nshu');
  static const ScriptCode _OGAM = const ScriptCode._('Ogam');
  static const ScriptCode _OLCK = const ScriptCode._('Olck');
  static const ScriptCode _ORKH = const ScriptCode._('Orkh');
  static const ScriptCode _ORYA = const ScriptCode._('Orya');
  static const ScriptCode _OSMA = const ScriptCode._('Osma');
  static const ScriptCode _PALM = const ScriptCode._('Palm');
  static const ScriptCode _PERM = const ScriptCode._('Perm');
  static const ScriptCode _PHAG = const ScriptCode._('Phag');
  static const ScriptCode _PHLI = const ScriptCode._('Phli');
  static const ScriptCode _PHLP = const ScriptCode._('Phlp');
  static const ScriptCode _PHLV = const ScriptCode._('Phlv');
  static const ScriptCode _PHNX = const ScriptCode._('Phnx');
  static const ScriptCode _PLRD = const ScriptCode._('Plrd');
  static const ScriptCode _PRTI = const ScriptCode._('Prti');
  static const ScriptCode _RJNG = const ScriptCode._('Rjng');
  static const ScriptCode _RORO = const ScriptCode._('Roro');
  static const ScriptCode _RUNR = const ScriptCode._('Runr');
  static const ScriptCode _SAMR = const ScriptCode._('Samr');
  static const ScriptCode _SARA = const ScriptCode._('Sara');
  static const ScriptCode _SARB = const ScriptCode._('Sarb');
  static const ScriptCode _SAUR = const ScriptCode._('Saur');
  static const ScriptCode _SGNW = const ScriptCode._('Sgnw');
  static const ScriptCode _SHAW = const ScriptCode._('Shaw');
  static const ScriptCode _SHRD = const ScriptCode._('Shrd');
  static const ScriptCode _SIND = const ScriptCode._('Sind');
  static const ScriptCode _SINH = const ScriptCode._('Sinh');
  static const ScriptCode _SORA = const ScriptCode._('Sora');
  static const ScriptCode _SUND = const ScriptCode._('Sund');
  static const ScriptCode _SYLO = const ScriptCode._('Sylo');
  static const ScriptCode _SYRC = const ScriptCode._('Syrc');
  static const ScriptCode _SYRE = const ScriptCode._('Syre');
  static const ScriptCode _SYRJ = const ScriptCode._('Syrj');
  static const ScriptCode _SYRN = const ScriptCode._('Syrn');
  static const ScriptCode _TAGB = const ScriptCode._('Tagb');
  static const ScriptCode _TAKR = const ScriptCode._('Takr');
  static const ScriptCode _TALE = const ScriptCode._('Tale');
  static const ScriptCode _TALU = const ScriptCode._('Talu');
  static const ScriptCode _TAML = const ScriptCode._('Taml');
  static const ScriptCode _TANG = const ScriptCode._('Tang');
  static const ScriptCode _TAVT = const ScriptCode._('Tavt');
  static const ScriptCode _TELU = const ScriptCode._('Telu');
  static const ScriptCode _TENG = const ScriptCode._('Teng');
  static const ScriptCode _TFNG = const ScriptCode._('Tfng');
  static const ScriptCode _TGLG = const ScriptCode._('Tglg');
  static const ScriptCode _THAA = const ScriptCode._('Thaa');
  static const ScriptCode _THAI = const ScriptCode._('Thai');
  static const ScriptCode _TIBT = const ScriptCode._('Tibt');
  static const ScriptCode _TIRH = const ScriptCode._('Tirh');
  static const ScriptCode _UGAR = const ScriptCode._('Ugar');
  static const ScriptCode _VAII = const ScriptCode._('Vaii');
  static const ScriptCode _VISP = const ScriptCode._('Visp');
  static const ScriptCode _WARA = const ScriptCode._('Wara');
  static const ScriptCode _WOLE = const ScriptCode._('Wole');
  static const ScriptCode _XPEO = const ScriptCode._('Xpeo');
  static const ScriptCode _XSUX = const ScriptCode._('Xsux');
  static const ScriptCode _YIII = const ScriptCode._('Yiii');
  static const ScriptCode _ZMTH = const ScriptCode._('Zmth');
  static const ScriptCode _ZSYM = const ScriptCode._('Zsym');
  static const ScriptCode _ZYYY = const ScriptCode._('Zyyy');

  static const List<ScriptCode> VALUES = const[_AFAK, _ARAB, _ARMI, _ARMN, _AVST, _BALI, _BAMU, _BASS, _BATK, _BENG, _BLIS, _BOPO, _BRAH, _BRAI, _BUGI, _BUHD, _CAKM, _CANS, _CARI, _CHAM, _CHER, _CIRT, _COPT, _CPRT, _CYRL, _CYRS, _DEVA, _DSRT, _DUPL, _EGYD, _EGYH, _EGYP, _ELBA, _ETHI, _GEOR, _GEOK, _GLAG, _GOTH, _GRAN, _GREK, _GUJR, _GURU, _HANG, _HANI, _HANO, _HANS, _HANT, _HEBR, _HLUW, _HMNG, _HUNG, _INDS, _ITAL, _JAVA, _JPAN, _JURC, _KALI, _KHAR, _KHMR, _KHOJ, _KNDA, _KPEL, _KTHI, _LANA, _LAOO, _LATF, _LATG, _LATN, _LEPC, _LIMB, _LINA, _LINB, _LISU, _LOMA, _LYCI, _LYDI, _MAND, _MANI, _MAYA, _MEND, _MERC, _MERO, _MLYM, _MOON, _MONG, _MROO, _MTEI, _MYMR, _NARB, _NBAT, _NKGB, _NKOO, _NSHU, _OGAM, _OLCK, _ORKH, _ORYA, _OSMA, _PALM, _PERM, _PHAG, _PHLI, _PHLP, _PHLV, _PHNX, _PLRD, _PRTI, _RJNG, _RORO, _RUNR, _SAMR, _SARA, _SARB, _SAUR, _SGNW, _SHAW, _SHRD, _SIND, _SINH, _SORA, _SUND, _SYLO, _SYRC, _SYRE, _SYRJ, _SYRN, _TAGB, _TAKR, _TALE, _TALU, _TAML, _TANG, _TAVT, _TELU, _TENG, _TFNG, _TGLG, _THAA, _THAI, _TIBT, _TIRH, _UGAR, _VAII, _VISP, _WARA, _WOLE, _XPEO, _XSUX, _YIII, _ZMTH, _ZSYM, _ZYYY];

  const ScriptCode._(String str): super(str);
}

/**
 * A CSS generic font family.
 */
class GenericFamily extends ChromeEnum {
  static const GenericFamily STANDARD = const GenericFamily._('standard');
  static const GenericFamily SANSSERIF = const GenericFamily._('sansserif');
  static const GenericFamily SERIF = const GenericFamily._('serif');
  static const GenericFamily FIXED = const GenericFamily._('fixed');
  static const GenericFamily CURSIVE = const GenericFamily._('cursive');
  static const GenericFamily FANTASY = const GenericFamily._('fantasy');

  static const List<GenericFamily> VALUES = const[STANDARD, SANSSERIF, SERIF, FIXED, CURSIVE, FANTASY];

  const GenericFamily._(String str): super(str);
}

/**
 * One of<br>[not_controllable]: cannot be controlled by any
 * extension<br>[controlled_by_other_extensions]: controlled by extensions with
 * higher precedence<br>[controllable_by_this_extension]: can be controlled by
 * this extension<br>[controlled_by_this_extension]: controlled by this
 * extension
 */
class LevelOfControl extends ChromeEnum {
  static const LevelOfControl NOT_CONTROLLABLE = const LevelOfControl._('not_controllable');
  static const LevelOfControl CONTROLLED_BY_OTHER_EXTENSIONS = const LevelOfControl._('controlled_by_other_extensions');
  static const LevelOfControl CONTROLLABLE_BY_THIS_EXTENSION = const LevelOfControl._('controllable_by_this_extension');
  static const LevelOfControl CONTROLLED_BY_THIS_EXTENSION = const LevelOfControl._('controlled_by_this_extension');

  static const List<LevelOfControl> VALUES = const[NOT_CONTROLLABLE, CONTROLLED_BY_OTHER_EXTENSIONS, CONTROLLABLE_BY_THIS_EXTENSION, CONTROLLED_BY_THIS_EXTENSION];

  const LevelOfControl._(String str): super(str);
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
ScriptCode _createScriptCode(String value) => ScriptCode.VALUES.singleWhere((ChromeEnum e) => e.value == value);
GenericFamily _createGenericFamily(String value) => GenericFamily.VALUES.singleWhere((ChromeEnum e) => e.value == value);
