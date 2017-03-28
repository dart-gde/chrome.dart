/* This file has been generated from content_settings.json - do not edit */

/**
 * Use the `chrome.contentSettings` API to change settings that control whether
 * websites can use features such as cookies, JavaScript, and plugins. More
 * generally speaking, content settings allow you to customize Chrome's behavior
 * on a per-site basis instead of globally.
 */
library chrome.contentSettings;

import '../src/common.dart';

/**
 * Accessor for the `chrome.contentSettings` namespace.
 */
final ChromeContentSettings contentSettings = new ChromeContentSettings._();

class ChromeContentSettings extends ChromeApi {
  JsObject get _contentSettings => chrome['contentSettings'];

  ChromeContentSettings._();

  bool get available => _contentSettings != null;

  /**
   * Whether to allow cookies and other local data to be set by websites. One
   * of<br>[allow]: Accept cookies,<br>[block]: Block
   * cookies,<br>[session_only]: Accept cookies only for the current session.
   * <br>Default is [allow].<br>The primary URL is the URL representing the
   * cookie origin. The secondary URL is the URL of the top-level frame.
   */
  ContentSetting get cookies => _createContentSetting(_contentSettings['cookies']);

  /**
   * Whether to show images. One of<br>[allow]: Show images,<br>[block]: Don't
   * show images. <br>Default is [allow].<br>The primary URL is the URL of the
   * top-level frame. The secondary URL is the URL of the image.
   */
  ContentSetting get images => _createContentSetting(_contentSettings['images']);

  /**
   * Whether to run JavaScript. One of<br>[allow]: Run JavaScript,<br>[block]:
   * Don't run JavaScript. <br>Default is [allow].<br>The primary URL is the URL
   * of the top-level frame. The secondary URL is not used.
   */
  ContentSetting get javascript => _createContentSetting(_contentSettings['javascript']);

  /**
   * Whether to allow Geolocation. One of <br>[allow]: Allow sites to track your
   * physical location,<br>[block]: Don't allow sites to track your physical
   * location,<br>[ask]: Ask before allowing sites to track your physical
   * location. <br>Default is [ask].<br>The primary URL is the URL of the
   * document which requested location data. The secondary URL is the URL of the
   * top-level frame (which may or may not differ from the requesting URL).
   */
  ContentSetting get location => _createContentSetting(_contentSettings['location']);

  /**
   * Whether to run plugins. One of<br>[allow]: Run plugins
   * automatically,<br>[block]: Don't run plugins
   * automatically,<br>[detect_important_content]: Only run automatically those
   * plugins that are detected as the website's main content.<br>The primary URL
   * is the URL of the top-level frame. The secondary URL is not used.
   */
  ContentSetting get plugins => _createContentSetting(_contentSettings['plugins']);

  /**
   * Whether to allow sites to show pop-ups. One of<br>[allow]: Allow sites to
   * show pop-ups,<br>[block]: Don't allow sites to show pop-ups. <br>Default is
   * [block].<br>The primary URL is the URL of the top-level frame. The
   * secondary URL is not used.
   */
  ContentSetting get popups => _createContentSetting(_contentSettings['popups']);

  /**
   * Whether to allow sites to show desktop notifications. One of<br>[allow]:
   * Allow sites to show desktop notifications,<br>[block]: Don't allow sites to
   * show desktop notifications,<br>[ask]: Ask when a site wants to show desktop
   * notifications. <br>Default is [ask].<br>The primary URL is the URL of the
   * document which wants to show the notification. The secondary URL is not
   * used.
   */
  ContentSetting get notifications => _createContentSetting(_contentSettings['notifications']);

  /**
   * <i>Deprecated.</i> No longer has any effect. Fullscreen permission is now
   * automatically granted for all sites. Value is always [allow].
   */
  ContentSetting get fullscreen => _createContentSetting(_contentSettings['fullscreen']);

  /**
   * <i>Deprecated.</i> No longer has any effect. Mouse lock permission is now
   * automatically granted for all sites. Value is always [allow].
   */
  ContentSetting get mouselock => _createContentSetting(_contentSettings['mouselock']);

  /**
   * Whether to allow sites to access the microphone. One of <br>[allow]: Allow
   * sites to access the microphone,<br>[block]: Don't allow sites to access the
   * microphone,<br>[ask]: Ask when a site wants to access the microphone.
   * <br>Default is [ask].<br>The primary URL is the URL of the document which
   * requested microphone access. The secondary URL is not used.<br>NOTE: The
   * 'allow' setting is not valid if both patterns are '<all_urls>'.
   */
  ContentSetting get microphone => _createContentSetting(_contentSettings['microphone']);

