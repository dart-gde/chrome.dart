library chrome_socket;

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

// duplicate, move to common lib
class ReadInfo {
  int resultCode;
  var data; /* arrayBuffer */
  ReadInfo(this.resultCode, this.data);
}

class WriteInfo {
  int bytesWritten;
  WriteInfo(this.bytesWritten);
}

class RecvFromInfo {
  int resultCode;
  var data; /* arrayBuffer */
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
}

class NetworkInterface {
  String name;
  String address;
  NetworkInterface(this.name, this.address);
}

class Socket {
  static Future<CreateInfo> create(SocketType socketType, CreateOptions options) {
    var completer = new Completer();
    _jsCreate() {
      void createCallback(var result) {
        var createInfo = new CreateInfo(result.socketId);
        completer.complete(createInfo);
      };

      js.context.createCallback = new js.Callback.once(createCallback);
      js.context.chrome.socket.create(socketType.type, {}, js.context.createCallback);
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

  static Future<ReadInfo> read(int socketId, int bufferSize) {
    var completer = new Completer();
    _jsRead() {
      void readCallback(var result) {
        // TODO(adam): convert result.data to native dart data type.
        var readInfo = new ReadInfo(result.resultCode, result.data);
        completer.complete(readInfo);
      };

      js.context.readCallback = new js.Callback.once(readCallback);
      js.context.chrome.socket.read(socketId, bufferSize, js.context.readCallback);
    };
    js.scoped(_jsRead);
    return completer.future;
  }

  static Future<WriteInfo> write(int socketId, /* arraybuffer */ data) {
    var completer = new Completer();
    _jsWrite() {
      void writeCallback(var result) {
        var writeInfo = new WriteInfo(result.bytesWritten);
        completer.complete(writeInfo);
      };

      js.context.writeCallback = new js.Callback.once(writeCallback);
      js.context.chrome.socket.write(socketId, data, js.context.writeCallback);
    };
    js.scoped(js.context.readCallback);
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
        // TODO(adam): parse to dart map, then parse in SocketInfo.fromMap(m) constructor.
        var socketInfo = new SocketInfo(result.socketType, result.localPort, result.peerAddress, result.peerPort, result.localAddress, result.connected);
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

class TcpSocket {

}

class UdpSocket {

}