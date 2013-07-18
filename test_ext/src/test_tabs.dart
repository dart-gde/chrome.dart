// TODO Figure out how we want to run extension API tests.
part of harness_extension;

class TestTabs {
  void main() {
    group('chrome.tabs', () {
      Window window;

      setUp(() {
        return windows.create(focused: true, type: WindowType.NORMAL)
            .then((_window) => window = _window);
      });

      tearDown(() {
        Future closeFuture = windows.remove(window.id);
        window.release();
        window = null;
        return closeFuture;
      });

      test('tab getters', () {
        Tab tab = window.tabs.first;
        expect(tab.id, isPositive);
        expect(tab.index, 0);
        expect(tab.windowId, window.id);
        expect(tab.highlighted, isTrue);
        expect(tab.active, isTrue);
        expect(tab.pinned, isFalse);
        expect(tab.url, 'chrome://newtab/');
        expect(tab.title, 'New Tab');
        expect(tab.favIconUrl, isNull);
        expect(tab.status, new isInstanceOf<TabStatus>());
        expect(tab.incognito, isFalse);
        expect(tab.openerTabId, isNull);
      });

      test('get', () {
        tabs.get(window.tabs.first.id).then(expectAsync1((Tab tab) {
          expect(tab.id, window.tabs.first.id);
          tab.release();
        }));
      });

      test('getCurrent', () {
        tabs.getCurrent().then(expectAsync1((Tab tab) {
          expect(tab.url, endsWith('harness_extension.html'));
          tab.release();
        }));
      });

      test('create -- default options', () {
        tabs.create(windowId: window.id)
            .then(expectAsync1((tab) {
              expect(tab.id, isPositive);
              expect(tab.index, 1);
              expect(tab.url, 'chrome://newtab/');
              expect(tab.active, isTrue);
              expect(tab.pinned, isFalse);
              expect(tab.openerTabId, isNull);
              tab.release();
            }));
      });

      test('create -- non-default options', () {
        tabs.create(
            windowId: window.id,
            index: 0,
            url: 'http://www.google.com/',
            active: false,
            pinned: true,
            openerTabId: window.tabs.first.id).then(expectAsync1((Tab tab) {
              expect(tab.id, isPositive);
              expect(tab.index, 0);
              expect(tab.url, 'http://www.google.com/');
              expect(tab.active, isFalse);
              expect(tab.pinned, isTrue);
              expect(tab.openerTabId, window.tabs.first.id);
              tab.release();
            }));
      });

      test('duplicate', () {
        Tab original = window.tabs.first;
        tabs.duplicate(original.id).then(expectAsync1((Tab tab) {
          expect(tab.id, isPositive);
          expect(tab.index, 1);
          expect(tab.pinned, original.pinned);
          expect(tab.windowId, original.windowId);
          tab.release();
        }));
      });

      test('query -- one tab', () {
        tabs.query(windowId: window.id).then(expectAsync1((List<Tab> foundTabs) {
          expect(foundTabs, hasLength(1));
          expect(foundTabs.first.id, window.tabs.first.id);
          foundTabs.first.release;
        }));
      });

      test('query -- two tabs', () {
        Tab newTab;
        tabs.create(windowId: window.id)
            .then((_tab) => newTab = _tab)
            .then((_) => tabs.query(windowId: window.id))
            .then(expectAsync1((List<Tab> foundTabs) {
              expect(foundTabs, hasLength(2));
              expect(foundTabs[0].id, anyOf(window.tabs.first.id, newTab.id));
              expect(foundTabs[1].id, anyOf(window.tabs.first.id, newTab.id));
              foundTabs.map((tab) => tab.release());
              newTab.release();
            }));
      });

      test('highlight', () {
        tabs.highlight([window.tabs.first.index], windowId: window.id)
          .then(expectAsync1((Window newWindow) {
            expect(newWindow.id, window.id);
            expect(newWindow.tabs.first.highlighted, isTrue);
            newWindow.release();
          }));
      });

      test('update', () {
        tabs.update(
            tabId: window.tabs.first.id,
            url: 'http://www.google.com/',
            active: true,
            highlighted: true,
            pinned: true).then(expectAsync1((Tab tab) {
              expect(tab.url, 'http://www.google.com/');
              expect(tab.active, isTrue);
              expect(tab.highlighted, isTrue);
              expect(tab.pinned, isTrue);
              tab.release();
            }));
      });

      test('move 1 tab', () {
        Tab newTab;
        tabs.create(windowId: window.id, index: 0)
            .then((_tab) => newTab = _tab)
            .then((_) => tabs.move([newTab.id], -1))
            .then(expectAsync1((List<Tab> movedTabs) {
              expect(movedTabs, hasLength(1));
              expect(movedTabs.first.id, newTab.id);
              expect(movedTabs.first.index, 1);
              movedTabs.first.release();
              newTab.release();
            }));
      });

      test('move 2 tabs', () {
        Tab newTab1;
        Tab newTab2;
        tabs.create(windowId: window.id, index: 0)
            .then((_tab) => newTab1 = _tab)
            .then((_) => tabs.create(windowId: window.id, index: 1))
            .then((_tab) => newTab2 = _tab)
            .then((_) => tabs.move([newTab1.id, newTab2.id], -1))
            .then(expectAsync1((List<Tab> movedTabs) {
              expect(movedTabs, hasLength(2));
              expect(movedTabs[0].id, anyOf(newTab1.id, newTab2.id));
              expect(movedTabs[1].id, anyOf(newTab1.id, newTab2.id));
              expect(movedTabs[0].index, anyOf(1, 2));
              expect(movedTabs[1].index, anyOf(1, 2));
              movedTabs[0].release();
              movedTabs[1].release();
              newTab1.release();
              newTab2.release();
            }));
      });

      test('reload', () {
        tabs.reload(tabId: window.tabs.first.id)
            .then(expectAsync1((_) { }));
      });

      test('remove 1 tab', () {
        tabs.create(windowId: window.id, index: 0)
            .then((Tab tab) => tabs.remove([tab.id]))
            .then((_) => tabs.query(windowId: window.id))
            .then(expectAsync1((List<Tab> currentTabs) {
              expect(currentTabs, hasLength(1));
            }));
      });

      test('remove 2 tabs', () {
        Tab newTab1;
        Tab newTab2;
        tabs.create(windowId: window.id, index: 0)
            .then((_tab) => newTab1 = _tab)
            .then((_) => tabs.create(windowId: window.id, index: 1))
            .then((_tab) => newTab2 = _tab)
            .then((_) => tabs.remove([newTab1.id, newTab2.id]))
            .then((_) => tabs.query(windowId: window.id))
            .then(expectAsync1((List<Tab> currentTabs) {
              expect(currentTabs, hasLength(1));
            }));
      });

      test('detectLanguage', () {
        tabs.detectLanguage(tabId: window.tabs.first.id)
            .then(expectAsync1((language) {
              expect(language, new isInstanceOf<String>());
            }));
      });

      test('onCreated', () {
        var subscription;
        subscription = tabs.onCreated.listen(expectAsync1((Tab tab) {
          expect(tab.windowId, window.id);
          tab.release();
          subscription.cancel();
        }));
        tabs.create(windowId: window.id).then(expectAsync1((_) { }));
      });

      test('onUpdated', () {
        var subscription;
        subscription = tabs.onUpdated.listen(expectAsync1((TabUpdatedEvent evt) {
          expect(evt.tab.windowId, window.id);
          expect(evt.status, anyOf(isNull, new isInstanceOf<TabStatus>()));
          expect(evt.url, 'http://www.google.com/');
          subscription.cancel();
        }));
        tabs.update(tabId: window.tabs.first.id, url: 'http://www.google.com/')
            .then(expectAsync1((_) { }));
      });

      test('onMoved', () {
        tabs.create(windowId: window.id, index: 0)
            .then((Tab tab) {
              var subscription;
              subscription = tabs.onMoved.listen(expectAsync1((TabMovedEvent evt) {
                expect(evt.type, 'moved');
                expect(evt.tabId, tab.id);
                expect(evt.windowId, window.id);
                expect(evt.fromIndex, 0);
                expect(evt.toIndex, 1);
                subscription.cancel();
              }));
              return tabs.move([tab.id], -1);
            })
            .then(expectAsync1((_) { }));
      });

      test('onActivated', () {
        tabs.create(windowId: window.id, index: 0, active: false)
            .then((Tab tab) {
              var subscription;
              subscription = tabs.onActivated
                  .listen(expectAsync1((TabActivatedEvent evt) {
                    expect(evt.tabId, tab.id);
                    expect(evt.windowId, window.id);
                    subscription.cancel();
                  }));
              return tabs.update(tabId: tab.id, active: true);
            })
            .then(expectAsync1((_) { }));
      });

      // TODO(DrMarcII): Figure out why highlighting tabs doesn't work
      test('onHighlighted', () {
        tabs.onHighlighted.listen((_) { }).cancel();
      });

      test('onDetached', () {
        tabs.create(windowId: window.id)
            .then((Tab tab) {
              var subscription;
              subscription = tabs.onDetached.listen(expectAsync1((TabMovedEvent evt) {
                expect(evt.type, 'detached');
                expect(evt.tabId, tab.id);
                expect(evt.windowId, window.id);
                expect(evt.fromIndex, 1);
                expect(evt.toIndex, isNull);
                subscription.cancel();
              }));
              return windows.create(tabId: tab.id);
            })
            .then((Window newWindow) =>
                windows.remove(newWindow.id))
            .then(expectAsync1((_) { }));
      });

      test('onAttached', () {
        tabs.create(windowId: window.id)
            .then((Tab tab) {
              var subscription;
              subscription = tabs.onAttached.listen(expectAsync1((TabMovedEvent evt) {
                expect(evt.type, 'attached');
                expect(evt.tabId, tab.id);
                expect(evt.windowId, isNot(window.id));
                expect(evt.fromIndex, isNull);
                expect(evt.toIndex, 0);
                subscription.cancel();
              }));
              return windows.create(tabId: tab.id);
            })
            .then((Window newWindow) =>
                windows.remove(newWindow.id))
            .then(expectAsync1((_) { }));
      });

      test('onRemoved', () {
        tabs.create(windowId: window.id)
            .then((Tab tab) {
              var subscription;
              subscription = tabs.onRemoved.listen(expectAsync1((TabRemovedEvent evt) {
                expect(evt.tabId, tab.id);
                expect(evt.windowId, window.id);
                expect(evt.isWindowClosing, isFalse);
                subscription.cancel();
              }));
              return tabs.remove([tab.id]);
            })
            .then(expectAsync1((_) { }));
      });

      // TODO(DrMarcII): Figure out how to force a tab replacement
      test('onReplaced', () {
        tabs.onReplaced.listen((_) { }).cancel();
      });
    });
  }
}