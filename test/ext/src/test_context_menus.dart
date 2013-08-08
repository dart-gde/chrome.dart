part of harness_extension;

class TestContextMenus {
  void main() {
    group('chrome.context_menus', () {
      String id = 'setupMenuItem';

      setUp(() {
        return contextMenus.create(id: id, title: 'setup menu item');
      });

      tearDown(() {
        return contextMenus.removeAll();
      });

      test('create -- defaults', () {
        contextMenus.create(title: 'create -- defaults')
            .then(expectAsync1((value) {
              expect(value, isNull);
            }));
      });

      test('create -- with listener', () {
        // TODO(DrMarcII): figure out a mechanism for selecting menu
        contextMenus.create(title: 'create -- with listener', onClick: (_) { })
            .then(expectAsync1((subscription) {
              subscription.cancel();
            }));
      });

      test('create -- with many options specified', () {
        contextMenus.create(
            type: ContextMenuType.CHECKBOX,
            id: 'testId',
            title: 'create -- with many options specified',
            checked: true,
            contexts: [ContextMenuContext.FRAME, ContextMenuContext.SELECTION],
            parentId: id,
            documentUrlPatterns: ['http://www.google.com/'],
            targetUrlPatterns: ['http://www.google.com/'],
            enabled: false
            ).then(expectAsync1((value) {
              expect(value, isNull);
            }));
      });

      test('create -- failure', () {
        contextMenus.create().catchError(expectAsync1((_) { }));
      });

      test('update -- title', () {
        contextMenus.update(id, title: 'update -- title')
            .then(expectAsync1((value) {
              expect(value, isNull);
            }));
      });

      test('update -- listener', () {
        // TODO(DrMarcII): figure out a mechanism for selecting menu
        contextMenus.update(id, onClick: (_) { })
            .then(expectAsync1((subscription) {
              subscription.cancel();
            }));
      });

      test('update -- with many options specified', () {
        contextMenus.create(id: 'testId',
            title: 'update -- with many options specified'
            ).then((_) => contextMenus.update(
                'testId',
                type: ContextMenuType.CHECKBOX,
                checked: true,
                contexts: [ContextMenuContext.FRAME, ContextMenuContext.SELECTION],
                parentId: id,
                documentUrlPatterns: ['http://www.google.com/'],
                targetUrlPatterns: ['http://www.google.com/'],
                enabled: false)
            ).then(expectAsync1((value) {
              expect(value, isNull);
            }));
      });

      test('update -- failure', () {
        contextMenus.update('not a real id')
            .catchError(expectAsync1((_) { }));
      });

      test('remove -- successful', () {
        contextMenus.remove(id).then(expectAsync1((_) { }));
      });

      test('remove -- failure', () {
        contextMenus.remove('not a real id').catchError(expectAsync1((_) { }));
      });

      test('onClicked', () {
        // TODO(DrMarcII): figure out a mechanism for selecting menu
        contextMenus.onClicked.listen((_) { }).cancel();
      });
    });
  }
}