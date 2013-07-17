// TODO Figure out how we want to run extension API tests.
part of harness_extension;

class TestTabs {
  void main() {
    group('chrome.tabs', () {
      test('getCurrent', () {
        tabs.getCurrent().then(expectAsync1((Tab tab) {
          expect(tab.status is TabStatus, isTrue);
          tab.release();
        }));
      });

      test('query', () {
        tabs.query().then(expectAsync1((List<Tab> tabs) {
          expect(tabs.first.status is TabStatus, isTrue);
          tabs.map((tab) => tab.release());
        }));
      });
    });
  }
}