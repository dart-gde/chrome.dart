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
  static final JsObject _serial = chrome['serial'];

  ChromeSerial._();

  bool get available => _serial != null;

  /**
   * Returns names of valid ports on this machine, each of which is likely to be
   * valid to pass as the port argument to open(). The list is regenerated each
   * time this method is called, as port validity is dynamic.
   * 
   * [callback]: Called with the list of ports.
   */
  Future<List<String>> getPorts() {
    if (_serial == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<String>>.oneArg(listify);
    _serial.callMethod('getPorts', [completer.callback]);
    return completer.future;
  }

  /**
   * Opens a connection to the given serial port.
   * [port]: The name of the serial port to open.
   * [options]: Connection options.
   * [callback]: Called when the connection has been opened.
   */
  Future<OpenInfo> open(String port, [OpenOptions options]) {
    if (_serial == null) _throwNotAvailable();

    var completer = new ChromeCompleter<OpenInfo>.oneArg(_createOpenInfo);
    _serial.callMethod('open', [port, jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Closes an open connection.
   * [connectionId]: The id of the opened connection.
   * [callback]: Called when the connection has been closed.
   * 
   * Returns:
   * Returns true if operation was successful.
   */
  Future<bool> close(int connectionId) {
    if (_serial == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _serial.callMethod('close', [connectionId, completer.callback]);
    return completer.future;
  }

  /**
   * Reads a byte from the given connection.
   * [connectionId]: The id of the connection.
   * [bytesToRead]: The number of bytes to read.
   * [callback]: Called when all the requested bytes have been read or when the
   * read blocks.
   */
  Future<SerialReadInfo> read(int connectionId, int bytesToRead) {
    if (_serial == null) _throwNotAvailable();

    var completer = new ChromeCompleter<SerialReadInfo>.oneArg(_createReadInfo);
    _serial.callMethod('read', [connectionId, bytesToRead, completer.callback]);
    return completer.future;
  }

  /**
   * Writes a string to the given connection.
   * [connectionId]: The id of the connection.
   * [data]: The string to write.
   * [callback]: Called when the string has been written.
   */
  Future<SerialWriteInfo> write(int connectionId, ArrayBuffer data) {
    if (_serial == null) _throwNotAvailable();

    var completer = new ChromeCompleter<SerialWriteInfo>.oneArg(_createWriteInfo);
    _serial.callMethod('write', [connectionId, jsify(data), completer.callback]);
    return completer.future;
  }

  /**
   * Flushes all bytes in the given connection's input and output buffers.
   * [connectionId]: The id of the connection.
   * [callback]: Called when the flush is complete.
   * 
   * Returns:
   * Returns true if operation was successful.
   */
  Future<bool> flush(int connectionId) {
    if (_serial == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _serial.callMethod('flush', [connectionId, completer.callback]);
    return completer.future;
  }

  Future<ControlSignalOptions> getControlSignals(int connectionId) {
    if (_serial == null) _throwNotAvailable();

    var completer = new ChromeCompleter<ControlSignalOptions>.oneArg(_createControlSignalOptions);
    _serial.callMethod('getControlSignals', [connectionId, completer.callback]);
    return completer.future;
  }

  Future<bool> setControlSignals(int connectionId, ControlSignalOptions options) {
    if (_serial == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _serial.callMethod('setControlSignals', [connectionId, jsify(options), completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.serial' is not available");
  }
}

class DataBit extends ChromeEnum {
  static const DataBit SEVENBIT = const DataBit._('sevenbit');
  static const DataBit EIGHTBIT = const DataBit._('eightbit');

  static const List<DataBit> VALUES = const[SEVENBIT, EIGHTBIT];

  const DataBit._(String str): super(str);
}

class ParityBit extends ChromeEnum {
  static const ParityBit NOPARITY = const ParityBit._('noparity');
  static const ParityBit ODDPARITY = const ParityBit._('oddparity');
  static const ParityBit EVENPARITY = const ParityBit._('evenparity');

  static const List<ParityBit> VALUES = const[NOPARITY, ODDPARITY, EVENPARITY];

  const ParityBit._(String str): super(str);
}

class StopBit extends ChromeEnum {
  static const StopBit ONESTOPBIT = const StopBit._('onestopbit');
  static const StopBit TWOSTOPBIT = const StopBit._('twostopbit');

  static const List<StopBit> VALUES = const[ONESTOPBIT, TWOSTOPBIT];

  const StopBit._(String str): super(str);
}

class OpenOptions extends ChromeObject {
  OpenOptions({int bitrate, DataBit dataBit, ParityBit parityBit, StopBit stopBit}) {
    if (bitrate != null) this.bitrate = bitrate;
    if (dataBit != null) this.dataBit = dataBit;
    if (parityBit != null) this.parityBit = parityBit;
    if (stopBit != null) this.stopBit = stopBit;
  }
  OpenOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get bitrate => jsProxy['bitrate'];
  set bitrate(int value) => jsProxy['bitrate'] = value;

  DataBit get dataBit => _createDataBit(jsProxy['dataBit']);
  set dataBit(DataBit value) => jsProxy['dataBit'] = jsify(value);

  ParityBit get parityBit => _createParityBit(jsProxy['parityBit']);
  set parityBit(ParityBit value) => jsProxy['parityBit'] = jsify(value);

  StopBit get stopBit => _createStopBit(jsProxy['stopBit']);
  set stopBit(StopBit value) => jsProxy['stopBit'] = jsify(value);
}

class OpenInfo extends ChromeObject {
  OpenInfo({int connectionId}) {
    if (connectionId != null) this.connectionId = connectionId;
  }
  OpenInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get connectionId => jsProxy['connectionId'];
  set connectionId(int value) => jsProxy['connectionId'] = value;
}

class SerialReadInfo extends ChromeObject {
  SerialReadInfo({int bytesRead, ArrayBuffer data}) {
    if (bytesRead != null) this.bytesRead = bytesRead;
    if (data != null) this.data = data;
  }
  SerialReadInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get bytesRead => jsProxy['bytesRead'];
  set bytesRead(int value) => jsProxy['bytesRead'] = value;

  ArrayBuffer get data => _createArrayBuffer(jsProxy['data']);
  set data(ArrayBuffer value) => jsProxy['data'] = jsify(value);
}

class SerialWriteInfo extends ChromeObject {
  SerialWriteInfo({int bytesWritten}) {
    if (bytesWritten != null) this.bytesWritten = bytesWritten;
  }
  SerialWriteInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get bytesWritten => jsProxy['bytesWritten'];
  set bytesWritten(int value) => jsProxy['bytesWritten'] = value;
}

/**
 * Boolean true = mark signal (negative serial voltage). Boolean false = space
 * signal (positive serial voltage).
 * 
 * For SetControlSignals, include the sendable signals that you wish to change.
 * Signals not included in the dictionary will be left unchanged.
 * 
 * GetControlSignals includes all receivable signals.
 */
class ControlSignalOptions extends ChromeObject {
  ControlSignalOptions({bool dtr, bool rts, bool dcd, bool cts}) {
    if (dtr != null) this.dtr = dtr;
    if (rts != null) this.rts = rts;
    if (dcd != null) this.dcd = dcd;
    if (cts != null) this.cts = cts;
  }
  ControlSignalOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  bool get dtr => jsProxy['dtr'];
  set dtr(bool value) => jsProxy['dtr'] = value;

  bool get rts => jsProxy['rts'];
  set rts(bool value) => jsProxy['rts'] = value;

  bool get dcd => jsProxy['dcd'];
  set dcd(bool value) => jsProxy['dcd'] = value;

  bool get cts => jsProxy['cts'];
  set cts(bool value) => jsProxy['cts'] = value;
}

OpenInfo _createOpenInfo(JsObject jsProxy) => jsProxy == null ? null : new OpenInfo.fromProxy(jsProxy);
SerialReadInfo _createReadInfo(JsObject jsProxy) => jsProxy == null ? null : new SerialReadInfo.fromProxy(jsProxy);
SerialWriteInfo _createWriteInfo(JsObject jsProxy) => jsProxy == null ? null : new SerialWriteInfo.fromProxy(jsProxy);
ControlSignalOptions _createControlSignalOptions(JsObject jsProxy) => jsProxy == null ? null : new ControlSignalOptions.fromProxy(jsProxy);
DataBit _createDataBit(String value) => DataBit.VALUES.singleWhere((ChromeEnum e) => e.value == value);
ParityBit _createParityBit(String value) => ParityBit.VALUES.singleWhere((ChromeEnum e) => e.value == value);
StopBit _createStopBit(String value) => StopBit.VALUES.singleWhere((ChromeEnum e) => e.value == value);
ArrayBuffer _createArrayBuffer(/*JsObject*/ jsProxy) => jsProxy == null ? null : new ArrayBuffer.fromProxy(jsProxy);
