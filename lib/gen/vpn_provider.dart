/* This file has been generated from vpn_provider.idl - do not edit */

/**
 * Use the `chrome.vpnProvider` API to implement a VPN client.
 */
library chrome.vpnProvider;

import '../src/common.dart';

/**
 * Accessor for the `chrome.vpnProvider` namespace.
 */
final ChromeVpnProvider vpnProvider = new ChromeVpnProvider._();

class ChromeVpnProvider extends ChromeApi {
  JsObject get _vpnProvider => chrome['vpnProvider'];

  Stream<OnPlatformMessageEvent> get onPlatformMessage => _onPlatformMessage.stream;
  ChromeStreamController<OnPlatformMessageEvent> _onPlatformMessage;

  Stream<ArrayBuffer> get onPacketReceived => _onPacketReceived.stream;
  ChromeStreamController<ArrayBuffer> _onPacketReceived;

  Stream<String> get onConfigRemoved => _onConfigRemoved.stream;
  ChromeStreamController<String> _onConfigRemoved;

  Stream<OnConfigCreatedEvent> get onConfigCreated => _onConfigCreated.stream;
  ChromeStreamController<OnConfigCreatedEvent> _onConfigCreated;

  Stream<OnUIEventEvent> get onUIEvent => _onUIEvent.stream;
  ChromeStreamController<OnUIEventEvent> _onUIEvent;

  ChromeVpnProvider._() {
    var getApi = () => _vpnProvider;
    _onPlatformMessage = new ChromeStreamController<OnPlatformMessageEvent>.threeArgs(getApi, 'onPlatformMessage', _createOnPlatformMessageEvent);
    _onPacketReceived = new ChromeStreamController<ArrayBuffer>.oneArg(getApi, 'onPacketReceived', _createArrayBuffer);
    _onConfigRemoved = new ChromeStreamController<String>.oneArg(getApi, 'onConfigRemoved', selfConverter);
    _onConfigCreated = new ChromeStreamController<OnConfigCreatedEvent>.threeArgs(getApi, 'onConfigCreated', _createOnConfigCreatedEvent);
    _onUIEvent = new ChromeStreamController<OnUIEventEvent>.twoArgs(getApi, 'onUIEvent', _createOnUIEventEvent);
  }

  bool get available => _vpnProvider != null;

  /**
   * Creates a new VPN configuration that persists across multiple login
   * sessions of the user.
   * [name]: The name of the VPN configuration.
   * [callback]: Called when the configuration is created or if there is an
   * error.
   * 
   * Returns:
   * The callback is used by `createConfig` to signal completion. The callback
   * is called with `chrome.runtime.lastError` set to an error code if there is
   * an error.
   * [id]: A unique ID for the created configuration, empty string on failure.
   */
  Future<String> createConfig(String name) {
    if (_vpnProvider == null) _throwNotAvailable();

    var completer = new ChromeCompleter<String>.oneArg();
    _vpnProvider.callMethod('createConfig', [name, completer.callback]);
    return completer.future;
  }

