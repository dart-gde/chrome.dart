library test_context_menus;

import 'package:unittest/unittest.dart';
import 'package:chrome/chrome_ext.dart' as chrome;

void main() {
  group('chrome.context_menus', () {
    String id = 'setupMenuItem';

    setUp(() {
      chrome.ContextMenusCreateParams createProperties =
          new chrome.ContextMenusCreateParams(id: id, title: 'setup menu item');
      return chrome.contextMenus.create(createProperties);
    });

    tearDown(() {
      return chrome.contextMenus.removeAll();
    });

    test('create -- defaults', () {
      chrome.ContextMenusCreateParams createProperties =
          new chrome.ContextMenusCreateParams(title: 'create -- defaults');

      int newId = chrome.contextMenus.create(createProperties);
      logMessage("newId => $newId");
      expect(newId, greaterThan(0));
    });

    test('create -- with listener', () {
      chrome.ContextMenusCreateParams createProperties =
          new chrome.ContextMenusCreateParams(title: 'create -- with listener');

      // TODO(DrMarcII): figure out a mechanism for selecting menu
      int newId = chrome.contextMenus.create(createProperties, (_) { });
      logMessage("newId => $newId");
      expect(newId, greaterThan(0));
    });

    test('create -- with many options specified', () {
      chrome.ContextMenusCreateParams createProperties =
          new chrome.ContextMenusCreateParams(type: "checkbox",
              id: 'testId',
              title: 'create -- with many options specified',
              checked: true,
              contexts: ["frame", "selection"],
              parentId: id,
              documentUrlPatterns: ['http://www.google.com/'],
              targetUrlPatterns: ['http://www.google.com/'],
              enabled: false

          );

      int newId = chrome.contextMenus.create(createProperties);
      logMessage("newId => $newId");
      expect(newId, equals("testId"));

    });

    test('update -- title', () {
      chrome.ContextMenusUpdateParams updateProperties =
          new chrome.ContextMenusUpdateParams(title: 'update -- title');

      chrome.contextMenus.update(id, updateProperties)
        .then(expectAsync((value) {
          expect(value, isNull);
        }));
    });

    test('update -- listener', () {
      chrome.ContextMenusUpdateParams updateProperties =
          new chrome.ContextMenusUpdateParams(onclick: (_) { });

      // TODO(DrMarcII): figure out a mechanism for selecting menu
      chrome.contextMenus.update(id, updateProperties)
        .then(expectAsync((_) {
          expect(_, isNull);
        }));
    });

    test('update -- with many options specified', () {
      chrome.ContextMenusCreateParams createProperties =
          new chrome.ContextMenusCreateParams(id: 'testId',
              title: 'update -- with many options specified');

      chrome.ContextMenusUpdateParams updateProperties =
          new chrome.ContextMenusUpdateParams(type: "checkbox",
              checked: true,
              contexts: ["frame", "selection"],
              parentId: id,
              documentUrlPatterns: ['http://www.google.com/'],
              targetUrlPatterns: ['http://www.google.com/'],
              enabled: false);

      var newId = chrome.contextMenus.create(createProperties);
      expect(newId, equals("testId"));

      chrome.contextMenus.update(newId, updateProperties).then(expectAsync((value) {
        expect(value, isNull);
      }));
    });

    test('update -- failure', () {
      chrome.ContextMenusUpdateParams updateProperties =
          new chrome.ContextMenusUpdateParams();

      chrome.contextMenus.update('not a real id', updateProperties)
        .catchError(expectAsync((_) { }));
    });

    test('remove -- successful', () {
      chrome.contextMenus.remove(id).then(expectAsync((_) { }));
    });

    test('remove -- failure', () {
      chrome.contextMenus.remove('not a real id').catchError(expectAsync((_) { }));
    });

    test('onClicked', () {
      // TODO(DrMarcII): figure out a mechanism for selecting menu
      chrome.contextMenus.onClicked.listen((_) { }).cancel();
    });
  });
}