  /**
   * Whether to allow sites to access the camera. One of <br>[allow]: Allow
   * sites to access the camera,<br>[block]: Don't allow sites to access the
   * camera,<br>[ask]: Ask when a site wants to access the camera. <br>Default
   * is [ask].<br>The primary URL is the URL of the document which requested
   * camera access. The secondary URL is not used.<br>NOTE: The 'allow' setting
   * is not valid if both patterns are '<all_urls>'.
   */
  ContentSetting get camera => _createContentSetting(_contentSettings['camera']);

  /**
   * Whether to allow sites to run plugins unsandboxed. One of <br>[allow]:
   * Allow sites to run plugins unsandboxed,<br>[block]: Don't allow sites to
   * run plugins unsandboxed,<br>[ask]: Ask when a site wants to run a plugin
   * unsandboxed. <br>Default is [ask].<br>The primary URL is the URL of the
   * top-level frame. The secondary URL is not used.
   */
  ContentSetting get unsandboxedPlugins => _createContentSetting(_contentSettings['unsandboxedPlugins']);

  /**
   * Whether to allow sites to download multiple files automatically. One of
   * <br>[allow]: Allow sites to download multiple files
   * automatically,<br>[block]: Don't allow sites to download multiple files
   * automatically,<br>[ask]: Ask when a site wants to download files
   * automatically after the first file. <br>Default is [ask].<br>The primary
   * URL is the URL of the top-level frame. The secondary URL is not used.
   */
  ContentSetting get automaticDownloads => _createContentSetting(_contentSettings['automaticDownloads']);
}

/**
 * The scope of the ContentSetting. One of<br>[regular]: setting for regular
 * profile (which is inherited by the incognito profile if not overridden
 * elsewhere),<br>[incognito_session_only]: setting for incognito profile that
 * can only be set during an incognito session and is deleted when the incognito
 * session ends (overrides regular settings).
 */
class Scope extends ChromeEnum {
  static const Scope REGULAR = const Scope._('regular');
  static const Scope INCOGNITO_SESSION_ONLY = const Scope._('incognito_session_only');

  static const List<Scope> VALUES = const[REGULAR, INCOGNITO_SESSION_ONLY];

  const Scope._(String str): super(str);
}

class CookiesContentSetting extends ChromeEnum {
  static const CookiesContentSetting ALLOW = const CookiesContentSetting._('allow');
  static const CookiesContentSetting BLOCK = const CookiesContentSetting._('block');
  static const CookiesContentSetting SESSION_ONLY = const CookiesContentSetting._('session_only');

  static const List<CookiesContentSetting> VALUES = const[ALLOW, BLOCK, SESSION_ONLY];

  const CookiesContentSetting._(String str): super(str);
}

class ImagesContentSetting extends ChromeEnum {
  static const ImagesContentSetting ALLOW = const ImagesContentSetting._('allow');
  static const ImagesContentSetting BLOCK = const ImagesContentSetting._('block');

  static const List<ImagesContentSetting> VALUES = const[ALLOW, BLOCK];

  const ImagesContentSetting._(String str): super(str);
}

class JavascriptContentSetting extends ChromeEnum {
  static const JavascriptContentSetting ALLOW = const JavascriptContentSetting._('allow');
  static const JavascriptContentSetting BLOCK = const JavascriptContentSetting._('block');

  static const List<JavascriptContentSetting> VALUES = const[ALLOW, BLOCK];

  const JavascriptContentSetting._(String str): super(str);
}

class LocationContentSetting extends ChromeEnum {
  static const LocationContentSetting ALLOW = const LocationContentSetting._('allow');
  static const LocationContentSetting BLOCK = const LocationContentSetting._('block');
  static const LocationContentSetting ASK = const LocationContentSetting._('ask');

  static const List<LocationContentSetting> VALUES = const[ALLOW, BLOCK, ASK];

  const LocationContentSetting._(String str): super(str);
}

class PluginsContentSetting extends ChromeEnum {
  static const PluginsContentSetting ALLOW = const PluginsContentSetting._('allow');
  static const PluginsContentSetting BLOCK = const PluginsContentSetting._('block');
  static const PluginsContentSetting DETECT_IMPORTANT_CONTENT = const PluginsContentSetting._('detect_important_content');

  static const List<PluginsContentSetting> VALUES = const[ALLOW, BLOCK, DETECT_IMPORTANT_CONTENT];

  const PluginsContentSetting._(String str): super(str);
}

class PopupsContentSetting extends ChromeEnum {
  static const PopupsContentSetting ALLOW = const PopupsContentSetting._('allow');
  static const PopupsContentSetting BLOCK = const PopupsContentSetting._('block');

  static const List<PopupsContentSetting> VALUES = const[ALLOW, BLOCK];

