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
class DeviceType extends ChromeEnum {
  static const DeviceType COMPUTER = const DeviceType._('computer');
  static const DeviceType PHONE = const DeviceType._('phone');
  static const DeviceType MODEM = const DeviceType._('modem');
  static const DeviceType AUDIO = const DeviceType._('audio');
  static const DeviceType CAR_AUDIO = const DeviceType._('carAudio');
  static const DeviceType VIDEO = const DeviceType._('video');
  static const DeviceType PERIPHERAL = const DeviceType._('peripheral');
  static const DeviceType JOYSTICK = const DeviceType._('joystick');
  static const DeviceType GAMEPAD = const DeviceType._('gamepad');
  static const DeviceType KEYBOARD = const DeviceType._('keyboard');
  static const DeviceType MOUSE = const DeviceType._('mouse');
  static const DeviceType TABLET = const DeviceType._('tablet');
  static const DeviceType KEYBOARD_MOUSE_COMBO = const DeviceType._('keyboardMouseCombo');

  static const List<DeviceType> VALUES = const[COMPUTER, PHONE, MODEM, AUDIO, CAR_AUDIO, VIDEO, PERIPHERAL, JOYSTICK, GAMEPAD, KEYBOARD, MOUSE, TABLET, KEYBOARD_MOUSE_COMBO];

  const DeviceType._(String str): super(str);
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
 * Information about the state of a known Bluetooth device.
 */
class BluetoothDevice extends ChromeObject {
  BluetoothDevice({String address, String name, int deviceClass, VendorIdSource vendorIdSource, int vendorId, int productId, int deviceId, DeviceType type, bool paired, bool connected, List<String> uuids, int inquiryRssi, int inquiryTxPower}) {
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

  DeviceType get type => _createDeviceType(jsProxy['type']);
  set type(DeviceType value) => jsProxy['type'] = jsify(value);

  bool get paired => jsProxy['paired'];
  set paired(bool value) => jsProxy['paired'] = value;

  bool get connected => jsProxy['connected'];
  set connected(bool value) => jsProxy['connected'] = value;

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
DeviceType _createDeviceType(String value) => DeviceType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
