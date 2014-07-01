/* This file has been generated from bluetooth_socket.idl - do not edit */

/**
 * Use the `chrome.bluetoothSocket` API to send and receive data to Bluetooth
 * devices using RFCOMM and L2CAP connections.
 */
library chrome.bluetoothSocket;

import '../src/common.dart';

/**
 * Accessor for the `chrome.bluetoothSocket` namespace.
 */
final ChromeBluetoothSocket bluetoothSocket = new ChromeBluetoothSocket._();

class ChromeBluetoothSocket extends ChromeApi {
  JsObject get _bluetoothSocket => chrome['bluetoothSocket'];

  Stream<BluetoothAcceptInfo> get onAccept => _onAccept.stream;
  ChromeStreamController<BluetoothAcceptInfo> _onAccept;

  Stream<BluetoothAcceptErrorInfo> get onAcceptError => _onAcceptError.stream;
  ChromeStreamController<BluetoothAcceptErrorInfo> _onAcceptError;

  Stream<BluetoothReceiveInfo> get onReceive => _onReceive.stream;
  ChromeStreamController<BluetoothReceiveInfo> _onReceive;

  Stream<BluetoothReceiveErrorInfo> get onReceiveError => _onReceiveError.stream;
  ChromeStreamController<BluetoothReceiveErrorInfo> _onReceiveError;

  ChromeBluetoothSocket._() {
    var getApi = () => _bluetoothSocket;
    _onAccept = new ChromeStreamController<BluetoothAcceptInfo>.oneArg(getApi, 'onAccept', _createAcceptInfo);
    _onAcceptError = new ChromeStreamController<BluetoothAcceptErrorInfo>.oneArg(getApi, 'onAcceptError', _createAcceptErrorInfo);
    _onReceive = new ChromeStreamController<BluetoothReceiveInfo>.oneArg(getApi, 'onReceive', _createReceiveInfo);
    _onReceiveError = new ChromeStreamController<BluetoothReceiveErrorInfo>.oneArg(getApi, 'onReceiveError', _createReceiveErrorInfo);
  }

  bool get available => _bluetoothSocket != null;