  const PopupsContentSetting._(String str): super(str);
}

class NotificationsContentSetting extends ChromeEnum {
  static const NotificationsContentSetting ALLOW = const NotificationsContentSetting._('allow');
  static const NotificationsContentSetting BLOCK = const NotificationsContentSetting._('block');
  static const NotificationsContentSetting ASK = const NotificationsContentSetting._('ask');

  static const List<NotificationsContentSetting> VALUES = const[ALLOW, BLOCK, ASK];

  const NotificationsContentSetting._(String str): super(str);
}

class FullscreenContentSetting extends ChromeEnum {
  static const FullscreenContentSetting ALLOW = const FullscreenContentSetting._('allow');

  static const List<FullscreenContentSetting> VALUES = const[ALLOW];

  const FullscreenContentSetting._(String str): super(str);
}

class MouselockContentSetting extends ChromeEnum {
  static const MouselockContentSetting ALLOW = const MouselockContentSetting._('allow');

  static const List<MouselockContentSetting> VALUES = const[ALLOW];

  const MouselockContentSetting._(String str): super(str);
}

class MicrophoneContentSetting extends ChromeEnum {
  static const MicrophoneContentSetting ALLOW = const MicrophoneContentSetting._('allow');
  static const MicrophoneContentSetting BLOCK = const MicrophoneContentSetting._('block');
  static const MicrophoneContentSetting ASK = const MicrophoneContentSetting._('ask');

  static const List<MicrophoneContentSetting> VALUES = const[ALLOW, BLOCK, ASK];

  const MicrophoneContentSetting._(String str): super(str);
}

class CameraContentSetting extends ChromeEnum {
  static const CameraContentSetting ALLOW = const CameraContentSetting._('allow');
  static const CameraContentSetting BLOCK = const CameraContentSetting._('block');
  static const CameraContentSetting ASK = const CameraContentSetting._('ask');

  static const List<CameraContentSetting> VALUES = const[ALLOW, BLOCK, ASK];

  const CameraContentSetting._(String str): super(str);
}

class PpapiBrokerContentSetting extends ChromeEnum {
  static const PpapiBrokerContentSetting ALLOW = const PpapiBrokerContentSetting._('allow');
  static const PpapiBrokerContentSetting BLOCK = const PpapiBrokerContentSetting._('block');
  static const PpapiBrokerContentSetting ASK = const PpapiBrokerContentSetting._('ask');

  static const List<PpapiBrokerContentSetting> VALUES = const[ALLOW, BLOCK, ASK];

  const PpapiBrokerContentSetting._(String str): super(str);
}

class MultipleAutomaticDownloadsContentSetting extends ChromeEnum {
  static const MultipleAutomaticDownloadsContentSetting ALLOW = const MultipleAutomaticDownloadsContentSetting._('allow');
  static const MultipleAutomaticDownloadsContentSetting BLOCK = const MultipleAutomaticDownloadsContentSetting._('block');
  static const MultipleAutomaticDownloadsContentSetting ASK = const MultipleAutomaticDownloadsContentSetting._('ask');

  static const List<MultipleAutomaticDownloadsContentSetting> VALUES = const[ALLOW, BLOCK, ASK];

  const MultipleAutomaticDownloadsContentSetting._(String str): super(str);
}

/**
 * The only content type using resource identifiers is
 * [contentSettings.plugins]. For more information, see [Resource
 * Identifiers](contentSettings#resource-identifiers).
 */
class ResourceIdentifier extends ChromeObject {
  ResourceIdentifier({String id, String description}) {
    if (id != null) this.id = id;
    if (description != null) this.description = description;
  }
  ResourceIdentifier.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The resource identifier for the given content type.
   */
  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  /**
   * A human readable description of the resource.
   */
  String get description => jsProxy['description'];
  set description(String value) => jsProxy['description'] = value;
}

