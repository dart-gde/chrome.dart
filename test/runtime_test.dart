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
        Runtime runtime = new Runtime();
        runtime.getBackgroundPage().then(expectAsync1((backgroundPage) {
          logger.fine("backgroundPage = ${backgroundPage}");
          logger.fine("backgroundPage = ${backgroundPage.location.href}");

          // Example href would be 
          // chrome-extension://kcphnlopknifelmkjhgnkhmmnnohngpp/_generated_background_page.html 
          expect(backgroundPage is js.Proxy, isTrue);
          expect(backgroundPage.location.href is String, isTrue);
          expect(backgroundPage.location.href.startsWith('chrome-extension://'), isTrue);
          expect(backgroundPage.location.href.endsWith('.html'), isTrue);
        }));
      });
      
      test('getManifest()', () {
        Runtime runtime = new Runtime();
        runtime.getManifest().then(expectAsync1((Map manifest) {
          logger.fine("manifest = ${manifest}");
          expect(manifest is Map, isTrue);
          expect(manifest["manifest_version"], equals(2));
          expect(manifest["name"], equals("chrome.dart - test"));
          expect(manifest["version"], equals("1"));
          expect(manifest["minimum_chrome_version"], equals("23"));
          expect(manifest.containsKey("app"), isTrue);
          expect(manifest["app"].containsKey("background"), isTrue);
          expect(manifest["app"]["background"].containsKey("scripts"), isTrue);
          expect(manifest["app"]["background"]["scripts"], equals(["main.js"]));
        }));
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
