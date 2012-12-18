part of harness_browser;

class RuntimeTest {
  Logger logger = new Logger("RuntimeTest");
  
  void main() {
    group('chrome.runtime', () {
      test('lastError', () {
        Runtime runtime = new Runtime();
        runtime.lastError.then(expectAsync1((String s) {
          logger.fine("lastError = ${s}");
          expect(s.isEmpty, isTrue);
        }));
      });
      
      test('id', () {
        Runtime runtime = new Runtime();
        runtime.id.then(expectAsync1((String s) {
          logger.fine("id = ${s}");
          expect(s is String, isTrue);
        }));
      });
      
      test('getBackgroundPage()', () {
        expect(false, isTrue);
      });
      
      test('getManifest()', () {
        expect(false, isTrue);
      });
      
      test('getURL(String path)', () {
        expect(false, isTrue);
      });
      
      test('reload()', () {
        expect(false, isTrue);
      });
      
      test('requestUpdateCheck()', () {
        expect(false, isTrue);
      });
      
      test('onStartup(Function listener)', () {
        expect(false, isTrue);
      });
      
      test('onInstalled(Function listener)', () {
        expect(false, isTrue);
      });
      
      test('onSuspend(Function listener)', () {
        expect(false, isTrue);
      });
      
      test('onSuspendCanceled(Function listener)', () {
        expect(false, isTrue);
      });
      
      test('onUpdateAvailable(Function listener)', () {
        expect(false, isTrue);
      });
    });
  }
}
