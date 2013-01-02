library test_socket;

import 'dart:html' as html;

import 'package:unittest/html_enhanced_config.dart';
import 'package:unittest/unittest.dart';
import 'package:logging/logging.dart';
import 'package:js/js.dart' as js;

// chrome.dart pollutes the socket.dart library scope from serial.
import 'package:chrome/chrome.dart' as chrome;
import 'package:chrome/src/socket.dart';

class TestSocket {
  Logger _logger = new Logger("TestSocket");

  void main() {
    // TODO(adam): might want to remove the local
    // reference to tempSocketId, tests could be run
    // async. Dont want to have addtional sockets
    // laying around.
    group('chrome.socket', () {
      int tempSocketId;

      test('Socket.create', () {
        Socket.create(new SocketType('tcp')).then(expectAsync1((CreateInfo createInfo) {
          tempSocketId = createInfo.socketId;
          expect(createInfo.socketId, greaterThan(0));
        }));
      });

      test('Socket.destroy', () {
        expect(()=>Socket.destroy(tempSocketId), returnsNormally);
      });

      test('Socket.connect', () {
        Socket.create(new SocketType('tcp')).then(expectAsync1((CreateInfo createInfo) {
          expect(createInfo.socketId, greaterThan(0));
          Socket.connect(createInfo.socketId, "google.com", 80).then(expectAsync1((int connected) {
            Socket.destroy(createInfo.socketId);
            expect(connected, isZero);
          }));
        }));
      });

//      test('Socket.bind', () {});

      test('Socket.disconnect', () {
        Socket.create(new SocketType('tcp')).then(expectAsync1((CreateInfo createInfo) {
          expect(createInfo.socketId, greaterThan(0));
          Socket.connect(createInfo.socketId, "google.com", 80).then(expectAsync1((int connected) {
            Socket.disconnect(createInfo.socketId);
            Socket.destroy(createInfo.socketId);
            expect(connected, isZero);
          }));
        }));
      });

      test('Socket.read', () {
        Socket.create(new SocketType('tcp')).then(expectAsync1((CreateInfo createInfo) {

          expect(createInfo.socketId, greaterThan(0));

          Socket.connect(createInfo.socketId, "128.138.140.44", 13).then(expectAsync1((int connected) {

            expect(connected, isZero);

            Socket.read(createInfo.socketId).then(expectAsync1((ReadInfo readInfo) {
              Socket.disconnect(createInfo.socketId);
              Socket.destroy(createInfo.socketId);

              expect(readInfo.resultCode, greaterThan(0));
              expect(readInfo.data is html.ArrayBuffer, isTrue);
            }));
          }));
        }));
      });

      test('Socket.write', () {
        Socket.create(new SocketType('tcp')).then(expectAsync1((CreateInfo createInfo) {

          expect(createInfo.socketId, greaterThan(0));

          Socket.connect(createInfo.socketId, "google.com", 80).then(expectAsync1((int connected) {

            expect(connected, isZero);

            var writeBuffer = new html.Uint8Array.fromList("GET /\n".charCodes);
            Socket.write(createInfo.socketId, writeBuffer).then(expectAsync1((WriteInfo writeInfo) {

              Socket.disconnect(createInfo.socketId);
              Socket.destroy(createInfo.socketId);

              expect(writeInfo.bytesWritten, equals(6));
            }));
          }));
        }));
      });

//      test('Socket.recvFrom', () {});
//      test('Socket.sendTo', () {});
//      test('Socket.listen', () {});
//      test('Socket.accept', () {});
//      test('Socket.setKeepAlive', () {});
//      test('Socket.setNoDelay', () {});

      test('Socket.getInfo', () {

        Socket.create(new SocketType('tcp')).then(expectAsync1((CreateInfo createInfo) {

          expect(createInfo.socketId, greaterThan(0));

          Socket.connect(createInfo.socketId, "google.com", 80).then(expectAsync1((int connected) {

            expect(connected, isZero);

            Socket.getInfo(createInfo.socketId).then(expectAsync1((SocketInfo socketInfo) {
              expect(socketInfo.socketType.type, equals('tcp'));
              expect(socketInfo.localPort, greaterThan(0));
              expect(socketInfo.peerAddress.isEmpty, isFalse);
              expect(socketInfo.peerPort, greaterThan(0));
              expect(socketInfo.localAddress.isEmpty, isFalse);
              expect(socketInfo.connected, isTrue);

              Socket.disconnect(createInfo.socketId);
              Socket.destroy(createInfo.socketId);
            }));
          }));
        }));
      });

      test('getNetworkList', () {
        Socket.getNetworkList().then(
            expectAsync1((networklist) {
              logMessage(networklist);
              expect(networklist is List, isTrue);
              networklist.forEach((i) => expect(i is NetworkInterface, isTrue));
            }));
        });

    });

    group("chrome.socket.TcpClient", () {

      TcpClient client;
      setUp(() {
        client = new TcpClient("google.com", 80);
      });
      tearDown(() {
        client.disconnect();
      });

      test("connect", () {
        client.connect().then(expectAsync1((bool isConnected) {
          expect(isConnected, isTrue);
          expect(client.isConnected, isTrue);
          client.onRead = expectAsync1((ReadInfo readInfo) {
            expect(readInfo.resultCode, greaterThan(0));
          });

          client.receive = expectAsync1((String message) {
            //_logger.fine("message = ${message}");
            expect(message, isNotNull);
          });

          client.send("GET /\n").then(expectAsync1((writeInfo){
            expect(writeInfo.bytesWritten, equals(6));
          }));
        }));
      });
    });

    group("chrome.socket.TcpServer", () {

      TcpServer server;
      TcpClient client;
      setUp(() {
        server = new TcpServer("127.0.0.1", 7765);
        client = new TcpClient("127.0.0.1", 7765);
      });

      tearDown(() {
        client.disconnect();
        server.disconnect();
      });

      test("listen", () {
        var m = "hello from client\n";
        server.onAccept = expectAsync2((TcpClient c, SocketInfo socketInfo) {
          _logger.fine("server onAccept of client");
          expect(c.isConnected, isTrue);
        });

        server.receive = (String message) {
          _logger.fine("message = $message");
          expect(message, equals(m));
        };

        server.listen().then(expectAsync1((bool isListening) {
          expect(isListening, isTrue);
          expect(server.isListening, isTrue);
          client.connect().then(expectAsync1((bool isConnected) {
            expect(isConnected, isTrue);
            expect(client.isConnected, isTrue);
            _logger.fine("client is connected");

            client.send(m).then(expectAsync1((writeInfo) {
              expect(writeInfo.bytesWritten, equals(m.length));
            }));
          }));

        }));
      });
    });
  }
}
