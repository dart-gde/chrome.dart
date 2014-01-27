/* This file has been generated from bluetooth.idl - do not edit */

/**
 * Use the `chrome.bluetooth` API to connect to a Bluetooth device.
 */
library chrome.bluetooth;

import '../src/common.dart';

/**
 * Accessor for the `chrome.bluetooth` namespace.
 */
final ChromeBluetooth bluetooth = new ChromeBluetooth._();

class ChromeBluetooth extends ChromeApi {
  static final JsObject _bluetooth = chrome['bluetooth'];

  ChromeBluetooth._();

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
   * Get a bluetooth devices known to the system. Known devices are either
   * currently paired, or have been paired in the past.
   * [options]: Controls which devices are returned and provides
   * [deviceCallback], which is called for each matching device.
   * [callback]: Called when the search is completed. |options.deviceCallback|
   * will not be called after [callback] has been called.
   */
  Future getDevices(GetDevicesOptions options) {
    if (_bluetooth == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _bluetooth.callMethod('getDevices', [jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Returns the set of exported profiles for the device specified in options.
   * This function will not initiate a connection to the remote device.
   */
  Future<List<Profile>> getProfiles(GetProfilesOptions options) {
    if (_bluetooth == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<Profile>>.oneArg((e) => listify(e, _createProfile));
    _bluetooth.callMethod('getProfiles', [jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Get a list of services provided by a device.
   */
  Future<List<ServiceRecord>> getServices(GetServicesOptions options) {
    if (_bluetooth == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<ServiceRecord>>.oneArg((e) => listify(e, _createServiceRecord));
    _bluetooth.callMethod('getServices', [jsify(options), completer.callback]);
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
   * Read data from a Bluetooth connection.
   * [options]: The options for this function.
   * [callback]: Called with the data when it is available.
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
   * Start discovery. Discovered devices will be returned via the
   * [onDeviceDiscovered] callback. Discovery will fail to start if it is
   * already in progress. Discovery can be resource intensive: stopDiscovery
   * should be called as soon as possible.
   * [options]: The options for this function.
   * [callback]: Called to indicate success or failure.
   */
  Future startDiscovery(StartDiscoveryOptions options) {
    if (_bluetooth == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _bluetooth.callMethod('startDiscovery', [jsify(options), completer.callback]);
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

  Stream<AdapterState> get onAdapterStateChanged => _onAdapterStateChanged.stream;

  final ChromeStreamController<AdapterState> _onAdapterStateChanged =
      new ChromeStreamController<AdapterState>.oneArg(_bluetooth, 'onAdapterStateChanged', _createAdapterState);

  Stream<Socket> get onConnection => _onConnection.stream;

  final ChromeStreamController<Socket> _onConnection =
      new ChromeStreamController<Socket>.oneArg(_bluetooth, 'onConnection', _createSocket);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.bluetooth' is not available");
  }
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
  BluetoothDevice({String address, String name, bool paired, bool connected}) {
    if (address != null) this.address = address;
    if (name != null) this.name = name;
    if (paired != null) this.paired = paired;
    if (connected != null) this.connected = connected;
  }
  BluetoothDevice.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get address => jsProxy['address'];
  set address(String value) => jsProxy['address'] = value;

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  bool get paired => jsProxy['paired'];
  set paired(bool value) => jsProxy['paired'] = value;

  bool get connected => jsProxy['connected'];
  set connected(bool value) => jsProxy['connected'] = value;
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
 * Options for the getDevices function. If [profile] is not provided, all
 * devices known to the system are returned.
 */
class GetDevicesOptions extends ChromeObject {
  GetDevicesOptions({Profile profile, DeviceCallback deviceCallback}) {
    if (profile != null) this.profile = profile;
    if (deviceCallback != null) this.deviceCallback = deviceCallback;
  }
  GetDevicesOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  Profile get profile => _createProfile(jsProxy['profile']);
  set profile(Profile value) => jsProxy['profile'] = jsify(value);

  DeviceCallback get deviceCallback => _createDeviceCallback(jsProxy['deviceCallback']);
  set deviceCallback(DeviceCallback value) => jsProxy['deviceCallback'] = jsify(value);
}

/**
 * Options for the getProfiles function.
 */
class GetProfilesOptions extends ChromeObject {
  GetProfilesOptions({BluetoothDevice device}) {
    if (device != null) this.device = device;
  }
  GetProfilesOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  BluetoothDevice get device => _createDevice(jsProxy['device']);
  set device(BluetoothDevice value) => jsProxy['device'] = jsify(value);
}

/**
 * Options for the getServices function.
 */
class GetServicesOptions extends ChromeObject {
  GetServicesOptions({String deviceAddress}) {
    if (deviceAddress != null) this.deviceAddress = deviceAddress;
  }
  GetServicesOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get deviceAddress => jsProxy['deviceAddress'];
  set deviceAddress(String value) => jsProxy['deviceAddress'] = value;
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

/**
 * Options for the startDiscovery function.
 */
class StartDiscoveryOptions extends ChromeObject {
  StartDiscoveryOptions({DeviceCallback deviceCallback}) {
    if (deviceCallback != null) this.deviceCallback = deviceCallback;
  }
  StartDiscoveryOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  DeviceCallback get deviceCallback => _createDeviceCallback(jsProxy['deviceCallback']);
  set deviceCallback(DeviceCallback value) => jsProxy['deviceCallback'] = jsify(value);
}

AdapterState _createAdapterState(JsObject jsProxy) => jsProxy == null ? null : new AdapterState.fromProxy(jsProxy);
Profile _createProfile(JsObject jsProxy) => jsProxy == null ? null : new Profile.fromProxy(jsProxy);
ServiceRecord _createServiceRecord(JsObject jsProxy) => jsProxy == null ? null : new ServiceRecord.fromProxy(jsProxy);
ArrayBuffer _createArrayBuffer(/*JsObject*/ jsProxy) => jsProxy == null ? null : new ArrayBuffer.fromProxy(jsProxy);
OutOfBandPairingData _createOutOfBandPairingData(JsObject jsProxy) => jsProxy == null ? null : new OutOfBandPairingData.fromProxy(jsProxy);
Socket _createSocket(JsObject jsProxy) => jsProxy == null ? null : new Socket.fromProxy(jsProxy);
BluetoothDevice _createDevice(JsObject jsProxy) => jsProxy == null ? null : new BluetoothDevice.fromProxy(jsProxy);
DeviceCallback _createDeviceCallback(JsObject jsProxy) => jsProxy == null ? null : new DeviceCallback.fromProxy(jsProxy);
