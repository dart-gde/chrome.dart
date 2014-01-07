library test_serial;

import 'dart:async';

import 'package:unittest/unittest.dart';
import 'package:chrome_gen/chrome_app.dart' as chrome;

void main() {
  group('chrome.serial', () {
    test('getPorts', () {
      chrome.serial.getPorts().then(expectAsync1((List<String> ports) {
        logMessage("ports = $ports");
        expect(ports is List<String>, isTrue);
      }));
    });
  });
}
