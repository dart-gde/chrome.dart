library test_storage;

import 'dart:async';

import 'package:unittest/unittest.dart';

import 'package:chrome/src/storage.dart';

void main() {
  group('chrome.storage', () {
    // local
    test('local.QUOTA_BYTES', () {
      expect(storage.local.QUOTA_BYTES, greaterThan(5000000));
    });

    // sync
    test('sync.QUOTA_BYTES', () {
      expect(storage.sync.QUOTA_BYTES, greaterThan(100000));
    });
    test('sync.MAX_ITEMS', () {
      expect(storage.sync.MAX_ITEMS, greaterThan(500));
    });

    // get, set
    test('local.set_get', () {
      return storage.local.set({"foo": "bar"})
          .then((_) {
            return storage.local.get(["foo"]);
          })
          .then((Map<String, String> result) {
            expect(result, isNotNull);
            expect(result["foo"], equals("bar"));
          });
    });
  });
}
