library test_socket;

import 'dart:async';
import 'dart:typed_data' as typed_data;

import 'package:unittest/unittest.dart';
import 'package:chrome_gen/chrome_app.dart' as chrome;

void main() {
  group('chrome.socket', () {
    test('create', () {
      chrome.socket.create(chrome.SocketType.TCP)
        .then(expectAsync1((chrome.CreateInfo createInfo) {
          expect(createInfo.socketId, greaterThan(0));
          expect(() => chrome.socket.destroy(createInfo.socketId), returnsNormally);
        }));
    });

    test('connect', () {
      chrome.socket.create(chrome.SocketType.TCP)
      .then(expectAsync1((chrome.CreateInfo createInfo) {
        expect(createInfo.socketId, greaterThan(0));
        chrome.socket.connect(createInfo.socketId, "google.com", 80)
          .then(expectAsync1((int connected) {
            chrome.socket.destroy(createInfo.socketId);
            expect(connected, isZero);
        }));
      }));
    });

//      test('Socket.bind', () {});

    test('disconnect', () {
      chrome.socket.create(chrome.SocketType.TCP)
      .then(expectAsync1((chrome.CreateInfo createInfo) {
        expect(createInfo.socketId, greaterThan(0));
        chrome.socket.connect(createInfo.socketId, "google.com", 80)
          .then(expectAsync1((int connected) {
            chrome.socket.disconnect(createInfo.socketId);
            chrome.socket.destroy(createInfo.socketId);
            expect(connected, isZero);
        }));
      }));
    });

    test('read', () {
      chrome.socket.create(chrome.SocketType.TCP)
        .then(expectAsync1((chrome.CreateInfo createInfo) {
        expect(createInfo.socketId, greaterThan(0));
        chrome.socket.connect(createInfo.socketId, "128.138.140.44", 13)
          .then(expectAsync1((int connected) {
          expect(connected, isZero);
          chrome.socket.read(createInfo.socketId)
            .then(expectAsync1((chrome.SocketReadInfo readInfo) {
              chrome.socket.disconnect(createInfo.socketId);
              chrome.socket.destroy(createInfo.socketId);
              expect(readInfo.resultCode, greaterThan(0));
              logMessage("readInfo.data.runtimeType = ${readInfo.data.runtimeType}");
              logMessage("readInfo.data = ${readInfo.data}");
              expect(readInfo.data is chrome.ArrayBuffer, isTrue);
          }));
        }));
      }));
    });

    test('write', () {
      chrome.socket.create(chrome.SocketType.TCP)
        .then(expectAsync1((chrome.CreateInfo createInfo) {
        expect(createInfo.socketId, greaterThan(0));
        chrome.socket.connect(createInfo.socketId, "google.com", 80)
          .then(expectAsync1((int connected) {
          expect(connected, isZero);
          var writeBuffer = new typed_data.Uint8List.fromList("GET /\n".codeUnits);
          chrome.socket.write(createInfo.socketId,
              new chrome.ArrayBuffer.fromBytes(writeBuffer))
            .then(expectAsync1((chrome.SocketWriteInfo writeInfo) {
              chrome.socket.disconnect(createInfo.socketId);
              chrome.socket.destroy(createInfo.socketId);
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
      chrome.socket.create(chrome.SocketType.TCP)
        .then(expectAsync1((chrome.CreateInfo createInfo) {
        expect(createInfo.socketId, greaterThan(0));
        chrome.socket.connect(createInfo.socketId, "google.com", 80)
          .then(expectAsync1((int connected) {
          expect(connected, isZero);
          chrome.socket.getInfo(createInfo.socketId)
            .then(expectAsync1((chrome.SocketInfo socketInfo) {
            expect(socketInfo.socketType, equals(chrome.SocketType.TCP));
            expect(socketInfo.localPort, greaterThan(0));
            expect(socketInfo.peerAddress.isEmpty, isFalse);
            expect(socketInfo.peerPort, greaterThan(0));
            expect(socketInfo.localAddress.isEmpty, isFalse);
            expect(socketInfo.connected, isTrue);
            chrome.socket.disconnect(createInfo.socketId);
            chrome.socket.destroy(createInfo.socketId);
          }));
        }));
      }));
    });

    test('getNetworkList', () {
      chrome.socket.getNetworkList().then(
          expectAsync1((List<chrome.NetworkInterface> networklist) {
            logMessage("networklist = $networklist");
            expect(networklist is List, isTrue);
            networklist.forEach((i) {
              logMessage("i.name = ${i.name}");
              logMessage("i.address = ${i.address}");
              expect(i is chrome.NetworkInterface, isTrue);
            });
       }));
    });
  });
}
