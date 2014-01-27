/* This file has been generated from socket.idl - do not edit */

/**
 * Use the `chrome.socket` API to send and receive data over the network using
 * TCP and UDP connections.
 */
library chrome.socket;

import '../src/common.dart';

/**
 * Accessor for the `chrome.socket` namespace.
 */
final ChromeSocket socket = new ChromeSocket._();

class ChromeSocket extends ChromeApi {
  static final JsObject _socket = chrome['socket'];

  ChromeSocket._();

  bool get available => _socket != null;

  /**
   * Creates a socket of the specified type that will connect to the specified
   * remote machine.
   * [type]: The type of socket to create. Must be `tcp` or `udp`.
   * [options]: The socket options.
   * [callback]: Called when the socket has been created.
   */
  Future<CreateInfo> create(SocketType type, [CreateOptions options]) {
    if (_socket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<CreateInfo>.oneArg(_createCreateInfo);
    _socket.callMethod('create', [jsify(type), jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Destroys the socket. Each socket created should be destroyed after use.
   * [socketId]: The socketId.
   */
  void destroy(int socketId) {
    if (_socket == null) _throwNotAvailable();

    _socket.callMethod('destroy', [socketId]);
  }

  /**
   * Connects the socket to the remote machine (for a `tcp` socket). For a `udp`
   * socket, this sets the default address which packets are sent to and read
   * from for `read()` and `write()` calls.
   * [socketId]: The socketId.
   * [hostname]: The hostname or IP address of the remote machine.
   * [port]: The port of the remote machine.
   * [callback]: Called when the connection attempt is complete.
   */
  Future<int> connect(int socketId, String hostname, int port) {
    if (_socket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<int>.oneArg();
    _socket.callMethod('connect', [socketId, hostname, port, completer.callback]);
    return completer.future;
  }

  /**
   * Binds the local address for socket. Currently, it does not support TCP
   * socket.
   * [socketId]: The socketId.
   * [address]: The address of the local machine.
   * [port]: The port of the local machine.
   * [callback]: Called when the bind attempt is complete.
   */
  Future<int> bind(int socketId, String address, int port) {
    if (_socket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<int>.oneArg();
    _socket.callMethod('bind', [socketId, address, port, completer.callback]);
    return completer.future;
  }

  /**
   * Disconnects the socket. For UDP sockets, `disconnect` is a non-operation
   * but is safe to call.
   * [socketId]: The socketId.
   */
  void disconnect(int socketId) {
    if (_socket == null) _throwNotAvailable();

    _socket.callMethod('disconnect', [socketId]);
  }

  /**
   * Reads data from the given connected socket.
   * [socketId]: The socketId.
   * [bufferSize]: The read buffer size.
   * [callback]: Delivers data that was available to be read without blocking.
   */
  Future<SocketReadInfo> read(int socketId, [int bufferSize]) {
    if (_socket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<SocketReadInfo>.oneArg(_createReadInfo);
    _socket.callMethod('read', [socketId, bufferSize, completer.callback]);
    return completer.future;
  }

  /**
   * Writes data on the given connected socket.
   * [socketId]: The socketId.
   * [data]: The data to write.
   * [callback]: Called when the write operation completes without blocking or
   * an error occurs.
   */
  Future<SocketWriteInfo> write(int socketId, ArrayBuffer data) {
    if (_socket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<SocketWriteInfo>.oneArg(_createWriteInfo);
    _socket.callMethod('write', [socketId, jsify(data), completer.callback]);
    return completer.future;
  }

  /**
   * Receives data from the given UDP socket.
   * [socketId]: The socketId.
   * [bufferSize]: The receive buffer size.
   * [callback]: Returns result of the recvFrom operation.
   */
  Future<RecvFromInfo> recvFrom(int socketId, [int bufferSize]) {
    if (_socket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<RecvFromInfo>.oneArg(_createRecvFromInfo);
    _socket.callMethod('recvFrom', [socketId, bufferSize, completer.callback]);
    return completer.future;
  }

  /**
   * Sends data on the given UDP socket to the given address and port.
   * [socketId]: The socketId.
   * [data]: The data to write.
   * [address]: The address of the remote machine.
   * [port]: The port of the remote machine.
   * [callback]: Called when the send operation completes without blocking or an
   * error occurs.
   */
  Future<SocketWriteInfo> sendTo(int socketId, ArrayBuffer data, String address, int port) {
    if (_socket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<SocketWriteInfo>.oneArg(_createWriteInfo);
    _socket.callMethod('sendTo', [socketId, jsify(data), address, port, completer.callback]);
    return completer.future;
  }

  /**
   * This method applies to TCP sockets only. Listens for connections on the
   * specified port and address. This effectively makes this a server socket,
   * and client socket functions (connect, read, write) can no longer be used on
   * this socket.
   * [socketId]: The socketId.
   * [address]: The address of the local machine.
   * [port]: The port of the local machine.
   * [backlog]: Length of the socket's listen queue.
   * [callback]: Called when listen operation completes.
   */
  Future<int> listen(int socketId, String address, int port, [int backlog]) {
    if (_socket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<int>.oneArg();
    _socket.callMethod('listen', [socketId, address, port, backlog, completer.callback]);
    return completer.future;
  }

  /**
   * This method applies to TCP sockets only. Registers a callback function to
   * be called when a connection is accepted on this listening server socket.
   * Listen must be called first. If there is already an active accept callback,
   * this callback will be invoked immediately with an error as the resultCode.
   * [socketId]: The socketId.
   * [callback]: The callback is invoked when a new socket is accepted.
   */
  Future<AcceptInfo> accept(int socketId) {
    if (_socket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<AcceptInfo>.oneArg(_createAcceptInfo);
    _socket.callMethod('accept', [socketId, completer.callback]);
    return completer.future;
  }

  /**
   * Enables or disables the keep-alive functionality for a TCP connection.
   * [socketId]: The socketId.
   * [enable]: If true, enable keep-alive functionality.
   * [delay]: Set the delay seconds between the last data packet received and
   * the first keepalive probe. Default is 0.
   * [callback]: Called when the setKeepAlive attempt is complete.
   */
  Future<bool> setKeepAlive(int socketId, bool enable, [int delay]) {
    if (_socket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _socket.callMethod('setKeepAlive', [socketId, enable, delay, completer.callback]);
    return completer.future;
  }

  /**
   * Sets or clears `TCP_NODELAY` for a TCP connection. Nagle's algorithm will
   * be disabled when `TCP_NODELAY` is set.
   * [socketId]: The socketId.
   * [noDelay]: If true, disables Nagle's algorithm.
   * [callback]: Called when the setNoDelay attempt is complete.
   */
  Future<bool> setNoDelay(int socketId, bool noDelay) {
    if (_socket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _socket.callMethod('setNoDelay', [socketId, noDelay, completer.callback]);
    return completer.future;
  }

  /**
   * Retrieves the state of the given socket.
   * [socketId]: The socketId.
   * [callback]: Called when the state is available.
   */
  Future<SocketInfo> getInfo(int socketId) {
    if (_socket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<SocketInfo>.oneArg(_createSocketInfo);
    _socket.callMethod('getInfo', [socketId, completer.callback]);
    return completer.future;
  }

  /**
   * Retrieves information about local adapters on this system.
   * [callback]: Called when local adapter information is available.
   */
  Future<List<NetworkInterface>> getNetworkList() {
    if (_socket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<NetworkInterface>>.oneArg((e) => listify(e, _createNetworkInterface));
    _socket.callMethod('getNetworkList', [completer.callback]);
    return completer.future;
  }

  /**
   * Join the multicast group and start to receive packets from that group. The
   * socket must be of UDP type and must be bound to a local port before calling
   * this method.
   * [socketId]: The socketId.
   * [address]: The group address to join. Domain names are not supported.
   * [callback]: Called when the join group operation is done with an integer
   * parameter indicating the platform-independent error code.
   */
  Future<int> joinGroup(int socketId, String address) {
    if (_socket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<int>.oneArg();
    _socket.callMethod('joinGroup', [socketId, address, completer.callback]);
    return completer.future;
  }

  /**
   * Leave the multicast group previously joined using `joinGroup`. It's not
   * necessary to leave the multicast group before destroying the socket or
   * exiting. This is automatically called by the OS.
   * 
   * Leaving the group will prevent the router from sending multicast datagrams
   * to the local host, presuming no other process on the host is still joined
   * to the group.
   * 
   * [socketId]: The socketId.
   * [address]: The group address to leave. Domain names are not supported.
   * [callback]: Called when the leave group operation is done with an integer
   * parameter indicating the platform-independent error code.
   */
  Future<int> leaveGroup(int socketId, String address) {
    if (_socket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<int>.oneArg();
    _socket.callMethod('leaveGroup', [socketId, address, completer.callback]);
    return completer.future;
  }

  /**
   * Set the time-to-live of multicast packets sent to the multicast group.
   * 
   * Calling this method does not require multicast permissions.
   * 
   * [socketId]: The socketId.
   * [ttl]: The time-to-live value.
   * [callback]: Called when the configuration operation is done.
   */
  Future<int> setMulticastTimeToLive(int socketId, int ttl) {
    if (_socket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<int>.oneArg();
    _socket.callMethod('setMulticastTimeToLive', [socketId, ttl, completer.callback]);
    return completer.future;
  }

  /**
   * Set whether multicast packets sent from the host to the multicast group
   * will be looped back to the host.
   * 
   * Note: the behavior of `setMulticastLoopbackMode` is slightly different
   * between Windows and Unix-like systems. The inconsistency happens only when
   * there is more than one application on the same host joined to the same
   * multicast group while having different settings on multicast loopback mode.
   * On Windows, the applications with loopback off will not RECEIVE the
   * loopback packets; while on Unix-like systems, the applications with
   * loopback off will not SEND the loopback packets to other applications on
   * the same host. See MSDN: http://goo.gl/6vqbj
   * 
   * Calling this method does not require multicast permissions.
   * 
   * [socketId]: The socketId.
   * [enabled]: Indicate whether to enable loopback mode.
   * [callback]: Called when the configuration operation is done.
   */
  Future<int> setMulticastLoopbackMode(int socketId, bool enabled) {
    if (_socket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<int>.oneArg();
    _socket.callMethod('setMulticastLoopbackMode', [socketId, enabled, completer.callback]);
    return completer.future;
  }

  /**
   * Get the multicast group addresses the socket is currently joined to.
   * [socketId]: The socketId.
   * [callback]: Called with an array of strings of the result.
   */
  Future<List<String>> getJoinedGroups(int socketId) {
    if (_socket == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<String>>.oneArg(listify);
    _socket.callMethod('getJoinedGroups', [socketId, completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.socket' is not available");
  }
}

class SocketType extends ChromeEnum {
  static const SocketType TCP = const SocketType._('tcp');
  static const SocketType UDP = const SocketType._('udp');

  static const List<SocketType> VALUES = const[TCP, UDP];

  const SocketType._(String str): super(str);
}

/**
 * The socket options.
 */
class CreateOptions extends ChromeObject {
  CreateOptions();
  CreateOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

class CreateInfo extends ChromeObject {
  CreateInfo({int socketId}) {
    if (socketId != null) this.socketId = socketId;
  }
  CreateInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get socketId => jsProxy['socketId'];
  set socketId(int value) => jsProxy['socketId'] = value;
}

class AcceptInfo extends ChromeObject {
  AcceptInfo({int resultCode, int socketId}) {
    if (resultCode != null) this.resultCode = resultCode;
    if (socketId != null) this.socketId = socketId;
  }
  AcceptInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get resultCode => jsProxy['resultCode'];
  set resultCode(int value) => jsProxy['resultCode'] = value;

  int get socketId => jsProxy['socketId'];
  set socketId(int value) => jsProxy['socketId'] = value;
}

class SocketReadInfo extends ChromeObject {
  SocketReadInfo({int resultCode, ArrayBuffer data}) {
    if (resultCode != null) this.resultCode = resultCode;
    if (data != null) this.data = data;
  }
  SocketReadInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get resultCode => jsProxy['resultCode'];
  set resultCode(int value) => jsProxy['resultCode'] = value;

  ArrayBuffer get data => _createArrayBuffer(jsProxy['data']);
  set data(ArrayBuffer value) => jsProxy['data'] = jsify(value);
}

class SocketWriteInfo extends ChromeObject {
  SocketWriteInfo({int bytesWritten}) {
    if (bytesWritten != null) this.bytesWritten = bytesWritten;
  }
  SocketWriteInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get bytesWritten => jsProxy['bytesWritten'];
  set bytesWritten(int value) => jsProxy['bytesWritten'] = value;
}

class RecvFromInfo extends ChromeObject {
  RecvFromInfo({int resultCode, ArrayBuffer data, String address, int port}) {
    if (resultCode != null) this.resultCode = resultCode;
    if (data != null) this.data = data;
    if (address != null) this.address = address;
    if (port != null) this.port = port;
  }
  RecvFromInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get resultCode => jsProxy['resultCode'];
  set resultCode(int value) => jsProxy['resultCode'] = value;

  ArrayBuffer get data => _createArrayBuffer(jsProxy['data']);
  set data(ArrayBuffer value) => jsProxy['data'] = jsify(value);

  String get address => jsProxy['address'];
  set address(String value) => jsProxy['address'] = value;

  int get port => jsProxy['port'];
  set port(int value) => jsProxy['port'] = value;
}

class SocketInfo extends ChromeObject {
  SocketInfo({SocketType socketType, bool connected, String peerAddress, int peerPort, String localAddress, int localPort}) {
    if (socketType != null) this.socketType = socketType;
    if (connected != null) this.connected = connected;
    if (peerAddress != null) this.peerAddress = peerAddress;
    if (peerPort != null) this.peerPort = peerPort;
    if (localAddress != null) this.localAddress = localAddress;
    if (localPort != null) this.localPort = localPort;
  }
  SocketInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  SocketType get socketType => _createSocketType(jsProxy['socketType']);
  set socketType(SocketType value) => jsProxy['socketType'] = jsify(value);

  bool get connected => jsProxy['connected'];
  set connected(bool value) => jsProxy['connected'] = value;

  String get peerAddress => jsProxy['peerAddress'];
  set peerAddress(String value) => jsProxy['peerAddress'] = value;

  int get peerPort => jsProxy['peerPort'];
  set peerPort(int value) => jsProxy['peerPort'] = value;

  String get localAddress => jsProxy['localAddress'];
  set localAddress(String value) => jsProxy['localAddress'] = value;

  int get localPort => jsProxy['localPort'];
  set localPort(int value) => jsProxy['localPort'] = value;
}

class NetworkInterface extends ChromeObject {
  NetworkInterface({String name, String address}) {
    if (name != null) this.name = name;
    if (address != null) this.address = address;
  }
  NetworkInterface.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  String get address => jsProxy['address'];
  set address(String value) => jsProxy['address'] = value;
}

CreateInfo _createCreateInfo(JsObject jsProxy) => jsProxy == null ? null : new CreateInfo.fromProxy(jsProxy);
SocketReadInfo _createReadInfo(JsObject jsProxy) => jsProxy == null ? null : new SocketReadInfo.fromProxy(jsProxy);
SocketWriteInfo _createWriteInfo(JsObject jsProxy) => jsProxy == null ? null : new SocketWriteInfo.fromProxy(jsProxy);
RecvFromInfo _createRecvFromInfo(JsObject jsProxy) => jsProxy == null ? null : new RecvFromInfo.fromProxy(jsProxy);
AcceptInfo _createAcceptInfo(JsObject jsProxy) => jsProxy == null ? null : new AcceptInfo.fromProxy(jsProxy);
SocketInfo _createSocketInfo(JsObject jsProxy) => jsProxy == null ? null : new SocketInfo.fromProxy(jsProxy);
NetworkInterface _createNetworkInterface(JsObject jsProxy) => jsProxy == null ? null : new NetworkInterface.fromProxy(jsProxy);
ArrayBuffer _createArrayBuffer(/*JsObject*/ jsProxy) => jsProxy == null ? null : new ArrayBuffer.fromProxy(jsProxy);
SocketType _createSocketType(String value) => SocketType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
