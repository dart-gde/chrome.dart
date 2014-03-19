library test_serial;

import 'package:unittest/unittest.dart';
import 'package:chrome/chrome_app.dart' as chrome;

void main() {
  group('chrome.serial', () {
    test('getDevices', () {
      chrome.serial.getDevices().then(expectAsync((List<chrome.DeviceInfo> devices) {
        logMessage("devices = $devices");
        expect(devices is List<chrome.DeviceInfo>, isTrue);
      }));
    });
  });
}
