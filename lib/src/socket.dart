// TODO(adam): correct all optional parameters

library chrome_socket;

import 'dart:html' as html;

import 'dart:json';

import 'package:js/js.dart' as js;
import 'package:logging/logging.dart';

import 'runtime.dart';

class SocketType {
  String type;
  SocketType(this.type);
}

class CreateOptions {

}

class CreateInfo {
  int socketId;
  CreateInfo(this.socketId);
}

class AcceptInfo {
  int resultCode;
  int socketId;
  AcceptInfo(this.resultCode, this.socketId);
}

class ReadInfo {
  int resultCode;
  int socketId;
  html.ArrayBuffer data; /* ArrayBuffer */
  ReadInfo(this.resultCode, this.data, {this.socketId});
}

class WriteInfo {
  int bytesWritten;
  WriteInfo(this.bytesWritten);
}

class RecvFromInfo {
  int resultCode;
  html.ArrayBuffer data; /* arrayBuffer */
  int port;
  String address;
  RecvFromInfo(this.resultCode, this.address, this.port, this.data);
}

class SocketInfo {
  SocketType socketType;
  int localPort;
  String peerAddress;
  int peerPort;
  String localAddress;
  bool connected;

  SocketInfo(this.socketType, this.localPort, this.peerAddress, this.peerPort, this.localAddress, this.connected);

  SocketInfo.fromMap(Map map) {
    _parseMap(map);
  }

  _parseMap(Map map) {
    this.connected = map.containsKey('connected') ? map['connected'] : null;
    this.localAddress = map.containsKey('localAddress') ? map['localAddress'] : null;
    this.localPort = map.containsKey('localPort') ? map['localPort'] : null;
    this.peerAddress = map.containsKey('peerAddress') ? map['peerAddress'] : null;
    this.peerPort = map.containsKey('peerPort') ? map['peerPort'] : null;
    this.socketType = map.containsKey('socketType') ? new SocketType(map['socketType']) : null;
  }

}

class NetworkInterface {
  String name;
  String address;
  NetworkInterface(this.name, this.address);
}

class Socket {
  static final Logger _logger = new Logger("chrome.socket");

  static Future<CreateInfo> create(SocketType socketType, {CreateOptions options: null}) {
    var completer = new Completer();
    _jsCreate() {
      void createCallback(var result) {
        var createInfo = new CreateInfo(result.socketId);
        completer.complete(createInfo);
      };

      js.context.createCallback = new js.Callback.once(createCallback);
      js.context.chrome.socket.create(socketType.type, options, js.context.createCallback);
    };
    js.scoped(_jsCreate);
    return completer.future;
  }

  static void destroy(int socketId) {
    _jsDestroy() {
      js.context.chrome.socket.destroy(socketId);
    };
    js.scoped(_jsDestroy);
  }

  static Future<int> connect(int socketId, String hostname, int port) {
    var completer = new Completer();
    _jsConnect() {
      void connectCallback(var result) {
        completer.complete(result);
      }

      js.context.connectCallback = new js.Callback.once(connectCallback);
      js.context.chrome.socket.connect(socketId, hostname, port, js.context.connectCallback);
    };
    js.scoped(_jsConnect);
    return completer.future;
  }

  static Future<int> bind(int socketId, String address, int port) {
    var completer = new Completer();
    _jsBind() {
      void bindCallback(var result) {
        completer.complete(result);
      };
      js.context.bindCallback = new js.Callback.once(bindCallback);
      js.context.chrome.socket.bind(socketId, address, port, js.context.bindCallback);
    };
    js.scoped(_jsBind);
    return completer.future;
  }

  static void disconnect(int socketId) {
    _jsDisconnect() {
      js.context.chrome.socket.disconnect(socketId);
    };
    js.scoped(_jsDisconnect);
  }

  static Future<ReadInfo> read(int socketId, {int bufferSize: null}) {
    // XXX: does it matter if we use uint8 or larger?
    var completer = new Completer();
    _jsRead() {
      void readCallback(var result) {
        // result.resultCode returns the count via the C call
        // to read();

        // XXX: maybe using a blob reader would be easier to read.
        // Convert from javascript ArrayBuffer to dart ArrayBuffer
        var jsArrayBuffer = new js.Proxy(js.context.ArrayBuffer, result.data);
        var arrayBuffer = new html.ArrayBuffer(result.resultCode);
        var arrayBufferView = new html.Uint8Array.fromBuffer(arrayBuffer);

        for (int i = 0; i < result.resultCode; i++) {
          arrayBufferView[i] = jsArrayBuffer[i];
        }

        var readInfo = new ReadInfo(result.resultCode, arrayBufferView.buffer, socketId: socketId);
        completer.complete(readInfo);
      };

      js.context.readCallback = new js.Callback.once(readCallback);
      js.context.chrome.socket.read(socketId, bufferSize, js.context.readCallback);
    };
    js.scoped(_jsRead);
    return completer.future;
  }

