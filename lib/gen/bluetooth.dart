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

  Stream<Socket> get onConnection => _onConnection.stream;
  ChromeStreamController<Socket> _onConnection;

  ChromeBluetooth._() {
    var getApi = () => _bluetooth;
    _onAdapterStateChanged = new ChromeStreamController<AdapterState>.oneArg(getApi, 'onAdapterStateChanged', _createAdapterState);
    _onDeviceAdded = new ChromeStreamController<BluetoothDevice>.oneArg(getApi, 'onDeviceAdded', _createDevice);
    _onDeviceChanged = new ChromeStreamController<BluetoothDevice>.oneArg(getApi, 'onDeviceChanged', _createDevice);
    _onDeviceRemoved = new ChromeStreamController<BluetoothDevice>.oneArg(getApi, 'onDeviceRemoved', _createDevice);
    _onConnection = new ChromeStreamController<Socket>.oneArg(getApi, 'onConnection', _createSocket);
  }

  bool get available => _bluetooth != null;

  /**
   * Registers the JavaScript application as an implementation for the given
   * Profile; if a channel or PSM is specified, the profile will be exported in
   * the host's SDP and GATT tables and advertised to other devices.
   */
  Future addProfile(Profile profile) {
    if (_bluetooth == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _bluetooth.callMethod('addProfile', [jsify(profile), completer.callback]);
    return completer.future;
  }

  /**
   * Unregisters the JavaScript application as an implementation for the given
   * Profile; only the uuid field of the Profile object is used.
   */
  Future removeProfile(Profile profile) {
    if (_bluetooth == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _bluetooth.callMethod('removeProfile', [jsify(profile), completer.callback]);
    return completer.future;
  }

  /**
   * Get information about the Bluetooth adapter.
   * [callback]: Called with an AdapterState object describing the adapter
   * state.
   */
  Future<AdapterState> getAdapterState() {
    if (_bluetooth == null) _throwNotAvailable();

    var completer = new ChromeCompleter<AdapterState>.oneArg(_createAdapterState);
    _bluetooth.callMethod('getAdapterState', [completer.callback]);
    return completer.future;
  }

  /**
   * Get a list of Bluetooth devices known to the system, including paired and
   * recently discovered devices.
   * [callback]: Called when the search is completed.
   */
  Future<List<BluetoothDevice>> getDevices() {
    if (_bluetooth == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<BluetoothDevice>>.oneArg((e) => listify(e, _createDevice));
    _bluetooth.callMethod('getDevices', [completer.callback]);
    return completer.future;
  }

  /**
   * Get information about a Bluetooth device known to the system.
   * [deviceAddress]: Address of device to get.
   * [callback]: Called with the BluetoothDevice object describing the device.
   */
  Future<BluetoothDevice> getDevice(String deviceAddress) {
    if (_bluetooth == null) _throwNotAvailable();

    var completer = new ChromeCompleter<BluetoothDevice>.oneArg(_createDevice);
    _bluetooth.callMethod('getDevice', [deviceAddress, completer.callback]);
    return completer.future;
  }

  /**
   * Connect to a service on a device.
   * [options]: The options for the connection.
   * [callback]: Called to indicate success or failure.
   */
  Future connect(ConnectOptions options) {
    if (_bluetooth == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _bluetooth.callMethod('connect', [jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Close a Bluetooth connection.
   * [options]: The options for this function.
   * [callback]: Called to indicate success or failure.
   */
  Future disconnect(DisconnectOptions options) {
    if (_bluetooth == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _bluetooth.callMethod('disconnect', [jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Read data from a Bluetooth connection. The [callback] will be called with
   * the current data in the buffer even if it is empty. This function should be
   * polled to read incoming data.
   * [options]: The options for this function.
   * [callback]: Called with the data read from the socket buffer.
   */
  Future<ArrayBuffer> read(ReadOptions options) {
    if (_bluetooth == null) _throwNotAvailable();

    var completer = new ChromeCompleter<ArrayBuffer>.oneArg(_createArrayBuffer);
    _bluetooth.callMethod('read', [jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Write data to a Bluetooth connection.
   * [options]: The options for this function.
   * [callback]: Called with the number of bytes written.
   */
  Future<int> write(WriteOptions options) {
    if (_bluetooth == null) _throwNotAvailable();

    var completer = new ChromeCompleter<int>.oneArg();
    _bluetooth.callMethod('write', [jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Get the local Out of Band Pairing data.
   * [callback]: Called with the data.
   */
  Future<OutOfBandPairingData> getLocalOutOfBandPairingData() {
    if (_bluetooth == null) _throwNotAvailable();

    var completer = new ChromeCompleter<OutOfBandPairingData>.oneArg(_createOutOfBandPairingData);
    _bluetooth.callMethod('getLocalOutOfBandPairingData', [completer.callback]);
    return completer.future;
  }

  /**
   * Set the Out of Band Pairing data for a remote device. Any previous Out Of
   * Band Pairing Data for this device is overwritten.
   * [options]: The options for this function.
   * [callback]: Called to indicate success or failure.
   */
  Future setOutOfBandPairingData(SetOutOfBandPairingDataOptions options) {
    if (_bluetooth == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _bluetooth.callMethod('setOutOfBandPairingData', [jsify(options), completer.callback]);
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

class BluetoothDevice extends ChromeObject {
  BluetoothDevice({String address, String name, int deviceClass, VendorIdSource vendorIdSource, int vendorId, int productId, int deviceId, DeviceType type, bool paired, bool connected, List<String> uuids}) {
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
}

class Profile extends ChromeObject {
  Profile({String uuid, String name, int channel, int psm, bool requireAuthentication, bool requireAuthorization, bool autoConnect, int version, int features}) {
    if (uuid != null) this.uuid = uuid;
    if (name != null) this.name = name;
    if (channel != null) this.channel = channel;
    if (psm != null) this.psm = psm;
    if (requireAuthentication != null) this.requireAuthentication = requireAuthentication;
    if (requireAuthorization != null) this.requireAuthorization = requireAuthorization;
    if (autoConnect != null) this.autoConnect = autoConnect;
    if (version != null) this.version = version;
    if (features != null) this.features = features;
  }
  Profile.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get uuid => jsProxy['uuid'];
  set uuid(String value) => jsProxy['uuid'] = value;

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  int get channel => jsProxy['channel'];
  set channel(int value) => jsProxy['channel'] = value;

  int get psm => jsProxy['psm'];
  set psm(int value) => jsProxy['psm'] = value;

  bool get requireAuthentication => jsProxy['requireAuthentication'];
  set requireAuthentication(bool value) => jsProxy['requireAuthentication'] = value;

  bool get requireAuthorization => jsProxy['requireAuthorization'];
  set requireAuthorization(bool value) => jsProxy['requireAuthorization'] = value;

  bool get autoConnect => jsProxy['autoConnect'];
  set autoConnect(bool value) => jsProxy['autoConnect'] = value;

  int get version => jsProxy['version'];
  set version(int value) => jsProxy['version'] = value;

  int get features => jsProxy['features'];
  set features(int value) => jsProxy['features'] = value;
}

class ServiceRecord extends ChromeObject {
  ServiceRecord({String name, String uuid}) {
    if (name != null) this.name = name;
    if (uuid != null) this.uuid = uuid;
  }
  ServiceRecord.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  String get uuid => jsProxy['uuid'];
  set uuid(String value) => jsProxy['uuid'] = value;
}

class Socket extends ChromeObject {
  Socket({BluetoothDevice device, Profile profile, int id}) {
    if (device != null) this.device = device;
    if (profile != null) this.profile = profile;
    if (id != null) this.id = id;
  }
  Socket.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  BluetoothDevice get device => _createDevice(jsProxy['device']);
  set device(BluetoothDevice value) => jsProxy['device'] = jsify(value);

  Profile get profile => _createProfile(jsProxy['profile']);
  set profile(Profile value) => jsProxy['profile'] = jsify(value);

  int get id => jsProxy['id'];
  set id(int value) => jsProxy['id'] = value;
}

class OutOfBandPairingData extends ChromeObject {
  OutOfBandPairingData({ArrayBuffer hash, ArrayBuffer randomizer}) {
    if (hash != null) this.hash = hash;
    if (randomizer != null) this.randomizer = randomizer;
  }
  OutOfBandPairingData.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  ArrayBuffer get hash => _createArrayBuffer(jsProxy['hash']);
  set hash(ArrayBuffer value) => jsProxy['hash'] = jsify(value);

  ArrayBuffer get randomizer => _createArrayBuffer(jsProxy['randomizer']);
  set randomizer(ArrayBuffer value) => jsProxy['randomizer'] = jsify(value);
}

/**
 * Options for the connect function.
 */
class ConnectOptions extends ChromeObject {
  ConnectOptions({BluetoothDevice device, Profile profile}) {
    if (device != null) this.device = device;
    if (profile != null) this.profile = profile;
  }
  ConnectOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  BluetoothDevice get device => _createDevice(jsProxy['device']);
  set device(BluetoothDevice value) => jsProxy['device'] = jsify(value);

  Profile get profile => _createProfile(jsProxy['profile']);
  set profile(Profile value) => jsProxy['profile'] = jsify(value);
}

/**
 * Options for the disconnect function.
 */
class DisconnectOptions extends ChromeObject {
  DisconnectOptions({Socket socket}) {
    if (socket != null) this.socket = socket;
  }
  DisconnectOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  Socket get socket => _createSocket(jsProxy['socket']);
  set socket(Socket value) => jsProxy['socket'] = jsify(value);
}

/**
 * Options for the read function.
 */
class ReadOptions extends ChromeObject {
  ReadOptions({Socket socket}) {
    if (socket != null) this.socket = socket;
  }
  ReadOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  Socket get socket => _createSocket(jsProxy['socket']);
  set socket(Socket value) => jsProxy['socket'] = jsify(value);
}

/**
 * Options for the write function.
 */
class WriteOptions extends ChromeObject {
  WriteOptions({Socket socket, ArrayBuffer data}) {
    if (socket != null) this.socket = socket;
    if (data != null) this.data = data;
  }
  WriteOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  Socket get socket => _createSocket(jsProxy['socket']);
  set socket(Socket value) => jsProxy['socket'] = jsify(value);

  ArrayBuffer get data => _createArrayBuffer(jsProxy['data']);
  set data(ArrayBuffer value) => jsProxy['data'] = jsify(value);
}

/**
 * Options for the setOutOfBandPairingData function.
 */
class SetOutOfBandPairingDataOptions extends ChromeObject {
  SetOutOfBandPairingDataOptions({String address, OutOfBandPairingData data}) {
    if (address != null) this.address = address;
    if (data != null) this.data = data;
  }
  SetOutOfBandPairingDataOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get address => jsProxy['address'];
  set address(String value) => jsProxy['address'] = value;

  OutOfBandPairingData get data => _createOutOfBandPairingData(jsProxy['data']);
  set data(OutOfBandPairingData value) => jsProxy['data'] = jsify(value);
}

AdapterState _createAdapterState(JsObject jsProxy) => jsProxy == null ? null : new AdapterState.fromProxy(jsProxy);
BluetoothDevice _createDevice(JsObject jsProxy) => jsProxy == null ? null : new BluetoothDevice.fromProxy(jsProxy);
Socket _createSocket(JsObject jsProxy) => jsProxy == null ? null : new Socket.fromProxy(jsProxy);
ArrayBuffer _createArrayBuffer(/*JsObject*/ jsProxy) => jsProxy == null ? null : new ArrayBuffer.fromProxy(jsProxy);
OutOfBandPairingData _createOutOfBandPairingData(JsObject jsProxy) => jsProxy == null ? null : new OutOfBandPairingData.fromProxy(jsProxy);
VendorIdSource _createVendorIdSource(String value) => VendorIdSource.VALUES.singleWhere((ChromeEnum e) => e.value == value);
DeviceType _createDeviceType(String value) => DeviceType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
Profile _createProfile(JsObject jsProxy) => jsProxy == null ? null : new Profile.fromProxy(jsProxy);
