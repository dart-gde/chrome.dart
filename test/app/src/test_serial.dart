library test_serial;

import 'dart:async';

import 'package:unittest/unittest.dart';

import 'package:chrome/app.dart';

void main() {
  group('chrome.serial', () {
    test('constructor', () {
      var serial = new Serial('/tmp/com', 9600);
      expect(serial.port, equals('/tmp/com'));
      expect(serial.speed, equals(9600));
    });

    test('getPorts', () {
      Serial.ports.then(expectAsync1((List<String> ports) {
        expect(ports is List<String>, isTrue);
      }));
    });

//      test('open exception', () {
//        Serial serial = new Serial('/tmp/comcomcomcom', 9600);
//
//        Future<OpenInfo> open = serial.open();
//        open.then((value) {});
//        open.handleException(expectAsync1((error) {
//          expect(error is StateError, isTrue);
//          expect(serial.isConnected, isFalse);
//        }));
//      });
  });
}

