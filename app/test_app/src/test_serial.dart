library test_serial;

import 'package:test/test.dart';
import 'package:chrome/chrome_app.dart' as chrome;

void main() {
  group('chrome.serial', () {
    test('getDevices', () {
      chrome.serial.getDevices().then(expectAsync((List<chrome.DeviceInfo> devices) {
        expect(devices is List<chrome.DeviceInfo>, isTrue);
      }));
    });
  });
}
