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
        expect(manifest["minimum_chrome_version"], equals("28"));
        expect(manifest.containsKey("app"), isTrue);
        expect(manifest["app"].containsKey("background"), isTrue);
        expect(manifest["app"]["background"].containsKey("scripts"), isTrue);
        expect(manifest["app"]["background"]["scripts"][0], equals("main.js"));
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

      test('getPackageDirectoryEntry()', () {
        runtime.getPackageDirectoryEntry().then(expectAsync1((DirectoryEntry dir) {
          expect(dir, isNotNull);
          expect(dir.name.length, greaterThanOrEqualTo(1));

          logMessage("packages dir = ${dir}");
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

      test('sendMessage/onMessage', () {
        // onMessage handler is added in background page and will respond to
        // any message with 'respond: $message'
        expect(runtime.sendMessage('test message'),
            completion('respond: test message'));
      });

      test('Test that a call to getPlatformInfo succeeds', () {
        runtime.getPlatformInfo().then(expectAsync1((PlatformInfo info) {
          String htmlPlatformInfo =
              html.window.navigator.platform.toLowerCase();
          expect(htmlPlatformInfo, contains(info.os));
        }));
      });
    });
  }
}
