library test_serial;

import 'package:unittest/unittest.dart';
import 'package:chrome/chrome_app.dart' as chrome;

void main() {
  group('chrome.serial', () {
    test('getPorts', () {
      chrome.serial.getPorts().then(expectAsync((List<String> ports) {
        logMessage("ports = $ports");
        expect(ports is List<String>, isTrue);
      }));
    });
  });
}