  /**
   * Creates a Bluetooth socket.
   * [properties]: The socket properties (optional).
   * [callback]: Called when the socket has been created.
   * 
   * Returns:
   * Callback from the `create` method.
   * [createInfo]: The result of the socket creation.
   */
  Future<BluetoothCreateInfo> create([BluetoothSocketProperties properties]) {
    if (_bluetoothSocket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<BluetoothCreateInfo>.oneArg(_createCreateInfo);
    _bluetoothSocket.callMethod('create', [jsify(properties), completer.callback]);
    return completer.future;
  }

  /**
   * Updates the socket properties.
   * [socketId]: The socket identifier.
   * [properties]: The properties to update.
   * [callback]: Called when the properties are updated.
   */
  Future update(int socketId, BluetoothSocketProperties properties) {
    if (_bluetoothSocket == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _bluetoothSocket.callMethod('update', [socketId, jsify(properties), completer.callback]);
    return completer.future;
  }

  /**
   * Enables or disables a connected socket from receiving messages from its
   * peer, or a listening socket from accepting new connections. The default
   * value is "false". Pausing a connected socket is typically used by an
   * application to throttle data sent by its peer. When a connected socket is
   * paused, no `onReceive`event is raised. When a socket is connected and
   * un-paused, `onReceive` events are raised again when messages are received.
   * When a listening socket is paused, new connections are accepted until its
   * backlog is full then additional connection requests are refused. `onAccept`
   * events are raised only when the socket is un-paused.
   */
  Future setPaused(int socketId, bool paused) {
    if (_bluetoothSocket == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _bluetoothSocket.callMethod('setPaused', [socketId, paused, completer.callback]);
    return completer.future;
  }

  /**
   * Listen for connections using the RFCOMM protocol.
   * [socketId]: The socket identifier.
   * [uuid]: Service UUID to listen on.
   * [options]: Optional additional options for the service.
   * [callback]: Called when listen operation completes.
   */
  Future listenUsingRfcomm(int socketId, String uuid, [ListenOptions options]) {
    if (_bluetoothSocket == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _bluetoothSocket.callMethod('listenUsingRfcomm', [socketId, uuid, jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Listen for connections using the L2CAP protocol.
   * [socketId]: The socket identifier.
   * [uuid]: Service UUID to listen on.
   * [options]: Optional additional options for the service.
   * [callback]: Called when listen operation completes.
   */
  Future listenUsingL2cap(int socketId, String uuid, [ListenOptions options]) {
    if (_bluetoothSocket == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _bluetoothSocket.callMethod('listenUsingL2cap', [socketId, uuid, jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Connects the socket to a remote Bluetooth device. When the `connect`
   * operation completes successfully, `onReceive` events are raised when data
   * is received from the peer. If a network error occur while the runtime is
   * receiving packets, a `onReceiveError` event is raised, at which point no
   * more `onReceive` event will be raised for this socket until the
   * `setPaused(false)` method is called.
   * [socketId]: The socket identifier.
   * [address]: The address of the Bluetooth device.
   * [uuid]: The UUID of the service to connect to.
   * [callback]: Called when the connect attempt is complete.
   */
  Future connect(int socketId, String address, String uuid) {
    if (_bluetoothSocket == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _bluetoothSocket.callMethod('connect', [socketId, address, uuid, completer.callback]);
    return completer.future;
  }

  /**
   * Disconnects the socket. The socket identifier remains valid.
   * [socketId]: The socket identifier.
   * [callback]: Called when the disconnect attempt is complete.
   */
  Future disconnect(int socketId) {
    if (_bluetoothSocket == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _bluetoothSocket.callMethod('disconnect', [socketId, completer.callback]);
    return completer.future;
  }

  /**
   * Disconnects and destroys the socket. Each socket created should be closed
   * after use. The socket id is no longer valid as soon at the function is
   * called. However, the socket is guaranteed to be closed only when the
   * callback is invoked.
   * [socketId]: The socket identifier.
   * [callback]: Called when the `close` operation completes.
   */
  Future close(int socketId) {
    if (_bluetoothSocket == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _bluetoothSocket.callMethod('close', [socketId, completer.callback]);
    return completer.future;
  }

  /**
   * Sends data on the given Bluetooth socket.
   * [socketId]: The socket identifier.
   * [data]: The data to send.
   * [callback]: Called with the number of bytes sent.
   * 
   * Returns:
   * Callback from the `send` method.
   * [bytesSent]: The number of bytes sent.
   */
  Future<int> send(int socketId, ArrayBuffer data) {
    if (_bluetoothSocket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<int>.oneArg();
    _bluetoothSocket.callMethod('send', [socketId, jsify(data), completer.callback]);
    return completer.future;
  }

  /**
   * Retrieves the state of the given socket.
   * [socketId]: The socket identifier.
   * [callback]: Called when the socket state is available.
   * 
   * Returns:
   * Callback from the `getInfo` method.
   * [socketInfo]: Object containing the socket information.
   */
  Future<BluetoothSocketInfo> getInfo(int socketId) {
    if (_bluetoothSocket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<BluetoothSocketInfo>.oneArg(_createSocketInfo);
    _bluetoothSocket.callMethod('getInfo', [socketId, completer.callback]);
    return completer.future;
  }

  /**
   * Retrieves the list of currently opened sockets owned by the application.
   * [callback]: Called when the list of sockets is available.
   * 
   * Returns:
   * Callback from the `getSockets` method.
   * [socketInfos]: Array of object containing socket information.
   */
  Future<List<BluetoothSocketInfo>> getSockets() {
    if (_bluetoothSocket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<BluetoothSocketInfo>>.oneArg((e) => listify(e, _createSocketInfo));
    _bluetoothSocket.callMethod('getSockets', [completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.bluetoothSocket' is not available");
  }
}

class AcceptError extends ChromeEnum {
  static const AcceptError SYSTEM_ERROR = const AcceptError._('system_error');
  static const AcceptError NOT_LISTENING = const AcceptError._('not_listening');

  static const List<AcceptError> VALUES = const[SYSTEM_ERROR, NOT_LISTENING];

  const AcceptError._(String str): super(str);
}

class BluetoothReceiveError extends ChromeEnum {
  static const BluetoothReceiveError DISCONNECTED = const BluetoothReceiveError._('disconnected');
  static const BluetoothReceiveError SYSTEM_ERROR = const BluetoothReceiveError._('system_error');
  static const BluetoothReceiveError NOT_CONNECTED = const BluetoothReceiveError._('not_connected');

  static const List<BluetoothReceiveError> VALUES = const[DISCONNECTED, SYSTEM_ERROR, NOT_CONNECTED];

  const BluetoothReceiveError._(String str): super(str);
}

/**
 * The socket properties specified in the [create] or [update] function. Each
 * property is optional. If a property value is not specified, a default value
 * is used when calling [create], or the existing value is preserved when
 * calling [update].
 */
class BluetoothSocketProperties extends ChromeObject {
  BluetoothSocketProperties({bool persistent, String name, int bufferSize}) {
    if (persistent != null) this.persistent = persistent;
    if (name != null) this.name = name;
    if (bufferSize != null) this.bufferSize = bufferSize;
  }
  BluetoothSocketProperties.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  bool get persistent => jsProxy['persistent'];
  set persistent(bool value) => jsProxy['persistent'] = value;

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  int get bufferSize => jsProxy['bufferSize'];
  set bufferSize(int value) => jsProxy['bufferSize'] = value;
}

/**
 * Result of `create` call.
 */
class BluetoothCreateInfo extends ChromeObject {
  BluetoothCreateInfo({int socketId}) {
    if (socketId != null) this.socketId = socketId;
  }
  BluetoothCreateInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get socketId => jsProxy['socketId'];
  set socketId(int value) => jsProxy['socketId'] = value;
}

/**
 * Options that may be passed to the `listenUsingRfcomm` and `listenUsingL2cap`
 * methods. Each property is optional with a default being used if not
 * specified.
 */
class ListenOptions extends ChromeObject {
  ListenOptions({int channel, int psm, int backlog}) {
    if (channel != null) this.channel = channel;
    if (psm != null) this.psm = psm;
    if (backlog != null) this.backlog = backlog;
  }
  ListenOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get channel => jsProxy['channel'];
  set channel(int value) => jsProxy['channel'] = value;

  int get psm => jsProxy['psm'];
  set psm(int value) => jsProxy['psm'] = value;

  int get backlog => jsProxy['backlog'];
  set backlog(int value) => jsProxy['backlog'] = value;
}

/**
 * Result of the `getInfo` method.
 */
class BluetoothSocketInfo extends ChromeObject {
  BluetoothSocketInfo({int socketId, bool persistent, String name, int bufferSize, bool paused, bool connected, String address, String uuid}) {
    if (socketId != null) this.socketId = socketId;
    if (persistent != null) this.persistent = persistent;
    if (name != null) this.name = name;
    if (bufferSize != null) this.bufferSize = bufferSize;
    if (paused != null) this.paused = paused;
    if (connected != null) this.connected = connected;
    if (address != null) this.address = address;
    if (uuid != null) this.uuid = uuid;
  }
  BluetoothSocketInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get socketId => jsProxy['socketId'];
  set socketId(int value) => jsProxy['socketId'] = value;

  bool get persistent => jsProxy['persistent'];
  set persistent(bool value) => jsProxy['persistent'] = value;

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  int get bufferSize => jsProxy['bufferSize'];
  set bufferSize(int value) => jsProxy['bufferSize'] = value;

  bool get paused => jsProxy['paused'];
  set paused(bool value) => jsProxy['paused'] = value;

  bool get connected => jsProxy['connected'];
  set connected(bool value) => jsProxy['connected'] = value;

  String get address => jsProxy['address'];
  set address(String value) => jsProxy['address'] = value;

  String get uuid => jsProxy['uuid'];
  set uuid(String value) => jsProxy['uuid'] = value;
}

/**
 * Data from an `onAccept` event.
 */
class BluetoothAcceptInfo extends ChromeObject {
  BluetoothAcceptInfo({int socketId, int clientSocketId}) {
    if (socketId != null) this.socketId = socketId;
    if (clientSocketId != null) this.clientSocketId = clientSocketId;
  }
  BluetoothAcceptInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get socketId => jsProxy['socketId'];
  set socketId(int value) => jsProxy['socketId'] = value;

  int get clientSocketId => jsProxy['clientSocketId'];
  set clientSocketId(int value) => jsProxy['clientSocketId'] = value;
}

/**
 * Data from an `onAcceptError` event.
 */
class BluetoothAcceptErrorInfo extends ChromeObject {
  BluetoothAcceptErrorInfo({int socketId, String errorMessage, AcceptError error}) {
    if (socketId != null) this.socketId = socketId;
    if (errorMessage != null) this.errorMessage = errorMessage;
    if (error != null) this.error = error;
  }
  BluetoothAcceptErrorInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get socketId => jsProxy['socketId'];
  set socketId(int value) => jsProxy['socketId'] = value;

  String get errorMessage => jsProxy['errorMessage'];
  set errorMessage(String value) => jsProxy['errorMessage'] = value;

  AcceptError get error => _createAcceptError(jsProxy['error']);
  set error(AcceptError value) => jsProxy['error'] = jsify(value);
}

/**
 * Data from an `onReceive` event.
 */
class BluetoothReceiveInfo extends ChromeObject {
  BluetoothReceiveInfo({int socketId, ArrayBuffer data}) {
    if (socketId != null) this.socketId = socketId;
    if (data != null) this.data = data;
  }
  BluetoothReceiveInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get socketId => jsProxy['socketId'];
  set socketId(int value) => jsProxy['socketId'] = value;

  ArrayBuffer get data => _createArrayBuffer(jsProxy['data']);
  set data(ArrayBuffer value) => jsProxy['data'] = jsify(value);
}

/**
 * Data from an `onReceiveError` event.
 */
class BluetoothReceiveErrorInfo extends ChromeObject {
  BluetoothReceiveErrorInfo({int socketId, String errorMessage, BluetoothReceiveError error}) {
    if (socketId != null) this.socketId = socketId;
    if (errorMessage != null) this.errorMessage = errorMessage;
    if (error != null) this.error = error;
  }
  BluetoothReceiveErrorInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get socketId => jsProxy['socketId'];
  set socketId(int value) => jsProxy['socketId'] = value;

  String get errorMessage => jsProxy['errorMessage'];
  set errorMessage(String value) => jsProxy['errorMessage'] = value;

  BluetoothReceiveError get error => _createReceiveError(jsProxy['error']);
  set error(BluetoothReceiveError value) => jsProxy['error'] = jsify(value);
}

BluetoothAcceptInfo _createAcceptInfo(JsObject jsProxy) => jsProxy == null ? null : new BluetoothAcceptInfo.fromProxy(jsProxy);
BluetoothAcceptErrorInfo _createAcceptErrorInfo(JsObject jsProxy) => jsProxy == null ? null : new BluetoothAcceptErrorInfo.fromProxy(jsProxy);
BluetoothReceiveInfo _createReceiveInfo(JsObject jsProxy) => jsProxy == null ? null : new BluetoothReceiveInfo.fromProxy(jsProxy);
BluetoothReceiveErrorInfo _createReceiveErrorInfo(JsObject jsProxy) => jsProxy == null ? null : new BluetoothReceiveErrorInfo.fromProxy(jsProxy);
BluetoothCreateInfo _createCreateInfo(JsObject jsProxy) => jsProxy == null ? null : new BluetoothCreateInfo.fromProxy(jsProxy);
BluetoothSocketInfo _createSocketInfo(JsObject jsProxy) => jsProxy == null ? null : new BluetoothSocketInfo.fromProxy(jsProxy);
AcceptError _createAcceptError(String value) => AcceptError.VALUES.singleWhere((ChromeEnum e) => e.value == value);
ArrayBuffer _createArrayBuffer(/*JsObject*/ jsProxy) => jsProxy == null ? null : new ArrayBuffer.fromProxy(jsProxy);
BluetoothReceiveError _createReceiveError(String value) => BluetoothReceiveError.VALUES.singleWhere((ChromeEnum e) => e.value == value);