  static Future<WriteInfo> write(int socketId, html.Uint8Array data) {
    // XXX: does it matter if we use uint8 or larger?
    var completer = new Completer();
    _jsWrite() {
      void writeCallback(var result) {
        var writeInfo = new WriteInfo(result.bytesWritten);
        completer.complete(writeInfo);
      };

      js.context.writeCallback = new js.Callback.once(writeCallback);
      var buf = new js.Proxy(js.context.ArrayBuffer, data.length);
      var bufView = new js.Proxy(js.context.Uint8Array, buf)
      ..set(js.array(data));

      js.context.chrome.socket.write(socketId, buf, js.context.writeCallback);
    };
    js.scoped(_jsWrite);
    return completer.future;
  }

  static Future<RecvFromInfo> recvFrom(int socketId, int bufferSize) {
    var completer = new Completer();
    _jsRecvFrom() {
      void recvFromCallback(var result) {
        var recvFromInfo = new RecvFromInfo(result.resultCode, result.address, result.port, result.data);
        completer.complete(recvFromInfo);
      };

      js.context.recvFromCallback = new js.Callback.once(recvFromCallback);
      js.context.chrome.socket.recvFrom(socketId, bufferSize, js.context.recvFromCallback);
    };
    js.scoped(_jsRecvFrom);
    return completer.future;
  }

  static Future<WriteInfo> sendTo(int socketId, /* arraybuffer */ data, String address, int port) {
    var completer = new Completer();
    _jsSendTo() {
      void sendToCallback(var result) {
        var writeInfo = new WriteInfo(result.bytesWritten);
        completer.complete(writeInfo);
      };

      js.context.sendToCallback = new js.Callback.once(sendToCallback);
      js.context.chrome.socket.sendTo(socketId, data, address, port, js.context.sendToCallback);
    };
    js.scoped(_jsSendTo);
    return completer.future;
  }

  static Future<int> listen(int socketId, String address, int port, int backlog) {
    var completer = new Completer();
    _jsListen() {
      void listenCallback(var result) {
        completer.complete(result);
      };

      js.context.listenCallback = new js.Callback.once(listenCallback);
      js.context.chrome.socket.listen(socketId, address, port, backlog, js.context.listenCallback);
    };
    js.scoped(_jsListen);
    return completer.future;
  }

  static Future<AcceptInfo> accept(int socketId) {
    var completer = new Completer();
    _jsAccept() {
      void acceptCallback(var result) {
        var acceptInfo = new AcceptInfo(result.resultCode, result.socketId);
        completer.complete(acceptInfo);
      };

      js.context.acceptCallback = new js.Callback.once(acceptCallback);
      js.context.chrome.socket.accept(socketId, js.context.acceptCallback);
    };
    js.scoped(_jsAccept);
    return completer.future;
  }

  static Future<bool> setKeepAlive(int socketId, bool enable, int delay) {
    var completer = new Completer();
    _jsSetKeepAlive() {
      void setKeepAliveCallback(var result) {
        completer.complete(result);
      };

      js.context.setKeepAliveCallback = new js.Callback.once(setKeepAliveCallback);
      js.context.chrome.socket.setKeepAlive(socketId, enable, delay, js.context.setKeepAliveCallback);
    };
    js.scoped(_jsSetKeepAlive);
    return completer.future;
  }

  static Future<bool> setNoDelay(int socketId, bool noDelay) {
    var completer = new Completer();
    _jsSetNoDelay() {
      void setNoDelayCallback(var result) {
        completer.complete(result);
      };

      js.context.setNoDelay = new js.Callback.once(setNoDelayCallback);
      js.context.chrome.socket.setNoDelay(socketId, noDelay, js.context.setNoDelay);
    };
    js.scoped(_jsSetNoDelay);
    return completer.future;
  }

  static Future<SocketInfo> getInfo(int socketId) {
    var completer = new Completer();
    _jsGetInfo() {
      void getInfoCallback(var result) {
        var socketInfo = new SocketInfo.fromMap(JSON.parse(js.context.JSON.stringify(result)));
        completer.complete(socketInfo);
      };

      js.context.getInfoCallback = new js.Callback.once(getInfoCallback);
      js.context.chrome.socket.getInfo(socketId, js.context.getInfoCallback);
    };
    js.scoped(_jsGetInfo);
    return completer.future;
  }

  static Future<NetworkInterface> getNetworkList() {
    var completer = new Completer();

    _jsGetNetworkList() {
      void getNetworkListCallback(var result) {
        var networkInterfaces = [];
        for (int i = 0; i < result.length; i++) {
          networkInterfaces.add(new NetworkInterface(result[i].name, result[i].address));
        }
        completer.complete(networkInterfaces);
      };

      js.context.getNetworkListCallback = new js.Callback.once(getNetworkListCallback);
      js.context.chrome.socket.getNetworkList(js.context.getNetworkListCallback);
    };

    js.scoped(_jsGetNetworkList);

    return completer.future;
  }
}

