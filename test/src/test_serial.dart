part of harness_browser;

class TestSerial {

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
    });
  }
}
