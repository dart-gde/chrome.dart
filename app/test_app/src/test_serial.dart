library test_serial;

import 'package:unittest/unittest.dart';
import 'package:chrome/chrome_app.dart' as chrome;

void main() {
  group('chrome.serial', () {
    test('getDevices', () {
      chrome.serial.getDevices().then(expectAsync((List<serial.DeviceInfo> devices) {
        logMessage("devices = $devices");
        expect(devices is List<serial.DeviceInfo>, isTrue);
      }));
    });
  });
}
