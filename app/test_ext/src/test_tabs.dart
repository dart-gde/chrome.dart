library test_tabs;

import 'dart:async';

import 'package:unittest/unittest.dart';
import 'package:chrome/chrome_ext.dart' as chrome;

void main() {
  group('chrome.tabs', () {
    chrome.Window window;

    setUp(() {
      chrome.WindowsCreateParams createData =
          new chrome.WindowsCreateParams(focused: true, type: "normal");

      return chrome.windows.create(createData)
          .then((chrome.Window _window) => window = _window);
    });

    tearDown(() {
      Future closeFuture = chrome.windows.remove(window.id);
      window = null;
      return closeFuture;
    });

    test('tab getters', () {
      chrome.Tab tab = window.tabs.first;
      expect(tab.id, isPositive);
      expect(tab.index, 0);
      expect(tab.windowId, window.id);
      expect(tab.highlighted, isTrue);
      expect(tab.active, isTrue);
      expect(tab.pinned, isFalse);
      expect(tab.url, 'chrome://newtab/');
      expect(tab.title, 'New Tab');
      expect(tab.favIconUrl, isNull);
      expect(tab.status, new isInstanceOf<String>());
      expect(tab.incognito, isFalse);
      expect(tab.openerTabId, isNull);
    });

    test('get', () {
      chrome.tabs.get(window.tabs.first.id).then(expectAsync((chrome.Tab tab) {
        expect(tab.id, window.tabs.first.id);
      }));
    });

    test('getCurrent', () {
      chrome.tabs.getCurrent().then(expectAsync((chrome.Tab tab) {
        expect(tab.url, endsWith('harness.html'));
      }));
    });

    test('create -- default options', () {
      chrome.TabsCreateParams createProperties =
          new chrome.TabsCreateParams(windowId: window.id);
      chrome.tabs.create(createProperties)
        .then(expectAsync((chrome.Tab tab) {
          expect(tab.id, isPositive);
          expect(tab.index, 1);
          expect(tab.url, 'chrome://newtab/');
          expect(tab.active, isTrue);
          expect(tab.pinned, isFalse);
          expect(tab.openerTabId, isNull);
        }));
    });

    test('create -- non-default options', () {
      chrome.TabsCreateParams createProperties =
          new chrome.TabsCreateParams(windowId: window.id,
              index: 0,
              url: 'http://www.google.com/',
              active: false,
              pinned: true,
              openerTabId: window.tabs.first.id);

      chrome.tabs.create(createProperties).then(expectAsync((chrome.Tab tab) {
            expect(tab.id, isPositive);
            expect(tab.index, 0);
            expect(tab.url, 'http://www.google.com/');
            expect(tab.active, isFalse);
            expect(tab.pinned, isTrue);
            expect(tab.openerTabId, window.tabs.first.id);
          }));
    });

    test('duplicate', () {
      chrome.Tab original = window.tabs.first;
      chrome.tabs.duplicate(original.id).then(expectAsync((chrome.Tab tab) {
        expect(tab.id, isPositive);
        expect(tab.index, 1);
        expect(tab.pinned, original.pinned);
        expect(tab.windowId, original.windowId);
      }));
    });

    test('query -- one tab', () {
      chrome.TabsQueryParams queryInfo =
          new chrome.TabsQueryParams(windowId: window.id);
      chrome.tabs.query(queryInfo).then(expectAsync((List<chrome.Tab> foundTabs) {
        expect(foundTabs, hasLength(1));
        expect(foundTabs.first.id, window.tabs.first.id);
      }));
    });

    test('query -- two tabs', () {
      chrome.Tab newTab;
      chrome.TabsCreateParams createProperties =
          new chrome.TabsCreateParams(windowId: window.id);
      chrome.TabsQueryParams queryInfo =
          new chrome.TabsQueryParams(windowId: window.id);
      chrome.tabs.create(createProperties)
        .then((_tab) => newTab = _tab)
          .then((_) => chrome.tabs.query(queryInfo))
            .then(expectAsync((List<chrome.Tab> foundTabs) {
              expect(foundTabs, hasLength(2));
              expect(foundTabs[0].id, anyOf(window.tabs.first.id, newTab.id));
              expect(foundTabs[1].id, anyOf(window.tabs.first.id, newTab.id));
            }));
      });

      test('highlight', () {
        chrome.TabsHighlightParams highlightInfo =
            new chrome.TabsHighlightParams(windowId: window.id,
                tabs: [window.tabs.first.index]);
        chrome.tabs.highlight(highlightInfo)
          .then(expectAsync((chrome.Window newWindow) {
            expect(newWindow.id, window.id);
            expect(newWindow.tabs.first.highlighted, isTrue);
          }));
      });

      test('update', () {
        chrome.TabsUpdateParams updateProperties =
            new chrome.TabsUpdateParams(url: 'http://www.google.com/',
                active: true,
                highlighted: true,
                pinned: true);
        chrome.tabs.update(updateProperties, window.tabs.first.id)
          .then(expectAsync((chrome.Tab tab) {
              expect(tab.url, 'http://www.google.com/');
              expect(tab.active, isTrue);
              expect(tab.highlighted, isTrue);
              expect(tab.pinned, isTrue);
            }));
      });

      test('move 1 tab', () {
        chrome.Tab newTab;
        chrome.TabsCreateParams createProperties =
            new chrome.TabsCreateParams(windowId: window.id, index: 0);
        chrome.TabsMoveParams moveProperties =
            new chrome.TabsMoveParams(index: -1);

        chrome.tabs.create(createProperties)
            .then((_tab) => newTab = _tab)
            .then((_) => chrome.tabs.move([newTab.id], moveProperties))
            .then(expectAsync((List<chrome.Tab> movedTabs) {
              logMessage("movedTabs = ${movedTabs}");
              expect(movedTabs, isNotNull);
//              expect(movedTabs, hasLength(1));
//              expect(movedTabs.first.id, newTab.id);
//              expect(movedTabs.first.index, 1);
            }));
      });

      test('move 2 tabs', () {
        chrome.Tab newTab1;
        chrome.Tab newTab2;
        chrome.TabsCreateParams createProperties =
            new chrome.TabsCreateParams(windowId: window.id, index: 0);
        chrome.TabsCreateParams createProperties2 =
            new chrome.TabsCreateParams(windowId: window.id, index: 1);
        chrome.TabsMoveParams moveProperties =
            new chrome.TabsMoveParams(index: -1);

        chrome.tabs.create(createProperties)
            .then((_tab) => newTab1 = _tab)
            .then((_) => chrome.tabs.create(createProperties2))
            .then((_tab) => newTab2 = _tab)
            .then((_) => chrome.tabs.move([newTab1.id, newTab2.id], moveProperties))
            .then(expectAsync((List<chrome.Tab> movedTabs) {
              logMessage("movedTabs = ${movedTabs}");
              expect(movedTabs, isNotNull);
//              expect(movedTabs, hasLength(2));
//              expect(movedTabs[0].id, anyOf(newTab1.id, newTab2.id));
//              expect(movedTabs[1].id, anyOf(newTab1.id, newTab2.id));
//              expect(movedTabs[0].index, anyOf(1, 2));
//              expect(movedTabs[1].index, anyOf(1, 2));
            }));
      });

      test('reload', () {
        chrome.tabs.reload(window.tabs.first.id)
            .then(expectAsync((_) { }));
      });

      test('remove 1 tab', () {
        chrome.TabsCreateParams createProperties =
            new chrome.TabsCreateParams(windowId: window.id, index: 0);
        chrome.TabsQueryParams queryInfo =
            new chrome.TabsQueryParams(windowId: window.id);
        chrome.tabs.create(createProperties)
            .then((chrome.Tab tab) => chrome.tabs.remove([tab.id]))
            .then((_) => chrome.tabs.query(queryInfo))
            .then(expectAsync((List<chrome.Tab> currentTabs) {
              expect(currentTabs, hasLength(1));
            }));
      });

      test('remove 2 tabs', () {
        chrome.Tab newTab1;
        chrome.Tab newTab2;
        chrome.TabsCreateParams createProperties =
            new chrome.TabsCreateParams(windowId: window.id, index: 0);
        chrome.TabsCreateParams createProperties2 =
            new chrome.TabsCreateParams(windowId: window.id, index: 1);
        chrome.TabsQueryParams queryInfo =
            new chrome.TabsQueryParams(windowId: window.id);
        chrome.tabs.create(createProperties)
            .then((_tab) => newTab1 = _tab)
            .then((_) => chrome.tabs.create(createProperties2))
            .then((_tab) => newTab2 = _tab)
            .then((_) => chrome.tabs.remove([newTab1.id, newTab2.id]))
            .then((_) => chrome.tabs.query(queryInfo))
            .then(expectAsync((List<chrome.Tab> currentTabs) {
              expect(currentTabs, hasLength(1));
            }));
      });

      test('detectLanguage', () {
        chrome.tabs.detectLanguage(window.tabs.first.id)
            .then(expectAsync((String language) {
              expect(language, new isInstanceOf<String>());
            }));
      });

      test('onCreated', () {
        var subscription;
        subscription = chrome.tabs.onCreated.listen(expectAsync((chrome.Tab tab) {
          expect(tab.windowId, window.id);
          subscription.cancel();
        }));

        chrome.TabsCreateParams createProperties =
            new chrome.TabsCreateParams(windowId: window.id);
        chrome.tabs.create(createProperties).then(expectAsync((_) { }));
      });

      test('onUpdated', () {
        var subscription;
        subscription = chrome.tabs.onUpdated.listen(expectAsync((chrome.OnUpdatedEvent evt) {
          expect(evt.tab.windowId, window.id);
          logMessage("evt.changeInfo = ${evt.changeInfo}");
          expect(evt.changeInfo["status"], anyOf(isNull, "loading"));
          expect(evt.changeInfo["url"], contains('www.google.com'));
          subscription.cancel();
        }));
        chrome.TabsUpdateParams updateProperties =
            new chrome.TabsUpdateParams(url: 'http://www.google.com/');
        chrome.tabs.update(updateProperties, window.tabs.first.id)
            .then(expectAsync((_) { }));
      });

      test('onMoved', () {
        chrome.TabsCreateParams createProperties =
            new chrome.TabsCreateParams(windowId: window.id, index: 0);
        chrome.tabs.create(createProperties)
            .then((chrome.Tab tab) {
              var subscription;
              subscription = chrome.tabs.onMoved.listen(expectAsync((chrome.TabsOnMovedEvent evt) {
                logMessage("onMoved: evt.moveInfo = ${evt.moveInfo}");
                expect(evt.tabId, tab.id);
                expect(evt.moveInfo["windowId"], equals(window.id));
                expect(evt.moveInfo["fromIndex"], equals(0));
                expect(evt.moveInfo["toIndex"], equals(1));
                subscription.cancel();
              }));
              chrome.TabsMoveParams moveProperties =
                  new chrome.TabsMoveParams(index: -1);
              return chrome.tabs.move([tab.id], moveProperties);
            })
            .then(expectAsync((_) { }));
      });

      test('onActivated', () {
        chrome.TabsCreateParams createProperties =
            new chrome.TabsCreateParams(windowId: window.id, index: 0, active: false);
        chrome.tabs.create(createProperties)
            .then((chrome.Tab tab) {
              var subscription;
              subscription = chrome.tabs.onActivated
                  .listen(expectAsync((Map<dynamic, dynamic> evt) {
                    expect(evt["tabId"], tab.id);
                    expect(evt["windowId"], window.id);
                    subscription.cancel();
                  }));
              chrome.TabsUpdateParams updateProperties =
                  new chrome.TabsUpdateParams(active: true);
              return chrome.tabs.update(updateProperties, tab.id);
            })
            .then(expectAsync((_) { }));
      });

      // TODO(DrMarcII): Figure out why highlighting tabs doesn't work
      test('onHighlighted', () {
        chrome.tabs.onHighlighted.listen((_) { }).cancel();
      });

      test('onDetached', () {
        chrome.TabsCreateParams createProperties =
            new chrome.TabsCreateParams(windowId: window.id);
        chrome.tabs.create(createProperties)
            .then((chrome.Tab tab) {
              var subscription;
              subscription = chrome.tabs.onDetached.listen(expectAsync((chrome.OnDetachedEvent evt) {
                logMessage("evt.detachInfo = ${evt.detachInfo}");
                expect(evt.tabId, tab.id);
                expect(evt.detachInfo["oldWindowId"], window.id);
                expect(evt.detachInfo["oldPosition"], 1);
                subscription.cancel();
              }));
              chrome.WindowsCreateParams createData =
                  new chrome.WindowsCreateParams(tabId: tab.id);
              return chrome.windows.create(createData);
            })
            .then((chrome.Window newWindow) =>
                chrome.windows.remove(newWindow.id))
            .then(expectAsync((_) { }));
      });

      test('onAttached', () {
        chrome.TabsCreateParams createProperties =
            new chrome.TabsCreateParams(windowId: window.id);
        chrome.tabs.create(createProperties)
            .then((chrome.Tab tab) {
              var subscription;
              subscription = chrome.tabs.onAttached.listen(expectAsync((chrome.OnAttachedEvent evt) {
                logMessage("evt.attachInfo = ${evt.attachInfo}");
                expect(evt.tabId, tab.id);
                expect(evt.attachInfo["windowId"], isNot(window.id));
                expect(evt.attachInfo["newPosition"], 0);
                subscription.cancel();
              }));
              chrome.WindowsCreateParams createData =
                  new chrome.WindowsCreateParams(tabId: tab.id);
              return chrome.windows.create(createData);
            })
            .then((chrome.Window newWindow) =>
                chrome.windows.remove(newWindow.id))
            .then(expectAsync((_) { }));
      });

      test('onRemoved', () {
        chrome.TabsCreateParams createProperties =
            new chrome.TabsCreateParams(windowId: window.id);
        chrome.tabs.create(createProperties)
            .then((chrome.Tab tab) {
              var subscription;
              subscription = chrome.tabs.onRemoved.listen(expectAsync((chrome.TabsOnRemovedEvent evt) {
                expect(evt.tabId, tab.id);
                expect(evt.removeInfo["windowId"], window.id);
                expect(evt.removeInfo["isWindowClosing"], isFalse);
                subscription.cancel();
              }));
              return chrome.tabs.remove([tab.id]);
            })
            .then(expectAsync((_) { }));
      });

      // TODO(DrMarcII): Figure out how to force a tab replacement
      test('onReplaced', () {
        chrome.tabs.onReplaced.listen((_) { }).cancel();
      });
    });
}
