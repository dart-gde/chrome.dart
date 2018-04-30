/* This file has been generated from bluetooth.idl - do not edit */

/**
 * Use the `chrome.bluetooth` API to connect to a Bluetooth device. All
 * functions report failures via chrome.runtime.lastError.
 */
library chrome.bluetooth;

import '../src/common.dart';

/**
 * Accessor for the `chrome.bluetooth` namespace.
 */
final ChromeBluetooth bluetooth = new ChromeBluetooth._();

class ChromeBluetooth extends ChromeApi {
  JsObject get _bluetooth => chrome['bluetooth'];

  Stream<AdapterState> get onAdapterStateChanged => _onAdapterStateChanged.stream;
  ChromeStreamController<AdapterState> _onAdapterStateChanged;

  Stream<BluetoothDevice> get onDeviceAdded => _onDeviceAdded.stream;
  ChromeStreamController<BluetoothDevice> _onDeviceAdded;

  Stream<BluetoothDevice> get onDeviceChanged => _onDeviceChanged.stream;
  ChromeStreamController<BluetoothDevice> _onDeviceChanged;

  Stream<BluetoothDevice> get onDeviceRemoved => _onDeviceRemoved.stream;
  ChromeStreamController<BluetoothDevice> _onDeviceRemoved;

  ChromeBluetooth._() {
    var getApi = () => _bluetooth;
    _onAdapterStateChanged = new ChromeStreamController<AdapterState>.oneArg(getApi, 'onAdapterStateChanged', _createAdapterState);
    _onDeviceAdded = new ChromeStreamController<BluetoothDevice>.oneArg(getApi, 'onDeviceAdded', _createDevice);
    _onDeviceChanged = new ChromeStreamController<BluetoothDevice>.oneArg(getApi, 'onDeviceChanged', _createDevice);
    _onDeviceRemoved = new ChromeStreamController<BluetoothDevice>.oneArg(getApi, 'onDeviceRemoved', _createDevice);
  }

  bool get available => _bluetooth != null;

  /**
   * Get information about the Bluetooth adapter.
   * [callback]: Called with an AdapterState object describing the adapter
   * state.
   * 
   * Returns:
   * Callback from the `getAdapterState` method.
   * [adapterInfo]: Object containing the adapter information.
   */
  Future<AdapterState> getAdapterState() {
    if (_bluetooth == null) _throwNotAvailable();

    var completer = new ChromeCompleter<AdapterState>.oneArg(_createAdapterState);
    _bluetooth.callMethod('getAdapterState', [completer.callback]);
    return completer.future;
  }

  /**
   * Get information about a Bluetooth device known to the system.
   * [deviceAddress]: Address of device to get.
   * [callback]: Called with the BluetoothDevice object describing the device.
   * 
   * Returns:
   * Callback from the `getDevice` method.
   * [deviceInfo]: Object containing the device information.
   */
  Future<BluetoothDevice> getDevice(String deviceAddress) {
    if (_bluetooth == null) _throwNotAvailable();

    var completer = new ChromeCompleter<BluetoothDevice>.oneArg(_createDevice);
    _bluetooth.callMethod('getDevice', [deviceAddress, completer.callback]);
    return completer.future;
  }

