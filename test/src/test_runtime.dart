part of harness_browser;

class TestRuntime {
  void main() {
    group('chrome.runtime', () {
      test('lastError', () {
        var lastError = runtime.lastError;
        logMessage("lastError = ${lastError}");
        expect(lastError, isNull);
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

          expect(update, new isInstanceOf<UpdateDetails>());
          expect(update.status, 'no_update');
          expect(update.version, isNull);
        }));
      });

      test('onStartup', () {
        runtime.onStartup.listen((_) { }).cancel();
      });

      test('onInstalled', () {
        runtime.onInstalled.listen((InstalledEvent evt) { }).cancel();
      });

      test('onSuspend', () {
        runtime.onSuspend.listen((_) { }).cancel();
      });

      test('onSuspendCanceled', () {
        runtime.onSuspendCanceled.listen((_) { }).cancel();
      });

      test('onUpdateAvailable', () {
        runtime.onUpdateAvailable.listen((String version) { }).cancel();
      });
    });
  }
}
