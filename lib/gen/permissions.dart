/* This file has been generated from permissions.json - do not edit */

/**
 * Use the `chrome.permissions` API to request [declared optional
 * permissions](#manifest) at run time rather than install time, so users
 * understand why the permissions are needed and grant only those that are
 * necessary.
 */
library chrome.permissions;

import '../src/common.dart';

/**
 * Accessor for the `chrome.permissions` namespace.
 */
final ChromePermissions permissions = new ChromePermissions._();

class ChromePermissions extends ChromeApi {
  static final JsObject _permissions = chrome['permissions'];

  ChromePermissions._();

  bool get available => _permissions != null;

  /**
   * Gets the extension's current set of permissions.
   * 
   * Returns:
   * The extension's active permissions.
   */
  Future<Permissions> getAll() {
    if (_permissions == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Permissions>.oneArg(_createPermissions);
    _permissions.callMethod('getAll', [completer.callback]);
    return completer.future;
  }

  /**
   * Checks if the extension has the specified permissions.
   * 
   * Returns:
   * True if the extension has the specified permissions.
   */
  Future<bool> contains(Permissions permissions) {
    if (_permissions == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _permissions.callMethod('contains', [jsify(permissions), completer.callback]);
    return completer.future;
  }

  /**
   * Requests access to the specified permissions. These permissions must be
   * defined in the optional_permissions field of the manifest. If there are any
   * problems requesting the permissions, [runtime.lastError] will be set.
   * 
   * Returns:
   * True if the user granted the specified permissions.
   */
  Future<bool> request(Permissions permissions) {
    if (_permissions == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _permissions.callMethod('request', [jsify(permissions), completer.callback]);
    return completer.future;
  }

  /**
   * Removes access to the specified permissions. If there are any problems
   * removing the permissions, [runtime.lastError] will be set.
   * 
   * Returns:
   * True if the permissions were removed.
   */
  Future<bool> remove(Permissions permissions) {
    if (_permissions == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _permissions.callMethod('remove', [jsify(permissions), completer.callback]);
    return completer.future;
  }

  /**
   * Fired when the extension acquires new permissions.
   */
  Stream<Permissions> get onAdded => _onAdded.stream;

  final ChromeStreamController<Permissions> _onAdded =
      new ChromeStreamController<Permissions>.oneArg(_permissions, 'onAdded', _createPermissions);

  /**
   * Fired when access to permissions has been removed from the extension.
   */
  Stream<Permissions> get onRemoved => _onRemoved.stream;

  final ChromeStreamController<Permissions> _onRemoved =
      new ChromeStreamController<Permissions>.oneArg(_permissions, 'onRemoved', _createPermissions);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.permissions' is not available");
  }
}

class Permissions extends ChromeObject {
  Permissions({List<String> permissions, List<String> origins}) {
    if (permissions != null) this.permissions = permissions;
    if (origins != null) this.origins = origins;
  }
  Permissions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * List of named permissions (does not include hosts or origins).
   */
  List<String> get permissions => listify(jsProxy['permissions']);
  set permissions(List<String> value) => jsProxy['permissions'] = jsify(value);

  /**
   * List of origin permissions.
   */
  List<String> get origins => listify(jsProxy['origins']);
  set origins(List<String> value) => jsProxy['origins'] = jsify(value);
}

Permissions _createPermissions(JsObject jsProxy) => jsProxy == null ? null : new Permissions.fromProxy(jsProxy);
