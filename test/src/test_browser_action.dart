part of harness_extension;

class TestBrowserAction {
  void main() {
    group('chrome.browser_action', () {
      test('title', () {
        String title = 'test title';
        browserAction.setTitle(title);
        browserAction.getTitle().then(expectAsync1((actual) {
          expect(actual, equals(title));
        }));
      });

      test('badge text', () {
        String badgeText = '9999';
        browserAction.setBadgeText(badgeText);
        browserAction.getBadgeText().then(expectAsync1((actual) {
          expect(actual, equals(badgeText));
        }));
      });

      test('badge background color', () {
        Color badgeColor = new Color(192, 134, 76, 0);
        browserAction.setBadgeBackgroundColor(badgeColor);
        browserAction.getBadgeBackgroundColor().then(expectAsync1((actual) {
          expect(actual, equals(badgeColor));
        }));
      });
    });
  }
}