library test_browser_action;

import 'package:unittest/unittest.dart';
import 'package:chrome/chrome_ext.dart' as chrome;

void main() {
  group('chrome.browser_action', () {
    test('title -- global', () {
      String title = 'test title';
      chrome.BrowserActionSetTitleParams details =
          new chrome.BrowserActionSetTitleParams(title: title);
      chrome.browserAction.setTitle(details);
      chrome.browserAction.getTitle(new chrome.BrowserActionGetTitleParams())
        .then(expectAsync((String actual) {
        expect(actual, equals(title));
      }));

      String originalTitle = "chrome_ext.dart - test";
      chrome.BrowserActionSetTitleParams originalTitleDetails =
          new chrome.BrowserActionSetTitleParams(title: originalTitle);
      chrome.browserAction.setTitle(originalTitleDetails);
      chrome.browserAction.getTitle(new chrome.BrowserActionGetTitleParams())
        .then(expectAsync((String actual) {
        expect(actual, equals(originalTitle));
      }));
    });

    test('title -- tab', () {
      String title = 'test title';
      chrome.tabs.getCurrent().then(expectAsync((chrome.Tab tab) {
        chrome.BrowserActionSetTitleParams details =
            new chrome.BrowserActionSetTitleParams(title: title, tabId: tab.id);

        chrome.browserAction.setTitle(details);
        chrome.BrowserActionGetTitleParams getTitleDetails =
            new chrome.BrowserActionGetTitleParams(tabId: tab.id);
        chrome.browserAction.getTitle(getTitleDetails).then(expectAsync((actual) {
          expect(actual, equals(title));
        }));
        String originalTitle = "chrome_ext.dart - test";
        chrome.BrowserActionSetTitleParams originalTitleDetails =
            new chrome.BrowserActionSetTitleParams(title: originalTitle, tabId: tab.id);
        chrome.browserAction.setTitle(originalTitleDetails);

        chrome.BrowserActionGetTitleParams getOriginalTitleDetails =
            new chrome.BrowserActionGetTitleParams(tabId: tab.id);
        chrome.browserAction.getTitle(getOriginalTitleDetails)
          .then(expectAsync((String actual) {
          expect(actual, equals(originalTitle));
        }));
      }));
    });

    test('badge text -- global', () {
      String badgeText = '9999';
      chrome.BrowserActionSetBadgeTextParams details =
          new chrome.BrowserActionSetBadgeTextParams(text: badgeText);
      chrome.browserAction.setBadgeText(details);

      chrome.BrowserActionGetBadgeTextParams getBadgedetails =
          new chrome.BrowserActionGetBadgeTextParams();
      chrome.browserAction.getBadgeText(getBadgedetails)
        .then(expectAsync((String actual) {
        expect(actual, equals(badgeText));
      }));

      chrome.BrowserActionSetBadgeTextParams clearBadgedetails =
          new chrome.BrowserActionSetBadgeTextParams(text: '');
      chrome.browserAction.setBadgeText(clearBadgedetails);
      chrome.browserAction.getBadgeText(getBadgedetails)
        .then(expectAsync((String actual) {
        expect(actual, equals(''));
      }));
    });

    test('badge text -- tab', () {
      String badgeText = '9999';
      chrome.tabs.getCurrent().then(expectAsync((chrome.Tab tab) {
        chrome.BrowserActionSetBadgeTextParams details =
            new chrome.BrowserActionSetBadgeTextParams(text: badgeText, tabId: tab.id);
        chrome.browserAction.setBadgeText(details);

        chrome.BrowserActionGetBadgeTextParams getBadgeDetails =
            new chrome.BrowserActionGetBadgeTextParams(tabId: tab.id);
        chrome.browserAction.getBadgeText(getBadgeDetails)
          .then(expectAsync((String actual) {
          expect(actual, equals(badgeText));
        }));

        chrome.BrowserActionSetBadgeTextParams clearBadgedetails =
            new chrome.BrowserActionSetBadgeTextParams(text: '', tabId: tab.id);
        chrome.browserAction.setBadgeText(clearBadgedetails);
        chrome.browserAction.getBadgeText(getBadgeDetails)
          .then(expectAsync((String actual) {
          expect(actual, equals(''));
        }));
      }));
    });

    test('badge background color -- global', () {
      chrome.BrowserActionSetBadgeBackgroundColorParams badgeColor =
          new chrome.BrowserActionSetBadgeBackgroundColorParams(color: [192, 134, 76, 255]);
      chrome.BrowserActionSetBadgeBackgroundColorParams originalColor =
          new chrome.BrowserActionSetBadgeBackgroundColorParams(color: [0, 0, 0, 0]);

      chrome.browserAction.setBadgeBackgroundColor(badgeColor);
      chrome.browserAction.getBadgeBackgroundColor(new chrome.BrowserActionGetBadgeBackgroundColorParams())
        .then(expectAsync((chrome.ColorArray actual) {
          expect(actual.toJs()[0], equals(badgeColor.color[0]));
          expect(actual.toJs()[1], equals(badgeColor.color[1]));
          expect(actual.toJs()[2], equals(badgeColor.color[2]));
          expect(actual.toJs()[3], equals(badgeColor.color[3]));
      }));

      chrome.browserAction.setBadgeBackgroundColor(originalColor);
      chrome.browserAction.getBadgeBackgroundColor(new chrome.BrowserActionGetBadgeBackgroundColorParams())
        .then(expectAsync((chrome.ColorArray actual) {
          expect(actual.toJs()[0], equals(originalColor.color[0]));
          expect(actual.toJs()[1], equals(originalColor.color[1]));
          expect(actual.toJs()[2], equals(originalColor.color[2]));
          expect(actual.toJs()[3], equals(originalColor.color[3]));
      }));
    });

    test('badge background color -- tab', () {
      chrome.tabs.getCurrent().then(expectAsync((chrome.Tab tab) {
        chrome.BrowserActionSetBadgeBackgroundColorParams badgeColor =
            new chrome.BrowserActionSetBadgeBackgroundColorParams(color: [192, 134, 76, 255],  tabId: tab.id);
        chrome.BrowserActionSetBadgeBackgroundColorParams originalColor =
            new chrome.BrowserActionSetBadgeBackgroundColorParams(color: [0, 0, 0, 0],  tabId: tab.id);

        chrome.browserAction.setBadgeBackgroundColor(badgeColor);
        chrome.browserAction.getBadgeBackgroundColor(new chrome.BrowserActionGetBadgeBackgroundColorParams(tabId: tab.id))
          .then(expectAsync((chrome.ColorArray actual) {
            expect(actual.toJs()[0], equals(badgeColor.color[0]));
            expect(actual.toJs()[1], equals(badgeColor.color[1]));
            expect(actual.toJs()[2], equals(badgeColor.color[2]));
            expect(actual.toJs()[3], equals(badgeColor.color[3]));
          }));
        chrome.browserAction.setBadgeBackgroundColor(originalColor);
        chrome.browserAction.getBadgeBackgroundColor(new chrome.BrowserActionGetBadgeBackgroundColorParams(tabId: tab.id))
          .then(expectAsync((chrome.ColorArray actual) {
            expect(actual.toJs()[0], equals(originalColor.color[0]));
            expect(actual.toJs()[1], equals(originalColor.color[1]));
            expect(actual.toJs()[2], equals(originalColor.color[2]));
            expect(actual.toJs()[3], equals(originalColor.color[3]));
          }));
      }));
    });

    test('popup -- global', () {
      String popupFile = "sample.html";
      chrome.BrowserActionSetPopupParams popupParams =
          new chrome.BrowserActionSetPopupParams(popup: popupFile);
      chrome.browserAction.setPopup(popupParams);
      chrome.BrowserActionGetPopupParams getPopupParams =
          new chrome.BrowserActionGetPopupParams();
      chrome.browserAction.getPopup(getPopupParams)
        .then(expectAsync((String actual) {
        expect(actual, endsWith(popupFile)); // adds extension prefix
      }));

      chrome.BrowserActionSetPopupParams clearPopupParams =
          new chrome.BrowserActionSetPopupParams(popup: "");
      chrome.browserAction.setPopup(clearPopupParams);
      chrome.browserAction.getPopup(getPopupParams)
        .then(expectAsync((String actual) {
        expect(actual, equals(""));
      }));
    });

    test('popup -- tab', () {
      String popupFile = "sample.html";
      chrome.tabs.getCurrent().then(expectAsync((chrome.Tab tab) {
        chrome.BrowserActionSetPopupParams popupParams =
            new chrome.BrowserActionSetPopupParams(popup: popupFile, tabId: tab.id);

        chrome.BrowserActionSetPopupParams clearPopupParams =
            new chrome.BrowserActionSetPopupParams(popup: "", tabId: tab.id);

        chrome.BrowserActionGetPopupParams getPopupParams =
            new chrome.BrowserActionGetPopupParams(tabId: tab.id);

        chrome.browserAction.setPopup(popupParams);
        chrome.browserAction.getPopup(getPopupParams)
          .then(expectAsync((String actual) {
          expect(actual, endsWith(popupFile)); // adds extension prefix
        }));
        chrome.browserAction.setPopup(clearPopupParams);
        chrome.browserAction.getPopup(getPopupParams).then(expectAsync((actual) {
          expect(actual, equals(""));
        }));
      }));
    });

    test('disable/enable -- global', () {
      chrome.browserAction.disable();
      chrome.browserAction.enable();
      // TODO(DrMarcII): need to figure out a way to check if this is working.
    });

    test('disable/enable -- tab', () {
      chrome.tabs.getCurrent().then(expectAsync((chrome.Tab tab) {
        chrome.browserAction.disable(tab.id);
        chrome.browserAction.enable(tab.id);
      }));
      // TODO(DrMarcII): need to figure out a way to check if this is working.
    });

    test('onClicked', () {
      chrome.browserAction.onClicked.listen((_) { }).cancel();
      // TODO(DrMarcII): need to figure out a way to fire this event.
    });
  });
}
