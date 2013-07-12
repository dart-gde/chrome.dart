// TODO Figure out how we want to run extension API tests.
part of harness_extension;

class TestTabs {
  void main() {
    group('chrome.tabs', () {
      test('getCurrent', () {
        tabs.getCurrent().then(expectAsync1((Tab tab) {
          expect(tab.windowId, equals(windows.WINDOW_ID_CURRENT));
          expect(tab.status is TabStatus, isTrue);
        }));
      });

//      test('query', () {
//        tabs.query().then(expectAsync1((List<Tab> tab) {
//          expect(tab.first.status is TabStatus, isTrue);
//        }));
//      });
    });
  }
}