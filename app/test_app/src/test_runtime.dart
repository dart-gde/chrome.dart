library test_runtime;

import 'dart:html' as html;

import 'package:unittest/unittest.dart';
import 'package:chrome/chrome_app.dart' as chrome;
// TODO: figure out if windows.dart should be exported.
import 'package:chrome/gen/windows.dart' as w;

void main() {
  logMessage("test_runtime.main()");

  group('chrome.runtime', () {
    test('lastError', () {
      var lastError = chrome.runtime.lastError;
      logMessage("lastError = ${lastError}");
      expect(lastError, isNull);
    });

    test('id', () {
      String id = chrome.runtime.id;
      logMessage("id = ${id}");
      expect(id is String, isTrue);
    });

    test('getBackgroundPage()', () {
      chrome.runtime.getBackgroundPage()
        .then(expectAsync((w.Window backgroundPage) {
          logMessage("backgroundPage = ${backgroundPage.id}");
          logMessage("backgroundPage = ${backgroundPage.type}");
          logMessage("backgroundPage = ${backgroundPage.state}");
          // TODO: have better test coverage for background page.
          // This used to pass in the old test suite.
          expect(true, isTrue);
        }));
    });

    test('getManifest()', () {
      Map<String, dynamic> manifest = chrome.runtime.getManifest();
      logMessage("manifest = ${manifest}");
      expect(manifest is Map, isTrue);
      expect(manifest["manifest_version"], equals(2));
      expect(manifest["name"], equals("chrome.dart - test"));
      expect(manifest["version"], equals("1"));
      expect(manifest["minimum_chrome_version"], equals("28"));
      expect(manifest.containsKey("app"), isTrue);
      expect(manifest["app"].containsKey("background"), isTrue);
      expect(manifest["app"]["background"].containsKey("scripts"), isTrue);
      expect(manifest["app"]["background"]["scripts"][0], equals("background.js"));
    });

    test('getURL(String path)', () {
      var path = chrome.runtime.getURL("some/path");
      logMessage("getURL = ${path}");
      expect(path is String, isTrue);
      expect(path.startsWith('chrome-extension://'), isTrue);
      expect(path.endsWith('/some/path'), isTrue);
    });

////      test('reload()', () {
////        // we pass this or else we would just continue to reload the app.
////        expect(true, isTrue);
////      });

    test('requestUpdateCheck()', () {
      chrome.runtime.requestUpdateCheck()
        .then(expectAsync((chrome.RequestUpdateCheckResult update) {
        logMessage("update = ${update}");

        expect(update, new isInstanceOf<chrome.RequestUpdateCheckResult>());
        expect(update.status, 'no_update');
        expect(update.details, isNull);
      }));
    });

    test('getPackageDirectoryEntry()', () {
      chrome.runtime.getPackageDirectoryEntry()
        .then(expectAsync((chrome.DirectoryEntry dir) {
        expect(dir, isNotNull);
        expect(dir.name.length, greaterThanOrEqualTo(1));
        logMessage("packages dir = ${dir}");
      }));
    });

    test('onStartup', () {
      chrome.runtime.onStartup.listen((_) { }).cancel();
    });

    test('onInstalled', () {
      chrome.runtime.onInstalled
        .listen((Map<dynamic, dynamic> evt) { }).cancel();
    });

    test('onSuspend', () {
      chrome.runtime.onSuspend.listen((_) { }).cancel();
    });

    test('onSuspendCanceled', () {
      chrome.runtime.onSuspendCanceled.listen((_) { }).cancel();
    });

    test('onUpdateAvailable', () {
      chrome.runtime.onUpdateAvailable
        .listen((Map<String, dynamic> version) { }).cancel();
    });

// TODO: sendMessage fails, invalid arguments.
//    test('sendMessage/onMessage', () {
//      // onMessage handler is added in background page and will respond to
//      // any message with 'respond: $message'
//      expect(chrome.runtime.sendMessage('test message'),
//          completion('respond: test message'));
//    });

    test('Test that a call to getPlatformInfo succeeds', () {
      chrome.runtime.getPlatformInfo()
        .then(expectAsync((Map<dynamic, dynamic> info) {
          logMessage("info = ${info}");
        String htmlPlatformInfo =
            html.window.navigator.platform.toLowerCase();
        expect(htmlPlatformInfo, contains(info["os"]));
      }));
    });
  });
}
