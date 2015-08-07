library test_storage;

import 'package:unittest/unittest.dart';
import 'package:chrome/chrome_app.dart' as chrome;

void main() {
  group('chrome.storage', () {
    // local
    test('local.QUOTA_BYTES', () {
      expect(chrome.storage.local.QUOTA_BYTES, greaterThan(5000000));
    });

    // sync
    test('sync.QUOTA_BYTES', () {
      expect(chrome.storage.sync.QUOTA_BYTES, greaterThan(100000));
    });

    test('sync.MAX_ITEMS', () {
      expect(chrome.storage.sync.MAX_ITEMS, greaterThan(500));
    });

    // get, set
    test('local.set_get', () {
      return chrome.storage.local.set({"foo": "bar"})
          .then(expectAsync((_) {
            return chrome.storage.local.get(["foo"]);
          }))
          .then(expectAsync((Map<String, dynamic> result) {
            expect(result, isNotNull);
            expect(result["foo"], equals("bar"));
          }));
    });

    test('local.get_all', () {
      return chrome.storage.local.set({"baz": "123"})
          .then(expectAsync((_) {
            return chrome.storage.local.get(null);
          })).then(expectAsync((Map<String, dynamic> result) {
            expect(result, isNotNull);
            logMessage('local.get contains ${result.length} items');
            expect(result.length, greaterThanOrEqualTo(1));
        }));
    });
  });
}
