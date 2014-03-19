/* This file has been generated from serial.idl - do not edit */

/**
 * Use the `chrome.serial` API to read from and write to a device connected to a
 * serial port.
 */
library chrome.serial;

import '../src/common.dart';

/**
 * Accessor for the `chrome.serial` namespace.
 */
final ChromeSerial serial = new ChromeSerial._();

class ChromeSerial extends ChromeApi {
  JsObject get _serial => chrome['serial'];

  Stream<SerialReceiveInfo> get onReceive => _onReceive.stream;
  ChromeStreamController<SerialReceiveInfo> _onReceive;

  Stream<SerialReceiveErrorInfo> get onReceiveError => _onReceiveError.stream;
  ChromeStreamController<SerialReceiveErrorInfo> _onReceiveError;

  ChromeSerial._() {
    var getApi = () => _serial;
    _onReceive = new ChromeStreamController<SerialReceiveInfo>.oneArg(getApi, 'onReceive', _createReceiveInfo);
    _onReceiveError = new ChromeStreamController<SerialReceiveErrorInfo>.oneArg(getApi, 'onReceiveError', _createReceiveErrorInfo);
  }

  bool get available => _serial != null;

  /**
   * Returns information about available serial devices on the system. The list
   * is regenerated each time this method is called.
   * [callback]: Called with the list of `DeviceInfo` objects.
   */
  Future<List<DeviceInfo>> getDevices() {
    if (_serial == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<DeviceInfo>>.oneArg((e) => listify(e, _createDeviceInfo));
    _serial.callMethod('getDevices', [completer.callback]);
    return completer.future;
  }

  /**
   * Connects to a given serial port.
   * [path]: The system path of the serial port to open.
   * [options]: Port configuration options.
   * [callback]: Called when the connection has been opened.
   * 
   * Returns:
   * Callback from the `connect` method;
   */
  Future<ConnectionInfo> connect(String path, [ConnectionOptions options]) {
    if (_serial == null) _throwNotAvailable();

    var completer = new ChromeCompleter<ConnectionInfo>.oneArg(_createConnectionInfo);
    _serial.callMethod('connect', [path, jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Update the option settings on an open serial port connection.
   * [connectionId]: The id of the opened connection.
   * [options]: Port configuration options.
   * [callback]: Called when the configuation has completed.
   * 
   * Returns:
   * Callback from the `update` method.
   */
  Future<bool> update(int connectionId, ConnectionOptions options) {
    if (_serial == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _serial.callMethod('update', [connectionId, jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Disconnects from a serial port.
   * [connectionId]: The id of the opened connection.
   * [callback]: Called when the connection has been closed.
   * 
   * Returns:
   * Callback from the `disconnect` method. Returns true if the operation was
   * successful.
   */
  Future<bool> disconnect(int connectionId) {
    if (_serial == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _serial.callMethod('disconnect', [connectionId, completer.callback]);
    return completer.future;
  }

  /**
   * Pauses or unpauses an open connection.
   * [connectionId]: The id of the opened connection.
   * [paused]: Flag to indicate whether to pause or unpause.
   * [callback]: Called when the connection has been successfully paused or
   * unpaused.
   */
  Future setPaused(int connectionId, bool paused) {
    if (_serial == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _serial.callMethod('setPaused', [connectionId, paused, completer.callback]);
    return completer.future;
  }

  /**
   * Retrieves the state of a given connection.
   * [connectionId]: The id of the opened connection.
   * [callback]: Called with connection state information when available.
   * 
   * Returns:
   * Callback from the `getInfo` method.
   */
  Future<ConnectionInfo> getInfo(int connectionId) {
    if (_serial == null) _throwNotAvailable();

    var completer = new ChromeCompleter<ConnectionInfo>.oneArg(_createConnectionInfo);
    _serial.callMethod('getInfo', [connectionId, completer.callback]);
    return completer.future;
  }

  /**
   * Retrieves the list of currently opened serial port connections owned by the
   * application.
   * [callback]: Called with the list of connections when available.
   * 
   * Returns:
   * Callback from the `getConnections` method.
   */
  Future<List<ConnectionInfo>> getConnections() {
    if (_serial == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<ConnectionInfo>>.oneArg((e) => listify(e, _createConnectionInfo));
    _serial.callMethod('getConnections', [completer.callback]);
    return completer.future;
  }

  /**
   * Writes data to the given connection.
   * [connectionId]: The id of the connection.
   * [data]: The data to send.
   * [callback]: Called when the operation has completed.
   */
  Future<SerialSendInfo> send(int connectionId, ArrayBuffer data) {
    if (_serial == null) _throwNotAvailable();

    var completer = new ChromeCompleter<SerialSendInfo>.oneArg(_createSendInfo);
    _serial.callMethod('send', [connectionId, jsify(data), completer.callback]);
    return completer.future;
  }

  /**
   * Flushes all bytes in the given connection's input and output buffers.
   */
  Future<bool> flush(int connectionId) {
    if (_serial == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _serial.callMethod('flush', [connectionId, completer.callback]);
    return completer.future;
  }

  /**
   * Retrieves the state of control signals on a given connection.
   * [connectionId]: The id of the connection.
   * [callback]: Called when the control signals are available.
   * 
   * Returns:
   * Returns a snapshot of current control signals.
   */
  Future<DeviceControlSignals> getControlSignals(int connectionId) {
    if (_serial == null) _throwNotAvailable();

    var completer = new ChromeCompleter<DeviceControlSignals>.oneArg(_createDeviceControlSignals);
    _serial.callMethod('getControlSignals', [connectionId, completer.callback]);
    return completer.future;
  }

  /**
   * Sets the state of control signals on a given connection.
   * [connectionId]: The id of the connection.
   * [signals]: The set of signal changes to send to the device.
   * [callback]: Called once the control signals have been set.
   * 
   * Returns:
   * Returns true if operation was successful.
   */
  Future<bool> setControlSignals(int connectionId, HostControlSignals signals) {
    if (_serial == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _serial.callMethod('setControlSignals', [connectionId, jsify(signals), completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.serial' is not available");
  }
}

class DataBits extends ChromeEnum {
  static const DataBits SEVEN = const DataBits._('seven');
  static const DataBits EIGHT = const DataBits._('eight');

  static const List<DataBits> VALUES = const[SEVEN, EIGHT];

  const DataBits._(String str): super(str);
}

class ParityBit extends ChromeEnum {
  static const ParityBit NO = const ParityBit._('no');
  static const ParityBit ODD = const ParityBit._('odd');
  static const ParityBit EVEN = const ParityBit._('even');

  static const List<ParityBit> VALUES = const[NO, ODD, EVEN];

  const ParityBit._(String str): super(str);
}

class StopBits extends ChromeEnum {
  static const StopBits ONE = const StopBits._('one');
  static const StopBits TWO = const StopBits._('two');

  static const List<StopBits> VALUES = const[ONE, TWO];

  const StopBits._(String str): super(str);
}

class SendError extends ChromeEnum {
  static const SendError DISCONNECTED = const SendError._('disconnected');
  static const SendError PENDING = const SendError._('pending');
  static const SendError TIMEOUT = const SendError._('timeout');
  static const SendError SYSTEM_ERROR = const SendError._('system_error');

  static const List<SendError> VALUES = const[DISCONNECTED, PENDING, TIMEOUT, SYSTEM_ERROR];

  const SendError._(String str): super(str);
}

class ReceiveError extends ChromeEnum {
  static const ReceiveError DISCONNECTED = const ReceiveError._('disconnected');
  static const ReceiveError TIMEOUT = const ReceiveError._('timeout');
  static const ReceiveError DEVICE_LOST = const ReceiveError._('device_lost');
  static const ReceiveError SYSTEM_ERROR = const ReceiveError._('system_error');

  static const List<ReceiveError> VALUES = const[DISCONNECTED, TIMEOUT, DEVICE_LOST, SYSTEM_ERROR];

  const ReceiveError._(String str): super(str);
}

class DeviceInfo extends ChromeObject {
  DeviceInfo({String path}) {
    if (path != null) this.path = path;
  }
  DeviceInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get path => jsProxy['path'];
  set path(String value) => jsProxy['path'] = value;
}

class ConnectionOptions extends ChromeObject {
  ConnectionOptions({bool persistent, String name, int bufferSize, int bitrate, DataBits dataBits, ParityBit parityBit, StopBits stopBits, bool ctsFlowControl, int receiveTimeout, int sendTimeout}) {
    if (persistent != null) this.persistent = persistent;
    if (name != null) this.name = name;
    if (bufferSize != null) this.bufferSize = bufferSize;
    if (bitrate != null) this.bitrate = bitrate;
    if (dataBits != null) this.dataBits = dataBits;
    if (parityBit != null) this.parityBit = parityBit;
    if (stopBits != null) this.stopBits = stopBits;
    if (ctsFlowControl != null) this.ctsFlowControl = ctsFlowControl;
    if (receiveTimeout != null) this.receiveTimeout = receiveTimeout;
    if (sendTimeout != null) this.sendTimeout = sendTimeout;
  }
  ConnectionOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  bool get persistent => jsProxy['persistent'];
  set persistent(bool value) => jsProxy['persistent'] = value;

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  int get bufferSize => jsProxy['bufferSize'];
  set bufferSize(int value) => jsProxy['bufferSize'] = value;

  int get bitrate => jsProxy['bitrate'];
  set bitrate(int value) => jsProxy['bitrate'] = value;

  DataBits get dataBits => _createDataBits(jsProxy['dataBits']);
  set dataBits(DataBits value) => jsProxy['dataBits'] = jsify(value);

  ParityBit get parityBit => _createParityBit(jsProxy['parityBit']);
  set parityBit(ParityBit value) => jsProxy['parityBit'] = jsify(value);

  StopBits get stopBits => _createStopBits(jsProxy['stopBits']);
  set stopBits(StopBits value) => jsProxy['stopBits'] = jsify(value);

  bool get ctsFlowControl => jsProxy['ctsFlowControl'];
  set ctsFlowControl(bool value) => jsProxy['ctsFlowControl'] = value;

  int get receiveTimeout => jsProxy['receiveTimeout'];
  set receiveTimeout(int value) => jsProxy['receiveTimeout'] = value;

  int get sendTimeout => jsProxy['sendTimeout'];
  set sendTimeout(int value) => jsProxy['sendTimeout'] = value;
}

/**
 * Result of the `getInfo` method.
 */
class ConnectionInfo extends ChromeObject {
  ConnectionInfo({int connectionId, bool paused, bool persistent, String name, int bufferSize, int receiveTimeout, int sendTimeout, int bitrate, DataBits dataBits, ParityBit parityBit, StopBits stopBits, bool ctsFlowControl}) {
    if (connectionId != null) this.connectionId = connectionId;
    if (paused != null) this.paused = paused;
    if (persistent != null) this.persistent = persistent;
    if (name != null) this.name = name;
    if (bufferSize != null) this.bufferSize = bufferSize;
    if (receiveTimeout != null) this.receiveTimeout = receiveTimeout;
    if (sendTimeout != null) this.sendTimeout = sendTimeout;
    if (bitrate != null) this.bitrate = bitrate;
    if (dataBits != null) this.dataBits = dataBits;
    if (parityBit != null) this.parityBit = parityBit;
    if (stopBits != null) this.stopBits = stopBits;
    if (ctsFlowControl != null) this.ctsFlowControl = ctsFlowControl;
  }
  ConnectionInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get connectionId => jsProxy['connectionId'];
  set connectionId(int value) => jsProxy['connectionId'] = value;

  bool get paused => jsProxy['paused'];
  set paused(bool value) => jsProxy['paused'] = value;

  bool get persistent => jsProxy['persistent'];
  set persistent(bool value) => jsProxy['persistent'] = value;

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  int get bufferSize => jsProxy['bufferSize'];
  set bufferSize(int value) => jsProxy['bufferSize'] = value;

  int get receiveTimeout => jsProxy['receiveTimeout'];
  set receiveTimeout(int value) => jsProxy['receiveTimeout'] = value;

  int get sendTimeout => jsProxy['sendTimeout'];
  set sendTimeout(int value) => jsProxy['sendTimeout'] = value;

  int get bitrate => jsProxy['bitrate'];
  set bitrate(int value) => jsProxy['bitrate'] = value;

  DataBits get dataBits => _createDataBits(jsProxy['dataBits']);
  set dataBits(DataBits value) => jsProxy['dataBits'] = jsify(value);

  ParityBit get parityBit => _createParityBit(jsProxy['parityBit']);
  set parityBit(ParityBit value) => jsProxy['parityBit'] = jsify(value);

  StopBits get stopBits => _createStopBits(jsProxy['stopBits']);
  set stopBits(StopBits value) => jsProxy['stopBits'] = jsify(value);

  bool get ctsFlowControl => jsProxy['ctsFlowControl'];
  set ctsFlowControl(bool value) => jsProxy['ctsFlowControl'] = value;
}

class SerialSendInfo extends ChromeObject {
  SerialSendInfo({int bytesSent, SendError error}) {
    if (bytesSent != null) this.bytesSent = bytesSent;
    if (error != null) this.error = error;
  }
  SerialSendInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get bytesSent => jsProxy['bytesSent'];
  set bytesSent(int value) => jsProxy['bytesSent'] = value;

  SendError get error => _createSendError(jsProxy['error']);
  set error(SendError value) => jsProxy['error'] = jsify(value);
}

/**
 * The set of control signals which may be sent to a connected serial device
 * using `setControlSignals`. Note that support for these signals is
 * device-dependent.
 */
class HostControlSignals extends ChromeObject {
  HostControlSignals({bool dtr, bool rts}) {
    if (dtr != null) this.dtr = dtr;
    if (rts != null) this.rts = rts;
  }
  HostControlSignals.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  bool get dtr => jsProxy['dtr'];
  set dtr(bool value) => jsProxy['dtr'] = value;

  bool get rts => jsProxy['rts'];
  set rts(bool value) => jsProxy['rts'] = value;
}

/**
 * The set of control signals which may be set by a connected serial device.
 * These can be queried using `getControlSignals`. Note that support for these
 * signals is device-dependent.
 */
class DeviceControlSignals extends ChromeObject {
  DeviceControlSignals({bool dcd, bool cts, bool ri, bool dsr}) {
    if (dcd != null) this.dcd = dcd;
    if (cts != null) this.cts = cts;
    if (ri != null) this.ri = ri;
    if (dsr != null) this.dsr = dsr;
  }
  DeviceControlSignals.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  bool get dcd => jsProxy['dcd'];
  set dcd(bool value) => jsProxy['dcd'] = value;

  bool get cts => jsProxy['cts'];
  set cts(bool value) => jsProxy['cts'] = value;

  bool get ri => jsProxy['ri'];
  set ri(bool value) => jsProxy['ri'] = value;

  bool get dsr => jsProxy['dsr'];
  set dsr(bool value) => jsProxy['dsr'] = value;
}

/**
 * Data from an `onReceive` event.
 */
class SerialReceiveInfo extends ChromeObject {
  SerialReceiveInfo({int connectionId, ArrayBuffer data}) {
    if (connectionId != null) this.connectionId = connectionId;
    if (data != null) this.data = data;
  }
  SerialReceiveInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get connectionId => jsProxy['connectionId'];
  set connectionId(int value) => jsProxy['connectionId'] = value;

  ArrayBuffer get data => _createArrayBuffer(jsProxy['data']);
  set data(ArrayBuffer value) => jsProxy['data'] = jsify(value);
}

/**
 * Data from an `onReceiveError` event.
 */
class SerialReceiveErrorInfo extends ChromeObject {
  SerialReceiveErrorInfo({int connectionId, ReceiveError error}) {
    if (connectionId != null) this.connectionId = connectionId;
    if (error != null) this.error = error;
  }
  SerialReceiveErrorInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get connectionId => jsProxy['connectionId'];
  set connectionId(int value) => jsProxy['connectionId'] = value;

  ReceiveError get error => _createReceiveError(jsProxy['error']);
  set error(ReceiveError value) => jsProxy['error'] = jsify(value);
}

SerialReceiveInfo _createReceiveInfo(JsObject jsProxy) => jsProxy == null ? null : new SerialReceiveInfo.fromProxy(jsProxy);
SerialReceiveErrorInfo _createReceiveErrorInfo(JsObject jsProxy) => jsProxy == null ? null : new SerialReceiveErrorInfo.fromProxy(jsProxy);
DeviceInfo _createDeviceInfo(JsObject jsProxy) => jsProxy == null ? null : new DeviceInfo.fromProxy(jsProxy);
ConnectionInfo _createConnectionInfo(JsObject jsProxy) => jsProxy == null ? null : new ConnectionInfo.fromProxy(jsProxy);
SerialSendInfo _createSendInfo(JsObject jsProxy) => jsProxy == null ? null : new SerialSendInfo.fromProxy(jsProxy);
DeviceControlSignals _createDeviceControlSignals(JsObject jsProxy) => jsProxy == null ? null : new DeviceControlSignals.fromProxy(jsProxy);
DataBits _createDataBits(String value) => DataBits.VALUES.singleWhere((ChromeEnum e) => e.value == value);
ParityBit _createParityBit(String value) => ParityBit.VALUES.singleWhere((ChromeEnum e) => e.value == value);
StopBits _createStopBits(String value) => StopBits.VALUES.singleWhere((ChromeEnum e) => e.value == value);
SendError _createSendError(String value) => SendError.VALUES.singleWhere((ChromeEnum e) => e.value == value);
ArrayBuffer _createArrayBuffer(/*JsObject*/ jsProxy) => jsProxy == null ? null : new ArrayBuffer.fromProxy(jsProxy);
ReceiveError _createReceiveError(String value) => ReceiveError.VALUES.singleWhere((ChromeEnum e) => e.value == value);
