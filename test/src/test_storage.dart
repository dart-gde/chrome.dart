part of harness_browser;

class TestStorage {
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
        Future future = storage.local.set({"foo": "bar"}).then((StorageArea area) {
          area.get(["foo"]).then((Map<String, String> result) {
            expect(result["foo"], equals("bar"));
          });
        });
        
        expect(future, completes);
      });
    });
  }
}
