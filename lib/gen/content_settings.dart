/* This file has been generated from content_settings.json - do not edit */

/**
 * Use the `chrome.contentSettings` API to change settings that control whether
 * websites can use features such as cookies, JavaScript, and plug-ins. More
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
  static final JsObject _contentSettings = chrome['contentSettings'];

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
   * show images. <br>Default is [allow].<br>The primary URL is the main-frame
   * URL. The secondary URL is the URL of the image.
   */
  ContentSetting get images => _createContentSetting(_contentSettings['images']);

  /**
   * Whether to run JavaScript. One of<br>[allow]: Run JavaScript,<br>[block]:
   * Don't run JavaScript. <br>Default is [allow].<br>The primary URL is the
   * main-frame URL. The secondary URL is not used.
   */
  ContentSetting get javascript => _createContentSetting(_contentSettings['javascript']);

  /**
   * Whether to run plug-ins. One of<br>[allow]: Run plug-ins
   * automatically,<br>[block]: Don't run plug-ins automatically. <br>Default is
   * [allow].<br>The primary URL is the main-frame URL. The secondary URL is not
   * used.
   */
  ContentSetting get plugins => _createContentSetting(_contentSettings['plugins']);

  /**
   * Whether to allow sites to show pop-ups. One of<br>[allow]: Allow sites to
   * show pop-ups,<br>[block]: Don't allow sites to show pop-ups. <br>Default is
   * [block].<br>The primary URL is the main-frame URL. The secondary URL is not
   * used.
   */
  ContentSetting get popups => _createContentSetting(_contentSettings['popups']);

  /**
   * Whether to allow sites to show desktop notifications. One of<br>[allow]:
   * Allow sites to show desktop notifications,<br>[block]: Don't allow sites to
   * show desktop notifications,<br>[ask]: Ask when a site wants to show desktop
   * notifications. <br>Default is [ask].<br>The primary URL is the main-frame
   * URL. The secondary URL is not used.
   */
  ContentSetting get notifications => _createContentSetting(_contentSettings['notifications']);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.contentSettings' is not available");
  }
}

/**
 * The only content type using resource identifiers is
 * [contentSettings.plugins.] For more information, see [Resource
 * Identifiers](contentSettings.html#resource-identifiers).
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
  ContentSettingsClearParams({String scope}) {
    if (scope != null) this.scope = scope;
  }
  ContentSettingsClearParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Where to clear the setting (default: regular). One of<br>[regular]: setting
   * for regular profile (which is inherited by the incognito profile if not
   * overridden elsewhere),<br>[incognito_session_only]: setting for incognito
   * profile that can only be set during an incognito session and is deleted
   * when the incognito session ends (overrides regular settings).
   * enum of `regular`, `incognito_session_only`
   */
  String get scope => jsProxy['scope'];
  set scope(String value) => jsProxy['scope'] = value;
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
  ContentSettingsSetParams({String primaryPattern, String secondaryPattern, ResourceIdentifier resourceIdentifier, var setting, String scope}) {
    if (primaryPattern != null) this.primaryPattern = primaryPattern;
    if (secondaryPattern != null) this.secondaryPattern = secondaryPattern;
    if (resourceIdentifier != null) this.resourceIdentifier = resourceIdentifier;
    if (setting != null) this.setting = setting;
    if (scope != null) this.scope = scope;
  }
  ContentSettingsSetParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The pattern for the primary URL. For details on the format of a pattern,
   * see [Content Setting Patterns](contentSettings.html#patterns).
   */
  String get primaryPattern => jsProxy['primaryPattern'];
  set primaryPattern(String value) => jsProxy['primaryPattern'] = value;

  /**
   * The pattern for the secondary URL. Defaults to matching all URLs. For
   * details on the format of a pattern, see [Content Setting
   * Patterns](contentSettings.html#patterns).
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
   * Where to set the setting (default: regular). One of<br>[regular]: setting
   * for regular profile (which is inherited by the incognito profile if not
   * overridden elsewhere),<br>[incognito_session_only]: setting for incognito
   * profile that can only be set during an incognito session and is deleted
   * when the incognito session ends (overrides regular settings).
   * enum of `regular`, `incognito_session_only`
   */
  String get scope => jsProxy['scope'];
  set scope(String value) => jsProxy['scope'] = value;
}

ContentSetting _createContentSetting(JsObject jsProxy) => jsProxy == null ? null : new ContentSetting.fromProxy(jsProxy);
ResourceIdentifier _createResourceIdentifier(JsObject jsProxy) => jsProxy == null ? null : new ResourceIdentifier.fromProxy(jsProxy);