class ContentSetting extends ChromeObject {
  ContentSetting();
  ContentSetting.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Clear all content setting rules set by this extension.
   */
  Future clear(ContentSettingsClearParams details) {
    var completer = new ChromeCompleter.noArgs();
    jsProxy.callMethod('clear', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Gets the current content setting for a given pair of URLs.
   */
  Future<Map> get(ContentSettingsGetParams details) {
    var completer = new ChromeCompleter<Map>.oneArg(mapify);
    jsProxy.callMethod('get', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Applies a new content setting rule.
   */
  Future set(ContentSettingsSetParams details) {
    var completer = new ChromeCompleter.noArgs();
    jsProxy.callMethod('set', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Returns:
   * A list of resource identifiers for this content type, or [undefined] if
   * this content type does not use resource identifiers.
   */
  Future<List<ResourceIdentifier>> getResourceIdentifiers() {
    var completer = new ChromeCompleter<List<ResourceIdentifier>>.oneArg((e) => listify(e, _createResourceIdentifier));
    jsProxy.callMethod('getResourceIdentifiers', [completer.callback]);
    return completer.future;
  }
}

class ContentSettingsClearParams extends ChromeObject {
  ContentSettingsClearParams({Scope scope}) {
    if (scope != null) this.scope = scope;
  }
  ContentSettingsClearParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Where to clear the setting (default: regular).
   */
  Scope get scope => _createScope(jsProxy['scope']);
  set scope(Scope value) => jsProxy['scope'] = jsify(value);
}

class ContentSettingsGetParams extends ChromeObject {
  ContentSettingsGetParams({String primaryUrl, String secondaryUrl, ResourceIdentifier resourceIdentifier, bool incognito}) {
    if (primaryUrl != null) this.primaryUrl = primaryUrl;
    if (secondaryUrl != null) this.secondaryUrl = secondaryUrl;
    if (resourceIdentifier != null) this.resourceIdentifier = resourceIdentifier;
    if (incognito != null) this.incognito = incognito;
  }
  ContentSettingsGetParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The primary URL for which the content setting should be retrieved. Note
   * that the meaning of a primary URL depends on the content type.
   */
  String get primaryUrl => jsProxy['primaryUrl'];
  set primaryUrl(String value) => jsProxy['primaryUrl'] = value;

  /**
   * The secondary URL for which the content setting should be retrieved.
   * Defaults to the primary URL. Note that the meaning of a secondary URL
   * depends on the content type, and not all content types use secondary URLs.
   */
  String get secondaryUrl => jsProxy['secondaryUrl'];
  set secondaryUrl(String value) => jsProxy['secondaryUrl'] = value;

  /**
   * A more specific identifier of the type of content for which the settings
   * should be retrieved.
   */
  ResourceIdentifier get resourceIdentifier => _createResourceIdentifier(jsProxy['resourceIdentifier']);
  set resourceIdentifier(ResourceIdentifier value) => jsProxy['resourceIdentifier'] = jsify(value);

  /**
   * Whether to check the content settings for an incognito session. (default
   * false)
   */
  bool get incognito => jsProxy['incognito'];
  set incognito(bool value) => jsProxy['incognito'] = value;
}

class ContentSettingsSetParams extends ChromeObject {
  ContentSettingsSetParams({String primaryPattern, String secondaryPattern, ResourceIdentifier resourceIdentifier, var setting, Scope scope}) {
    if (primaryPattern != null) this.primaryPattern = primaryPattern;
    if (secondaryPattern != null) this.secondaryPattern = secondaryPattern;
    if (resourceIdentifier != null) this.resourceIdentifier = resourceIdentifier;
    if (setting != null) this.setting = setting;
    if (scope != null) this.scope = scope;
  }
  ContentSettingsSetParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The pattern for the primary URL. For details on the format of a pattern,
   * see [Content Setting Patterns](contentSettings#patterns).
   */
  String get primaryPattern => jsProxy['primaryPattern'];
  set primaryPattern(String value) => jsProxy['primaryPattern'] = value;

  /**
   * The pattern for the secondary URL. Defaults to matching all URLs. For
   * details on the format of a pattern, see [Content Setting
   * Patterns](contentSettings#patterns).
   */
  String get secondaryPattern => jsProxy['secondaryPattern'];
  set secondaryPattern(String value) => jsProxy['secondaryPattern'] = value;

  /**
   * The resource identifier for the content type.
   */
  ResourceIdentifier get resourceIdentifier => _createResourceIdentifier(jsProxy['resourceIdentifier']);
  set resourceIdentifier(ResourceIdentifier value) => jsProxy['resourceIdentifier'] = jsify(value);

  /**
   * The setting applied by this rule. See the description of the individual
   * ContentSetting objects for the possible values.
   */
  dynamic get setting => jsProxy['setting'];
  set setting(var value) => jsProxy['setting'] = jsify(value);

  /**
   * Where to set the setting (default: regular).
   */
  Scope get scope => _createScope(jsProxy['scope']);
  set scope(Scope value) => jsProxy['scope'] = jsify(value);
}

ContentSetting _createContentSetting(JsObject jsProxy) => jsProxy == null ? null : new ContentSetting.fromProxy(jsProxy);
ResourceIdentifier _createResourceIdentifier(JsObject jsProxy) => jsProxy == null ? null : new ResourceIdentifier.fromProxy(jsProxy);
Scope _createScope(String value) => Scope.VALUES.singleWhere((ChromeEnum e) => e.value == value);
