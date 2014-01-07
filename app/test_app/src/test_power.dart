library test_power;

import 'package:unittest/unittest.dart';
import 'package:chrome/chrome_app.dart' as chrome;

void main() {
  group('chrome.power', () {
    test('requestKeepAwake', () {
      // test that calling these methods do not throw
      chrome.power.requestKeepAwake(chrome.Level.SYSTEM);
      chrome.power.requestKeepAwake(chrome.Level.SYSTEM);

      // call release to ensure that we don't keep the display on after the
      // tests run
      chrome.power.releaseKeepAwake();
    });

    test('releaseKeepAwake', () {
      // test that calling this method does not throw
      chrome.power.releaseKeepAwake();
    });
  });
}
