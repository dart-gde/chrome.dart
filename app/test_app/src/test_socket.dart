library test_socket;

import 'dart:typed_data' as typed_data;

import 'package:unittest/unittest.dart';
import 'package:chrome/chrome_app.dart' as chrome;
import 'package:chrome/gen/socket.dart';

void main() {
  group('chrome.socket', () {
    test('create', () {
      socket.create(SocketType.TCP)
        .then(expectAsync((CreateInfo createInfo) {
          expect(createInfo.socketId, greaterThan(0));
          expect(() => socket.destroy(createInfo.socketId), returnsNormally);
        }));
    });

    test('connect', () {
      socket.create(SocketType.TCP)
      .then(expectAsync((CreateInfo createInfo) {
        expect(createInfo.socketId, greaterThan(0));
        socket.connect(createInfo.socketId, "google.com", 80)
          .then(expectAsync((int connected) {
            socket.destroy(createInfo.socketId);
            expect(connected, isZero);
        }));
      }));
    });

//      test('Socket.bind', () {});

    test('disconnect', () {
      socket.create(SocketType.TCP)
      .then(expectAsync((CreateInfo createInfo) {
        expect(createInfo.socketId, greaterThan(0));
        socket.connect(createInfo.socketId, "google.com", 80)
          .then(expectAsync((int connected) {
            socket.disconnect(createInfo.socketId);
            socket.destroy(createInfo.socketId);
            expect(connected, isZero);
        }));
      }));
    });

    test('read', () {
      socket.create(SocketType.TCP)
        .then(expectAsync((CreateInfo createInfo) {
        expect(createInfo.socketId, greaterThan(0));
        socket.connect(createInfo.socketId, "128.138.140.44", 13)
          .then(expectAsync((int connected) {
          expect(connected, isZero);
          socket.read(createInfo.socketId)
            .then(expectAsync((SocketReadInfo readInfo) {
              socket.disconnect(createInfo.socketId);
              socket.destroy(createInfo.socketId);
              expect(readInfo.resultCode, greaterThan(0));
              logMessage("readInfo.data.runtimeType = ${readInfo.data.runtimeType}");
              logMessage("readInfo.data = ${readInfo.data}");
              expect(readInfo.data is chrome.ArrayBuffer, isTrue);
          }));
        }));
      }));
    });

    test('write', () {
      socket.create(SocketType.TCP)
        .then(expectAsync((CreateInfo createInfo) {
        expect(createInfo.socketId, greaterThan(0));
        socket.connect(createInfo.socketId, "google.com", 80)
          .then(expectAsync((int connected) {
          expect(connected, isZero);
          var writeBuffer = new typed_data.Uint8List.fromList("GET /\n".codeUnits);
          socket.write(createInfo.socketId,
              new chrome.ArrayBuffer.fromBytes(writeBuffer))
            .then(expectAsync((SocketWriteInfo writeInfo) {
              socket.disconnect(createInfo.socketId);
              socket.destroy(createInfo.socketId);
              logMessage("writeInfo.bytesWritten = ${writeInfo.bytesWritten}");
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

    test('getInfo', () {
      socket.create(SocketType.TCP)
        .then(expectAsync((CreateInfo createInfo) {
        expect(createInfo.socketId, greaterThan(0));
        socket.connect(createInfo.socketId, "google.com", 80)
          .then(expectAsync((int connected) {
          expect(connected, isZero);
          socket.getInfo(createInfo.socketId)
            .then(expectAsync((SocketInfo socketInfo) {
            expect(socketInfo.socketType, equals(SocketType.TCP));
            expect(socketInfo.localPort, greaterThan(0));
            expect(socketInfo.peerAddress.isEmpty, isFalse);
            expect(socketInfo.peerPort, greaterThan(0));
            expect(socketInfo.localAddress.isEmpty, isFalse);
            expect(socketInfo.connected, isTrue);
            socket.disconnect(createInfo.socketId);
            socket.destroy(createInfo.socketId);
          }));
        }));
      }));
    });

    test('getNetworkList', () {
      return socket.getNetworkList().then((List networklist) {
          logMessage("networklist = $networklist");
          expect(networklist is List, isTrue);
          networklist.forEach((i) {
            logMessage("i.name = ${i.name}");
            logMessage("i.address = ${i.address}");
            expect(i is NetworkInterface, isTrue);
          });
       });
    });
  });
}
