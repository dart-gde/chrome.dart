part of harness_browser;

class TestRuntime {
  void main() {
    group('chrome.runtime', () {
      test('lastError', () {
        var lastError = runtime.lastError;
        logMessage("lastError = ${lastError}");
        expect(lastError.message.isEmpty, isTrue);
      });

      test('id', () {
        String id = runtime.id;
        logMessage("id = ${id}");
        expect(id is String, isTrue);
      });

      test('getBackgroundPage()', () {
        runtime.getBackgroundPage().then(expectAsync1((backgroundPage) {
          logMessage("backgroundPage = ${backgroundPage}");
          logMessage("backgroundPage = ${backgroundPage.location.href}");

          // Example href would be
          // chrome-extension://kcphnlopknifelmkjhgnkhmmnnohngpp/_generated_background_page.html
          expect(backgroundPage is js.Proxy, isTrue);
          expect(backgroundPage.location.href is String, isTrue);
          expect(backgroundPage.location.href.startsWith('chrome-extension://'), isTrue);
          expect(backgroundPage.location.href.endsWith('.html'), isTrue);
        }));
      });

      test('getManifest()', () {
        var manifest = runtime.getManifest();
        logMessage("manifest = ${manifest}");
        expect(manifest is Map, isTrue);
        expect(manifest["manifest_version"], equals(2));
        expect(manifest["name"], equals("chrome.dart - test"));
        expect(manifest["version"], equals("1"));
        expect(manifest["minimum_chrome_version"], equals("23"));
        expect(manifest.containsKey("app"), isTrue);
        expect(manifest["app"].containsKey("background"), isTrue);
        expect(manifest["app"]["background"].containsKey("scripts"), isTrue);
        expect(manifest["app"]["background"]["scripts"], equals(["main.js"]));
      });

      test('getURL(String path)', () {
        var path = runtime.getURL("some/path");
        logMessage("getURL = ${path}");
        expect(path is String, isTrue);
        expect(path.startsWith('chrome-extension://'), isTrue);
        expect(path.endsWith('/some/path'), isTrue);
      });

//      test('reload()', () {
//        // we pass this or else we would just continue to reload the app.
//        expect(true, isTrue);
//      });

      test('requestUpdateCheck()', () {
        runtime.requestUpdateCheck().then(expectAsync1((update) {
          logMessage("update = ${update}");

          expect(update is Map, isTrue);
          expect(update.containsKey('status'), isTrue);
          expect(update.containsKey('details'), isTrue);
          expect(update['status'], equals('no_update'));
          expect(update['details'], isNull);
        }));
      });

//      test('onStartup(Function listener)', () {
//        runtime.onStartup(expectAsync0(() {
//          expect(true, isTrue);
//        }, 1));
//      });
//
//      test('onInstalled(Function listener)', () {
//        runtime.onInstalled(expectAsync1((Map m) {
//          expect(true, isTrue);
//        }));
//      });
//
//      test('onSuspend(Function listener)', () {
//        runtime.onStartup(expectAsync0(() {
//          expect(true, isTrue);
//        }, 1));
//      });
//
//      test('onSuspendCanceled(Function listener)', () {
//        runtime.onStartup(expectAsync0(() {
//          expect(true, isTrue);
//        }, 1));
//      });
//
//      test('onUpdateAvailable(Function listener)', () {
//        runtime.onUpdateAvailable(expectAsync1((Map m) {
//          expect(true, isTrue);
//        }));
//      });

    });
  }
}
