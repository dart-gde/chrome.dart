library test_devtools;

import 'package:chrome/src/devtools.dart' as chrome;
import 'package:unittest/unittest.dart';

void main() {
  group('chrome.devtools.inspectedWindow', () {
    test('tabId', () {
      expect(chrome.devtools.inspectedWindow.tabId, isPositive);
    });

    test('eval', () {
      expect(chrome.devtools.inspectedWindow.eval('4 + 37'), completion(41));
    });

    test('reload', () {
      // TODO(DrMarcII) figure out how to validate this
      chrome.devtools.inspectedWindow.reload();
      chrome.devtools.inspectedWindow.reload(ignoreCache: true, userAgent: '');
    });

    test('getResources', () =>
        chrome.devtools.inspectedWindow.getResources().then((resources) {
          expect(resources, isNot(isEmpty));
          expect(resources, everyElement(new isInstanceOf<chrome.Resource>()));
          expect(resources[0].url, isNot(isEmpty));
          var futureContent = resources[0].getContent();
          resources.forEach((resource) => resource.release());
          return futureContent;
        }).then((content) {
          expect(content, new isInstanceOf<chrome.ResourceContent>());
        }));

    test('onResourceAdded', () {
      // TODO(DrMarcII): figure out how to fire this event safely
      chrome.devtools.inspectedWindow.onResourceAdded
          .listen((_) { }).cancel();
    });

    test('onResourceContentCommitted', () {
      // TODO(DrMarcII): figure out how to fire this event safely
      chrome.devtools.inspectedWindow.onResourceContentCommitted
          .listen((_) { }).cancel();
    });
  });
}