  /**
   * Get a list of Bluetooth devices known to the system, including paired and
   * recently discovered devices.
   * [callback]: Called when the search is completed.
   * 
   * Returns:
   * Callback from the `getDevices` method.
   * [deviceInfos]: Array of object containing device information.
   */
  Future<List<BluetoothDevice>> getDevices() {
    if (_bluetooth == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<BluetoothDevice>>.oneArg((e) => listify(e, _createDevice));
    _bluetooth.callMethod('getDevices', [completer.callback]);
    return completer.future;
  }

  /**
   * Start discovery. Newly discovered devices will be returned via the
   * onDeviceAdded event. Previously discovered devices already known to the
   * adapter must be obtained using getDevices and will only be updated using
   * the [onDeviceChanged] event if information about them changes.
   * 
   * Discovery will fail to start if this application has already called
   * startDiscovery. Discovery can be resource intensive: stopDiscovery should
   * be called as soon as possible.
   * [callback]: Called to indicate success or failure.
   */
  Future startDiscovery() {
    if (_bluetooth == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _bluetooth.callMethod('startDiscovery', [completer.callback]);
    return completer.future;
  }

  /**
   * Stop discovery.
   * [callback]: Called to indicate success or failure.
   */
  Future stopDiscovery() {
    if (_bluetooth == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _bluetooth.callMethod('stopDiscovery', [completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.bluetooth' is not available");
  }
}

/**
 * Allocation authorities for Vendor IDs.
 */
class VendorIdSource extends ChromeEnum {
  static const VendorIdSource BLUETOOTH = const VendorIdSource._('bluetooth');
  static const VendorIdSource USB = const VendorIdSource._('usb');

  static const List<VendorIdSource> VALUES = const[BLUETOOTH, USB];

  const VendorIdSource._(String str): super(str);
}

/**
 * Common device types recognized by Chrome.
 */
class BluetoothDeviceType extends ChromeEnum {
  static const BluetoothDeviceType COMPUTER = const BluetoothDeviceType._('computer');
  static const BluetoothDeviceType PHONE = const BluetoothDeviceType._('phone');
  static const BluetoothDeviceType MODEM = const BluetoothDeviceType._('modem');
  static const BluetoothDeviceType AUDIO = const BluetoothDeviceType._('audio');
  static const BluetoothDeviceType CAR_AUDIO = const BluetoothDeviceType._('carAudio');
  static const BluetoothDeviceType VIDEO = const BluetoothDeviceType._('video');
  static const BluetoothDeviceType PERIPHERAL = const BluetoothDeviceType._('peripheral');
  static const BluetoothDeviceType JOYSTICK = const BluetoothDeviceType._('joystick');
  static const BluetoothDeviceType GAMEPAD = const BluetoothDeviceType._('gamepad');
  static const BluetoothDeviceType KEYBOARD = const BluetoothDeviceType._('keyboard');
  static const BluetoothDeviceType MOUSE = const BluetoothDeviceType._('mouse');
  static const BluetoothDeviceType TABLET = const BluetoothDeviceType._('tablet');
  static const BluetoothDeviceType KEYBOARD_MOUSE_COMBO = const BluetoothDeviceType._('keyboardMouseCombo');

  static const List<BluetoothDeviceType> VALUES = const[COMPUTER, PHONE, MODEM, AUDIO, CAR_AUDIO, VIDEO, PERIPHERAL, JOYSTICK, GAMEPAD, KEYBOARD, MOUSE, TABLET, KEYBOARD_MOUSE_COMBO];

  const BluetoothDeviceType._(String str): super(str);
}

/**
 * Information about the state of the Bluetooth adapter.
 */
class AdapterState extends ChromeObject {
  AdapterState({String address, String name, bool powered, bool available, bool discovering}) {
    if (address != null) this.address = address;
    if (name != null) this.name = name;
    if (powered != null) this.powered = powered;
    if (available != null) this.available = available;
    if (discovering != null) this.discovering = discovering;
  }
  AdapterState.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get address => jsProxy['address'];
  set address(String value) => jsProxy['address'] = value;

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  bool get powered => jsProxy['powered'];
  set powered(bool value) => jsProxy['powered'] = value;

  bool get available => jsProxy['available'];
  set available(bool value) => jsProxy['available'] = value;

  bool get discovering => jsProxy['discovering'];
  set discovering(bool value) => jsProxy['discovering'] = value;
}

/**
 * Information about the state of a known Bluetooth device. Note: this
 * dictionary is also used in bluetooth_private.idl
 */
class BluetoothDevice extends ChromeObject {
  BluetoothDevice({String address, String name, int deviceClass, VendorIdSource vendorIdSource, int vendorId, int productId, int deviceId, BluetoothDeviceType type, bool paired, bool connected, bool connecting, bool connectable, List<String> uuids, int inquiryRssi, int inquiryTxPower}) {
    if (address != null) this.address = address;
    if (name != null) this.name = name;
    if (deviceClass != null) this.deviceClass = deviceClass;
    if (vendorIdSource != null) this.vendorIdSource = vendorIdSource;
    if (vendorId != null) this.vendorId = vendorId;
    if (productId != null) this.productId = productId;
    if (deviceId != null) this.deviceId = deviceId;
    if (type != null) this.type = type;
    if (paired != null) this.paired = paired;
    if (connected != null) this.connected = connected;
    if (connecting != null) this.connecting = connecting;
    if (connectable != null) this.connectable = connectable;
    if (uuids != null) this.uuids = uuids;
    if (inquiryRssi != null) this.inquiryRssi = inquiryRssi;
    if (inquiryTxPower != null) this.inquiryTxPower = inquiryTxPower;
  }
  BluetoothDevice.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get address => jsProxy['address'];
  set address(String value) => jsProxy['address'] = value;

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  int get deviceClass => jsProxy['deviceClass'];
  set deviceClass(int value) => jsProxy['deviceClass'] = value;

  VendorIdSource get vendorIdSource => _createVendorIdSource(jsProxy['vendorIdSource']);
  set vendorIdSource(VendorIdSource value) => jsProxy['vendorIdSource'] = jsify(value);

  int get vendorId => jsProxy['vendorId'];
  set vendorId(int value) => jsProxy['vendorId'] = value;

  int get productId => jsProxy['productId'];
  set productId(int value) => jsProxy['productId'] = value;

  int get deviceId => jsProxy['deviceId'];
  set deviceId(int value) => jsProxy['deviceId'] = value;

  BluetoothDeviceType get type => _createDeviceType(jsProxy['type']);
  set type(BluetoothDeviceType value) => jsProxy['type'] = jsify(value);

  bool get paired => jsProxy['paired'];
  set paired(bool value) => jsProxy['paired'] = value;

  bool get connected => jsProxy['connected'];
  set connected(bool value) => jsProxy['connected'] = value;

  bool get connecting => jsProxy['connecting'];
  set connecting(bool value) => jsProxy['connecting'] = value;

  bool get connectable => jsProxy['connectable'];
  set connectable(bool value) => jsProxy['connectable'] = value;

  List<String> get uuids => listify(jsProxy['uuids']);
  set uuids(List<String> value) => jsProxy['uuids'] = jsify(value);

  int get inquiryRssi => jsProxy['inquiryRssi'];
  set inquiryRssi(int value) => jsProxy['inquiryRssi'] = value;

  int get inquiryTxPower => jsProxy['inquiryTxPower'];
  set inquiryTxPower(int value) => jsProxy['inquiryTxPower'] = value;
}

AdapterState _createAdapterState(JsObject jsProxy) => jsProxy == null ? null : new AdapterState.fromProxy(jsProxy);
BluetoothDevice _createDevice(JsObject jsProxy) => jsProxy == null ? null : new BluetoothDevice.fromProxy(jsProxy);
VendorIdSource _createVendorIdSource(String value) => VendorIdSource.VALUES.singleWhere((ChromeEnum e) => e.value == value);
BluetoothDeviceType _createDeviceType(String value) => BluetoothDeviceType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
