part of harness_extension;

class TestBrowserAction {
  void main() {
    group('chrome.browser_action', () {
      test('title -- global', () {
        String title = 'test title';
        browserAction.setTitle(title);
        browserAction.getTitle().then(expectAsync1((actual) {
          expect(actual, equals(title));
        }));
        String originalTitle = "chrome_ext.dart - test";
        browserAction.setTitle(originalTitle);
        browserAction.getTitle().then(expectAsync1((actual) {
          expect(actual, equals(originalTitle));
        }));
      });

      test('title -- tab', () {
        String title = 'test title';
        tabs.getCurrent().then(expectAsync1((tab) {
          browserAction.setTitle(title, tabId: tab.id);
          browserAction.getTitle(tabId: tab.id).then(expectAsync1((actual) {
            expect(actual, equals(title));
          }));
          String originalTitle = "chrome_ext.dart - test";
          browserAction.setTitle(originalTitle, tabId: tab.id);
          browserAction.getTitle(tabId: tab.id).then(expectAsync1((actual) {
            expect(actual, equals(originalTitle));
          }));
          tab.release();
        }));
      });

      test('badge text -- global', () {
        String badgeText = '9999';
        browserAction.setBadgeText(badgeText);
        browserAction.getBadgeText().then(expectAsync1((actual) {
          expect(actual, equals(badgeText));
        }));
        browserAction.setBadgeText('');
        browserAction.getBadgeText().then(expectAsync1((actual) {
          expect(actual, equals(''));
        }));
      });

      test('badge text -- tab', () {
        String badgeText = '9999';
        tabs.getCurrent().then(expectAsync1((tab) {
          browserAction.setBadgeText(badgeText, tabId: tab.id);
          browserAction.getBadgeText(tabId: tab.id).then(expectAsync1((actual) {
            expect(actual, equals(badgeText));
          }));
          browserAction.setBadgeText('', tabId: tab.id);
          browserAction.getBadgeText(tabId: tab.id).then(expectAsync1((actual) {
            expect(actual, equals(''));
          }));
          tab.release();
        }));
      });

      test('badge background color -- global', () {
        Color badgeColor = new Color(192, 134, 76, 255);
        Color originalColor = new Color(0, 0, 0, 0);
        browserAction.setBadgeBackgroundColor(badgeColor);
        browserAction.getBadgeBackgroundColor().then(expectAsync1((actual) {
          expect(actual, equals(badgeColor));
        }));
        browserAction.setBadgeBackgroundColor(originalColor);
        browserAction.getBadgeBackgroundColor().then(expectAsync1((actual) {
          expect(actual, equals(originalColor));
        }));
      });

      test('badge background color -- tab', () {
        Color badgeColor = new Color(192, 134, 76, 255);
        Color originalColor = new Color(0, 0, 0, 0);
        tabs.getCurrent().then(expectAsync1((tab) {
          browserAction.setBadgeBackgroundColor(badgeColor, tabId: tab.id);
          browserAction.getBadgeBackgroundColor(tabId: tab.id)
              .then(expectAsync1((actual) {
                expect(actual, equals(badgeColor));
              }));
          browserAction.setBadgeBackgroundColor(originalColor, tabId: tab.id);
          browserAction.getBadgeBackgroundColor(tabId: tab.id)
              .then(expectAsync1((actual) {
                expect(actual, equals(originalColor));
              }));
          tab.release();
        }));
      });

      test('popup -- global', () {
        String popupFile = "sample.html";
        browserAction.setPopup(popupFile);
        browserAction.getPopup().then(expectAsync1((actual) {
          expect(actual, endsWith(popupFile)); // adds extension prefix
        }));
        browserAction.setPopup("");
        browserAction.getPopup().then(expectAsync1((actual) {
          expect(actual, equals(""));
        }));
      });

      test('popup -- tab', () {
        String popupFile = "sample.html";
        tabs.getCurrent().then(expectAsync1((tab) {
          browserAction.setPopup(popupFile, tabId: tab.id);
          browserAction.getPopup(tabId: tab.id).then(expectAsync1((actual) {
            expect(actual, endsWith(popupFile)); // adds extension prefix
          }));
          browserAction.setPopup("", tabId: tab.id);
          browserAction.getPopup(tabId: tab.id).then(expectAsync1((actual) {
            expect(actual, equals(""));
          }));
          tab.release();
        }));
      });

      test('disable/enable -- global', () {
        browserAction.disable();
        browserAction.enable();
        // TODO(DrMarcII): need to figure out a way to check if this is working.
      });

      test('disable/enable -- tab', () {
        tabs.getCurrent().then(expectAsync1((Tab tab) {
          browserAction.disable(tabId: tab.id);
          browserAction.enable(tabId: tab.id);
          tab.release();
        }));
        // TODO(DrMarcII): need to figure out a way to check if this is working.
      });

      test('onClicked', () {
        browserAction.onClicked.listen((_) { }).cancel();
        // TODO(DrMarcII): need to figure out a way to fire this event.
      });
    });
  }
}