typedef void OnReadTcpSocket(ReadInfo readInfo);
typedef void OnReceived(String message);

class TcpClient {
  String host;
  int port;

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  SocketType _socketType;
  CreateInfo _createInfo;

  TcpClient(this.host, this.port);

  TcpClient.fromSocketId(int socketId, {OnAcceptedCallback connected: null}) {
    state.then((SocketInfo socketInfo) {
      port = socketInfo.peerPort;
      host = socketInfo.peerAddress;

      _isConnected = true;
      _setupDataPoll();

      if (connected != null) {
        connected(this, socketInfo);
      }
    });
  }

  Future<SocketInfo> get state {
    return Socket.getInfo(_createInfo.socketId);
  }

  Future<bool> connect() {
    var completer = new Completer();
    _socketType = new SocketType('tcp');
    Socket.create(_socketType).then((CreateInfo createInfo) {
      _createInfo = createInfo;
      Socket.connect(_createInfo.socketId, host, port).then((int result) {
        _isConnected = true;
        _setupDataPoll();
        completer.complete(_isConnected);
      });
    });
    return completer.future;
  }

  disconnect() {
    Socket.disconnect(_createInfo.socketId);
    _isConnected = false;
  }

  Future<WriteInfo> send(String message) {
    var completer = new Completer();
    var blob = new html.Blob([message]);
    var fileReader = new html.FileReader();
    fileReader.on.load.add((html.Event event) {
      Socket.write(_createInfo.socketId, fileReader.result).then((WriteInfo writeInfo) {
        completer.complete(writeInfo);
      });
    });
    fileReader.readAsArrayBuffer(blob);
    return completer.future;
  }

  void _setupDataPoll() {
    html.window.setInterval(_read, 500);
  }

  OnReceived receive; // passed a String
  OnReadTcpSocket onRead; // passed a ReadInfo
  void _read() {
    Socket.read(_createInfo.socketId).then((ReadInfo readInfo) {
      if (onRead != null) {
        onRead(readInfo);
      }

      if (receive != null) {
        // Convert back to string and invoke receive
        // Might want to add this kind of method
        // onto ReadInfo
        var blob = new html.Blob([new html.Uint8Array.fromBuffer(readInfo.data)]);
        var fileReader = new html.FileReader();
        fileReader.on.load.add((html.Event event) {
          receive(fileReader.result);
        });
        fileReader.readAsText(blob);
      }
    });
  }
}

typedef OnAcceptedCallback(TcpClient client, SocketInfo socketInfo);

class TcpServer {
  Logger _logger = new Logger("TcpServer");

  var _openConnections = []; // list of open sockets
  CreateInfo _createInfo; // socketid data

  String address;
  int port;
  int backlog;
  var options;

  bool _isListening = false;
  bool get isListening => _isListening;

  TcpServer(this.address, this.port, {this.backlog: 5, this.options});

  _onReceived(String message) {
    _logger.fine("message: ${message}");
  }

  _onReadTcpSocket(ReadInfo readInfo) {

  }

  OnAcceptedCallback onAccept;
  _onAccept(AcceptInfo acceptInfo) {
    // continue to accept other connections.
    Socket.accept(_createInfo.socketId).then(_onAccept);

    if (acceptInfo.resultCode == 0) {
      // successful
      var tcpConnection = new TcpClient.fromSocketId(acceptInfo.socketId, connected: onAccept);
      tcpConnection
      ..receive = _onReceived
      ..onRead = _onReadTcpSocket;
      _openConnections.add(tcpConnection);

    } else {
      // error
      _logger.shout("accept(): resultCode = ${acceptInfo.resultCode}");
    }
  }

  _onListen() {
    Socket.listen(_createInfo.socketId, address, port, backlog)
    .then((int resultCode) {
      if (resultCode == 0) {
        Socket.accept(_createInfo.socketId).then(_onAccept);
      } else {
        // error
        _logger.shout("listen(): resultCode = ${resultCode}");
      }
    });
  }

  Future<bool> listen() {
    var completer = new Completer();
    Socket.create(new SocketType('tcp')).then((CreateInfo createInfo) {
      _createInfo = createInfo;

      _onListen();

      _isListening = true;
      completer.complete(isListening);
    });

    return completer.future;
  }

  connect() {}

  void disconnect() {
    if (_createInfo != null) {
      Socket.disconnect(_createInfo.socketId);
    }

    _openConnections.forEach((s) {
      Socket.disconnect(s.socketId);
    });

    _openConnections.clear();
    _createInfo = null;
  }

  receive() {}
  send() {}
}

class UdpSocket {

  UdpSocket() {

  }

  connect() {}
  poll() {}
  receive() {}
  disconnect() {}
}