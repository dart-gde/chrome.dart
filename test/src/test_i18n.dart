part of harness_browser;

class TestI18N {
  void main() {
    group('chrome.i18n', () {
      test('ui_locale', () {
        print('locale = ${i18n.ui_locale}');
        expect(i18n.ui_locale, isNotNull);
      });
      test('getAcceptLanguages', () {
        Future future = i18n.getAcceptLanguages().then((List<String> languages) {
          expect(languages, isList);
          expect(languages.length, greaterThan(0));        
        });
        
        expect(future, completes);
      });
    });
  }
}
