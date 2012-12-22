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
}

class NetworkInterface {
  String name;
  String address;
  NetworkInterface(this.name, this.address);
}

class Socket {
  static Future<CreateInfo> create(SocketType type, CreateOptions options) {
    var completer = new Completer();
    _js() {
      throw "not implemented";
    };
    js.scoped(_js);
    return completer.future;
  }

  static destroy(int socketId) {}

  static Future<int> connect(int socketId, String hostname, int port) {
    var completer = new Completer();
    _js() {
      throw "not implemented";
    };
    js.scoped(_js);
    return completer.future;
  }

  static Future<int> bind(int socketId, String address, int port) {
    var completer = new Completer();
    _js() {
      throw "not implemented";
    };
    js.scoped(_js);
    return completer.future;
  }

  static disconnect(int socketId) {}

  static Future<ReadInfo> read(int socketId, int bufferSize) {
    var completer = new Completer();
    _js() {
      throw "not implemented";
    };
    js.scoped(_js);
    return completer.future;
  }

  static Future<WriteInfo> write(int socketId, /* arraybuffer */ data) {
    var completer = new Completer();
    _js() {
      throw "not implemented";
    };
    js.scoped(_js);
    return completer.future;
  }

  static Future<RecvFromInfo> recvFrom(int socketId, int bufferSize) {
    var completer = new Completer();
    _js() {
      throw "not implemented";
    };
    js.scoped(_js);
    return completer.future;
  }

  static Future<WriteInfo> sendTo(int socketId, /* arraybuffer */ data, String address, int port) {
    var completer = new Completer();
    _js() {
      throw "not implemented";
    };
    js.scoped(_js);
    return completer.future;
  }

  static Future<int> listen(int socketId, String address, int port, int backlog) {
    var completer = new Completer();
    _js() {
      throw "not implemented";
    };
    js.scoped(_js);
    return completer.future;
  }

  static Future<AcceptInfo> accept(int socketId) {
    var completer = new Completer();
    _js() {
      throw "not implemented";
    };
    js.scoped(_js);
    return completer.future;
  }

  static Future<bool> setKeepAlive(int socketId, bool enable, int delay) {
    var completer = new Completer();
    _js() {
      throw "not implemented";
    };
    js.scoped(_js);
    return completer.future;
  }

  static Future<bool> setNoDelay(int socketId, bool noDelay) {
    var completer = new Completer();
    _js() {
      throw "not implemented";
    };
    js.scoped(_js);
    return completer.future;
  }

  static Future<SocketInfo> getInfo(int socketId) {
    var completer = new Completer();
    _js() {
      throw "not implemented";
    };
    js.scoped(_js);
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

      js.context.getNetworkList = new js.Callback.once(getNetworkListCallback);
      js.context.chrome.socket.getNetworkList(js.context.getNetworkList);
    };

    js.scoped(_jsGetNetworkList);

    return completer.future;
  }
}

class TcpSocket {

}

class UdpSocket {

}