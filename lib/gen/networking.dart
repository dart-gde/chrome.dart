/* This file has been generated - do not edit */

library chrome.networking;

import '../src/common.dart';

final ChromeNetworking networking = new ChromeNetworking._();

class ChromeNetworking {
  ChromeNetworking._();

  /**
   * Accessor for the `chrome.networking.config` namespace.
   */
  final ChromeNetworkingConfig config = new ChromeNetworkingConfig._();
}

/**
 * Use the `networking.config` API to authenticate to captive portals.
 */
class ChromeNetworkingConfig extends ChromeApi {
  JsObject get _networking_config => chrome['networking']['config'];

  Stream<NetworkInfo> get onCaptivePortalDetected => _onCaptivePortalDetected.stream;
  ChromeStreamController<NetworkInfo> _onCaptivePortalDetected;

  ChromeNetworkingConfig._() {
    var getApi = () => _networking_config;
    _onCaptivePortalDetected = new ChromeStreamController<NetworkInfo>.oneArg(getApi, 'onCaptivePortalDetected', _createNetworkInfo);
  }

  bool get available => _networking_config != null;

  /**
   * Allows an extension to define network filters for the networks it can
   * handle. A call to this function will remove all filters previously
   * installed by the extension before setting the new list.
   * [networks]: Network filters to set. Every `NetworkInfo` must either have
   * the `SSID` or `HexSSID` set. Other fields will be ignored.
   * [callback]: Called back when this operation is finished.
   */
  Future setNetworkFilter(List<NetworkInfo> networks) {
    if (_networking_config == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _networking_config.callMethod('setNetworkFilter', [jsify(networks), completer.callback]);
    return completer.future;
  }

  /**
   * Called by the extension to notify the network config API that it finished a
   * captive portal authentication attempt and hand over the result of the
   * attempt. This function must only be called with the GUID of the latest
   * [onCaptivePortalDetected] event.
   * [GUID]: Unique network identifier obtained from [onCaptivePortalDetected].
   * [result]: The result of the authentication attempt.
   * [callback]: Called back when this operation is finished.
   */
  Future finishAuthentication(String GUID, AuthenticationResult result) {
    if (_networking_config == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _networking_config.callMethod('finishAuthentication', [GUID, jsify(result), completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.networking.config' is not available");
  }
}

/**
 * Indicator for the type of network used in [NetworkInfo].
 */
class NetworkType extends ChromeEnum {
  static const NetworkType _WI_FI = const NetworkType._('WiFi');

  static const List<NetworkType> VALUES = const[_WI_FI];

  const NetworkType._(String str): super(str);
}

/**
 * Argument to [finishAuthentication] indicating the result of the captive
 * portal authentication attempt.
 */
class AuthenticationResult extends ChromeEnum {
  static const AuthenticationResult UNHANDLED = const AuthenticationResult._('unhandled');
  static const AuthenticationResult SUCCEEDED = const AuthenticationResult._('succeeded');
  static const AuthenticationResult REJECTED = const AuthenticationResult._('rejected');
  static const AuthenticationResult FAILED = const AuthenticationResult._('failed');

  static const List<AuthenticationResult> VALUES = const[UNHANDLED, SUCCEEDED, REJECTED, FAILED];

  const AuthenticationResult._(String str): super(str);
}

/**
 * A dictionary identifying filtered networks. One of `GUID`, `SSID` or
 * `HexSSID` must be set. `BSSID` and `Security` are ignored when filtering
 * networks.
 */
class NetworkInfo extends ChromeObject {
  NetworkInfo({NetworkType Type, String GUID, String HexSSID, String SSID, String BSSID, String Security}) {
    if (Type != null) this.Type = Type;
    if (GUID != null) this.GUID = GUID;
    if (HexSSID != null) this.HexSSID = HexSSID;
    if (SSID != null) this.SSID = SSID;
    if (BSSID != null) this.BSSID = BSSID;
    if (Security != null) this.Security = Security;
  }
  NetworkInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  NetworkType get Type => _createNetworkType(jsProxy['Type']);
  set Type(NetworkType value) => jsProxy['Type'] = jsify(value);

  String get GUID => jsProxy['GUID'];
  set GUID(String value) => jsProxy['GUID'] = value;

  String get HexSSID => jsProxy['HexSSID'];
  set HexSSID(String value) => jsProxy['HexSSID'] = value;

  String get SSID => jsProxy['SSID'];
  set SSID(String value) => jsProxy['SSID'] = value;

  String get BSSID => jsProxy['BSSID'];
  set BSSID(String value) => jsProxy['BSSID'] = value;

  String get Security => jsProxy['Security'];
  set Security(String value) => jsProxy['Security'] = value;
}

NetworkInfo _createNetworkInfo(JsObject jsProxy) => jsProxy == null ? null : new NetworkInfo.fromProxy(jsProxy);
NetworkType _createNetworkType(String value) => NetworkType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