  /**
   * Destroys a VPN configuration created by the extension.
   * [id]: ID of the VPN configuration to destroy.
   * [callback]: Called when the configuration is destroyed or if there is an
   * error.
   */
  Future destroyConfig(String id) {
    if (_vpnProvider == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _vpnProvider.callMethod('destroyConfig', [id, completer.callback]);
    return completer.future;
  }

  /**
   * Sets the parameters for the VPN session. This should be called immediately
   * after `"connected"` is received from the platform. This will succeed only
   * when the VPN session is owned by the extension.
   * [parameters]: The parameters for the VPN session.
   * [callback]: Called when the parameters are set or if there is an error.
   */
  Future setParameters(Parameters parameters) {
    if (_vpnProvider == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _vpnProvider.callMethod('setParameters', [jsify(parameters), completer.callback]);
    return completer.future;
  }

  /**
   * Sends an IP packet through the tunnel created for the VPN session. This
   * will succeed only when the VPN session is owned by the extension.
   * [data]: The IP packet to be sent to the platform.
   * [callback]: Called when the packet is sent or if there is an error.
   */
  Future sendPacket(ArrayBuffer data) {
    if (_vpnProvider == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _vpnProvider.callMethod('sendPacket', [jsify(data), completer.callback]);
    return completer.future;
  }

  /**
   * Notifies the VPN session state to the platform. This will succeed only when
   * the VPN session is owned by the extension.
   * [state]: The VPN session state of the VPN client.
   * [callback]: Called when the notification is complete or if there is an
   * error.
   */
  Future notifyConnectionStateChanged(VpnConnectionState state) {
    if (_vpnProvider == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _vpnProvider.callMethod('notifyConnectionStateChanged', [jsify(state), completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.vpnProvider' is not available");
  }
}

class OnPlatformMessageEvent {
  final String id;

  final PlatformMessage message;

  final String error;

  OnPlatformMessageEvent(this.id, this.message, this.error);
}

class OnConfigCreatedEvent {
  final String id;

  final String name;

  final dynamic data;

  OnConfigCreatedEvent(this.id, this.name, this.data);
}

class OnUIEventEvent {
  final UIEvent event;

  /**
   * `optional`
   */
  final String id;

  OnUIEventEvent(this.event, this.id);
}

/**
 * The enum is used by the platform to notify the client of the VPN session
 * status.
 */
class PlatformMessage extends ChromeEnum {
  static const PlatformMessage CONNECTED = const PlatformMessage._('connected');
  static const PlatformMessage DISCONNECTED = const PlatformMessage._('disconnected');
  static const PlatformMessage ERROR = const PlatformMessage._('error');

  static const List<PlatformMessage> VALUES = const[CONNECTED, DISCONNECTED, ERROR];

  const PlatformMessage._(String str): super(str);
}

/**
 * The enum is used by the VPN client to inform the platform of its current
 * state. This helps provide meaningful messages to the user.
 */
class VpnConnectionState extends ChromeEnum {
  static const VpnConnectionState CONNECTED = const VpnConnectionState._('connected');
  static const VpnConnectionState FAILURE = const VpnConnectionState._('failure');

  static const List<VpnConnectionState> VALUES = const[CONNECTED, FAILURE];

  const VpnConnectionState._(String str): super(str);
}

/**
 * The enum is used by the platform to indicate the event that triggered
 * `onUIEvent`.
 */
class UIEvent extends ChromeEnum {
  static const UIEvent SHOW_ADD_DIALOG = const UIEvent._('showAddDialog');
  static const UIEvent SHOW_CONFIGURE_DIALOG = const UIEvent._('showConfigureDialog');

  static const List<UIEvent> VALUES = const[SHOW_ADD_DIALOG, SHOW_CONFIGURE_DIALOG];

  const UIEvent._(String str): super(str);
}

/**
 * A parameters class for the VPN interface.
 */
class Parameters extends ChromeObject {
  Parameters({String address, String broadcastAddress, String mtu, List<String> exclusionList, List<String> inclusionList, List<String> domainSearch, List<String> dnsServers}) {
    if (address != null) this.address = address;
    if (broadcastAddress != null) this.broadcastAddress = broadcastAddress;
    if (mtu != null) this.mtu = mtu;
    if (exclusionList != null) this.exclusionList = exclusionList;
    if (inclusionList != null) this.inclusionList = inclusionList;
    if (domainSearch != null) this.domainSearch = domainSearch;
    if (dnsServers != null) this.dnsServers = dnsServers;
  }
  Parameters.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get address => jsProxy['address'];
  set address(String value) => jsProxy['address'] = value;

  String get broadcastAddress => jsProxy['broadcastAddress'];
  set broadcastAddress(String value) => jsProxy['broadcastAddress'] = value;

  String get mtu => jsProxy['mtu'];
  set mtu(String value) => jsProxy['mtu'] = value;

  List<String> get exclusionList => listify(jsProxy['exclusionList']);
  set exclusionList(List<String> value) => jsProxy['exclusionList'] = jsify(value);

  List<String> get inclusionList => listify(jsProxy['inclusionList']);
  set inclusionList(List<String> value) => jsProxy['inclusionList'] = jsify(value);

  List<String> get domainSearch => listify(jsProxy['domainSearch']);
  set domainSearch(List<String> value) => jsProxy['domainSearch'] = jsify(value);

  List<String> get dnsServers => listify(jsProxy['dnsServers']);
  set dnsServers(List<String> value) => jsProxy['dnsServers'] = jsify(value);
}

OnPlatformMessageEvent _createOnPlatformMessageEvent(String id, String message, String error) =>
    new OnPlatformMessageEvent(id, _createPlatformMessage(message), error);
ArrayBuffer _createArrayBuffer(/*JsObject*/ jsProxy) => jsProxy == null ? null : new ArrayBuffer.fromProxy(jsProxy);
OnConfigCreatedEvent _createOnConfigCreatedEvent(String id, String name, JsObject data) =>
    new OnConfigCreatedEvent(id, name, data);
OnUIEventEvent _createOnUIEventEvent(String event, String id) =>
    new OnUIEventEvent(_createUIEvent(event), id);
PlatformMessage _createPlatformMessage(String value) => PlatformMessage.VALUES.singleWhere((ChromeEnum e) => e.value == value);
UIEvent _createUIEvent(String value) => UIEvent.VALUES.singleWhere((ChromeEnum e) => e.value == value);
