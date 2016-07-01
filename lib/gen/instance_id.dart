/* This file has been generated from instance_id.json - do not edit */

/**
 * Use `chrome.instanceID` to access the Instance ID service.
 */
library chrome.instanceID;

import '../src/common.dart';

/**
 * Accessor for the `chrome.instanceID` namespace.
 */
final ChromeInstanceID instanceID = new ChromeInstanceID._();

class ChromeInstanceID extends ChromeApi {
  JsObject get _instanceID => chrome['instanceID'];

  /**
   * Fired when all the granted tokens need to be refreshed.
   */
  Stream get onTokenRefresh => _onTokenRefresh.stream;
  ChromeStreamController _onTokenRefresh;

  ChromeInstanceID._() {
    var getApi = () => _instanceID;
    _onTokenRefresh = new ChromeStreamController.noArgs(getApi, 'onTokenRefresh');
  }

  bool get available => _instanceID != null;

  /**
   * Retrieves an identifier for the app instance. The instance ID will be
   * returned by the `callback`. The same ID will be returned as long as the
   * application identity has not been revoked or expired.
   * 
   * Returns:
   * An Instance ID assigned to the app instance.
   */
  Future<String> getID() {
    if (_instanceID == null) _throwNotAvailable();

    var completer = new ChromeCompleter<String>.oneArg();
    _instanceID.callMethod('getID', [completer.callback]);
    return completer.future;
  }

  /**
   * Retrieves the time when the InstanceID has been generated. The creation
   * time will be returned by the `callback`.
   * 
   * Returns:
   * The time when the Instance ID has been generated, represented in
   * milliseconds since the epoch.
   */
  Future<dynamic> getCreationTime() {
    if (_instanceID == null) _throwNotAvailable();

    var completer = new ChromeCompleter<dynamic>.oneArg();
    _instanceID.callMethod('getCreationTime', [completer.callback]);
    return completer.future;
  }

  /**
   * Return a token that allows the authorized entity to access the service
   * defined by scope.
   * 
   * [getTokenParams] Parameters for getToken.
   * 
   * Returns:
   * A token assigned by the requested service.
   */
  Future<String> getToken(InstanceIDGetTokenParams getTokenParams) {
    if (_instanceID == null) _throwNotAvailable();

    var completer = new ChromeCompleter<String>.oneArg();
    _instanceID.callMethod('getToken', [jsify(getTokenParams), completer.callback]);
    return completer.future;
  }

  /**
   * Revokes a granted token.
   * 
   * [deleteTokenParams] Parameters for deleteToken.
   */
  Future deleteToken(InstanceIDDeleteTokenParams deleteTokenParams) {
    if (_instanceID == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _instanceID.callMethod('deleteToken', [jsify(deleteTokenParams), completer.callback]);
    return completer.future;
  }

  /**
   * Resets the app instance identifier and revokes all tokens associated with
   * it.
   */
  Future deleteID() {
    if (_instanceID == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _instanceID.callMethod('deleteID', [completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.instanceID' is not available");
  }
}

class InstanceIDGetTokenParams extends ChromeObject {
  InstanceIDGetTokenParams({String authorizedEntity, String scope, Map options}) {
    if (authorizedEntity != null) this.authorizedEntity = authorizedEntity;
    if (scope != null) this.scope = scope;
    if (options != null) this.options = options;
  }
  InstanceIDGetTokenParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Identifies the entity that is authorized to access resources associated
   * with this Instance ID. It can be a project ID from [Google developer
   * console](https://code.google.com/apis/console).
   */
  String get authorizedEntity => jsProxy['authorizedEntity'];
  set authorizedEntity(String value) => jsProxy['authorizedEntity'] = value;

  /**
   * Identifies authorized actions that the authorized entity can take. E.g. for
   * sending GCM messages, `GCM` scope should be used.
   */
  String get scope => jsProxy['scope'];
  set scope(String value) => jsProxy['scope'] = value;

  /**
   * Allows including a small number of string key/value pairs that will be
   * associated with the token and may be used in processing the request.
   */
  Map get options => mapify(jsProxy['options']);
  set options(Map value) => jsProxy['options'] = jsify(value);
}

class InstanceIDDeleteTokenParams extends ChromeObject {
  InstanceIDDeleteTokenParams({String authorizedEntity, String scope}) {
    if (authorizedEntity != null) this.authorizedEntity = authorizedEntity;
    if (scope != null) this.scope = scope;
  }
  InstanceIDDeleteTokenParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The authorized entity that is used to obtain the token.
   */
  String get authorizedEntity => jsProxy['authorizedEntity'];
  set authorizedEntity(String value) => jsProxy['authorizedEntity'] = value;

  /**
   * The scope that is used to obtain the token.
   */
  String get scope => jsProxy['scope'];
  set scope(String value) => jsProxy['scope'] = value;
}
