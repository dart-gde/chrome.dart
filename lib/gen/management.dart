/* This file has been generated from management.json - do not edit */

/**
 * The `chrome.management` API provides ways to manage the list of
 * extensions/apps that are installed and running. It is particularly useful for
 * extensions that [override](override.html) the built-in New Tab page.
 */
library chrome.management;

import '../src/common.dart';

/**
 * Accessor for the `chrome.management` namespace.
 */
final ChromeManagement management = new ChromeManagement._();

class ChromeManagement extends ChromeApi {
  static final JsObject _management = chrome['management'];

  ChromeManagement._();

  bool get available => _management != null;

  /**
   * Returns a list of information about installed extensions and apps.
   */
  Future<List<ExtensionInfo>> getAll() {
    if (_management == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<ExtensionInfo>>.oneArg((e) => listify(e, _createExtensionInfo));
    _management.callMethod('getAll', [completer.callback]);
    return completer.future;
  }

  /**
   * Returns information about the installed extension, app, or theme that has
   * the given ID.
   * 
   * [id] The ID from an item of [ExtensionInfo.]
   */
  Future<ExtensionInfo> get(String id) {
    if (_management == null) _throwNotAvailable();

    var completer = new ChromeCompleter<ExtensionInfo>.oneArg(_createExtensionInfo);
    _management.callMethod('get', [id, completer.callback]);
    return completer.future;
  }

  /**
   * Returns a list of [permission warnings](permission_warnings.html) for the
   * given extension id.
   * 
   * [id] The ID of an already installed extension.
   */
  Future<List<String>> getPermissionWarningsById(String id) {
    if (_management == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<String>>.oneArg(listify);
    _management.callMethod('getPermissionWarningsById', [id, completer.callback]);
    return completer.future;
  }

  /**
   * Returns a list of [permission warnings](permission_warnings.html) for the
   * given extension manifest string. Note: This function can be used without
   * requesting the 'management' permission in the manifest.
   * 
   * [manifestStr] Extension manifest JSON string.
   */
  Future<List<String>> getPermissionWarningsByManifest(String manifestStr) {
    if (_management == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<String>>.oneArg(listify);
    _management.callMethod('getPermissionWarningsByManifest', [manifestStr, completer.callback]);
    return completer.future;
  }

  /**
   * Enables or disables an app or extension.
   * 
   * [id] This should be the id from an item of [ExtensionInfo.]
   * 
   * [enabled] Whether this item should be enabled or disabled.
   */
  Future setEnabled(String id, bool enabled) {
    if (_management == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _management.callMethod('setEnabled', [id, enabled, completer.callback]);
    return completer.future;
  }

  /**
   * Uninstalls a currently installed app or extension.
   * 
   * [id] This should be the id from an item of [ExtensionInfo.]
   */
  Future uninstall(String id, [ManagementUninstallParams options]) {
    if (_management == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _management.callMethod('uninstall', [id, jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Uninstalls the calling extension. Note: This function can be used without
   * requesting the 'management' permission in the manifest.
   */
  Future uninstallSelf([ManagementUninstallSelfParams options]) {
    if (_management == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _management.callMethod('uninstallSelf', [jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Launches an application.
   * 
   * [id] The extension id of the application.
   */
  Future launchApp(String id) {
    if (_management == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _management.callMethod('launchApp', [id, completer.callback]);
    return completer.future;
  }

  /**
   * Fired when an app or extension has been installed.
   */
  Stream<ExtensionInfo> get onInstalled => _onInstalled.stream;

  final ChromeStreamController<ExtensionInfo> _onInstalled =
      new ChromeStreamController<ExtensionInfo>.oneArg(_management, 'onInstalled', _createExtensionInfo);

  /**
   * Fired when an app or extension has been uninstalled.
   */
  Stream<String> get onUninstalled => _onUninstalled.stream;

  final ChromeStreamController<String> _onUninstalled =
      new ChromeStreamController<String>.oneArg(_management, 'onUninstalled', selfConverter);

  /**
   * Fired when an app or extension has been enabled.
   */
  Stream<ExtensionInfo> get onEnabled => _onEnabled.stream;

  final ChromeStreamController<ExtensionInfo> _onEnabled =
      new ChromeStreamController<ExtensionInfo>.oneArg(_management, 'onEnabled', _createExtensionInfo);

  /**
   * Fired when an app or extension has been disabled.
   */
  Stream<ExtensionInfo> get onDisabled => _onDisabled.stream;

  final ChromeStreamController<ExtensionInfo> _onDisabled =
      new ChromeStreamController<ExtensionInfo>.oneArg(_management, 'onDisabled', _createExtensionInfo);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.management' is not available");
  }
}

/**
 * Information about an icon belonging to an extension, app, or theme.
 */
class IconInfo extends ChromeObject {
  IconInfo({int size, String url}) {
    if (size != null) this.size = size;
    if (url != null) this.url = url;
  }
  IconInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * A number representing the width and height of the icon. Likely values
   * include (but are not limited to) 128, 48, 24, and 16.
   */
  int get size => jsProxy['size'];
  set size(int value) => jsProxy['size'] = value;

  /**
   * The URL for this icon image. To display a grayscale version of the icon (to
   * indicate that an extension is disabled, for example), append
   * `?grayscale=true` to the URL.
   */
  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;
}

/**
 * Information about an installed extension, app, or theme.
 */
class ExtensionInfo extends ChromeObject {
  ExtensionInfo({String id, String name, String shortName, String description, String version, bool mayDisable, bool enabled, String disabledReason, String type, String appLaunchUrl, String homepageUrl, String updateUrl, bool offlineEnabled, String optionsUrl, List<IconInfo> icons, List<String> permissions, List<String> hostPermissions, String installType}) {
    if (id != null) this.id = id;
    if (name != null) this.name = name;
    if (shortName != null) this.shortName = shortName;
    if (description != null) this.description = description;
    if (version != null) this.version = version;
    if (mayDisable != null) this.mayDisable = mayDisable;
    if (enabled != null) this.enabled = enabled;
    if (disabledReason != null) this.disabledReason = disabledReason;
    if (type != null) this.type = type;
    if (appLaunchUrl != null) this.appLaunchUrl = appLaunchUrl;
    if (homepageUrl != null) this.homepageUrl = homepageUrl;
    if (updateUrl != null) this.updateUrl = updateUrl;
    if (offlineEnabled != null) this.offlineEnabled = offlineEnabled;
    if (optionsUrl != null) this.optionsUrl = optionsUrl;
    if (icons != null) this.icons = icons;
    if (permissions != null) this.permissions = permissions;
    if (hostPermissions != null) this.hostPermissions = hostPermissions;
    if (installType != null) this.installType = installType;
  }
  ExtensionInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The extension's unique identifier.
   */
  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  /**
   * The name of this extension, app, or theme.
   */
  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  /**
   * A short version of the name of this extension, app, or theme.
   */
  String get shortName => jsProxy['shortName'];
  set shortName(String value) => jsProxy['shortName'] = value;

  /**
   * The description of this extension, app, or theme.
   */
  String get description => jsProxy['description'];
  set description(String value) => jsProxy['description'] = value;

  /**
   * The [version](manifest/version.html) of this extension, app, or theme.
   */
  String get version => jsProxy['version'];
  set version(String value) => jsProxy['version'] = value;

  /**
   * Whether this extension can be disabled or uninstalled by the user.
   */
  bool get mayDisable => jsProxy['mayDisable'];
  set mayDisable(bool value) => jsProxy['mayDisable'] = value;

  /**
   * Whether it is currently enabled or disabled.
   */
  bool get enabled => jsProxy['enabled'];
  set enabled(bool value) => jsProxy['enabled'] = value;

  /**
   * A reason the item is disabled.
   * enum of `unknown`, `permissions_increase`
   */
  String get disabledReason => jsProxy['disabledReason'];
  set disabledReason(String value) => jsProxy['disabledReason'] = value;

  /**
   * The type of this extension, app, or theme.
   * enum of `extension`, `hosted_app`, `packaged_app`, `legacy_packaged_app`,
   * `theme`
   */
  String get type => jsProxy['type'];
  set type(String value) => jsProxy['type'] = value;

  /**
   * The launch url (only present for apps).
   */
  String get appLaunchUrl => jsProxy['appLaunchUrl'];
  set appLaunchUrl(String value) => jsProxy['appLaunchUrl'] = value;

  /**
   * The URL of the homepage of this extension, app, or theme.
   */
  String get homepageUrl => jsProxy['homepageUrl'];
  set homepageUrl(String value) => jsProxy['homepageUrl'] = value;

  /**
   * The update URL of this extension, app, or theme.
   */
  String get updateUrl => jsProxy['updateUrl'];
  set updateUrl(String value) => jsProxy['updateUrl'] = value;

  /**
   * Whether the extension, app, or theme declares that it supports offline.
   */
  bool get offlineEnabled => jsProxy['offlineEnabled'];
  set offlineEnabled(bool value) => jsProxy['offlineEnabled'] = value;

  /**
   * The url for the item's options page, if it has one.
   */
  String get optionsUrl => jsProxy['optionsUrl'];
  set optionsUrl(String value) => jsProxy['optionsUrl'] = value;

  /**
   * A list of icon information. Note that this just reflects what was declared
   * in the manifest, and the actual image at that url may be larger or smaller
   * than what was declared, so you might consider using explicit width and
   * height attributes on img tags referencing these images. See the [manifest
   * documentation on icons](manifest/icons.html) for more details.
   */
  List<IconInfo> get icons => listify(jsProxy['icons'], _createIconInfo);
  set icons(List<IconInfo> value) => jsProxy['icons'] = jsify(value);

  /**
   * Returns a list of API based permissions.
   */
  List<String> get permissions => listify(jsProxy['permissions']);
  set permissions(List<String> value) => jsProxy['permissions'] = jsify(value);

  /**
   * Returns a list of host based permissions.
   */
  List<String> get hostPermissions => listify(jsProxy['hostPermissions']);
  set hostPermissions(List<String> value) => jsProxy['hostPermissions'] = jsify(value);

  /**
   * How the extension was installed. One of<br>[admin]: The extension was
   * installed because of an administrative policy,<br>[development]: The
   * extension was loaded unpacked in developer mode,<br>[normal]: The extension
   * was installed normally via a .crx file,<br>[sideload]: The extension was
   * installed by other software on the machine,<br>[other]: The extension was
   * installed by other means.
   * enum of `admin`, `development`, `normal`, `sideload`, `other`
   */
  String get installType => jsProxy['installType'];
  set installType(String value) => jsProxy['installType'] = value;
}

class ManagementUninstallParams extends ChromeObject {
  ManagementUninstallParams({bool showConfirmDialog}) {
    if (showConfirmDialog != null) this.showConfirmDialog = showConfirmDialog;
  }
  ManagementUninstallParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Whether or not a confirm-uninstall dialog should prompt the user. Defaults
   * to false.
   */
  bool get showConfirmDialog => jsProxy['showConfirmDialog'];
  set showConfirmDialog(bool value) => jsProxy['showConfirmDialog'] = value;
}

class ManagementUninstallSelfParams extends ChromeObject {
  ManagementUninstallSelfParams({bool showConfirmDialog}) {
    if (showConfirmDialog != null) this.showConfirmDialog = showConfirmDialog;
  }
  ManagementUninstallSelfParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Whether or not a confirm-uninstall dialog should prompt the user. Defaults
   * to false.
   */
  bool get showConfirmDialog => jsProxy['showConfirmDialog'];
  set showConfirmDialog(bool value) => jsProxy['showConfirmDialog'] = value;
}

ExtensionInfo _createExtensionInfo(JsObject jsProxy) => jsProxy == null ? null : new ExtensionInfo.fromProxy(jsProxy);
IconInfo _createIconInfo(JsObject jsProxy) => jsProxy == null ? null : new IconInfo.fromProxy(jsProxy);
