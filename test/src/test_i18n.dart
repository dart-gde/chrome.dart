part of harness_browser;

class TestI18N {
  void main() {
    group('chrome.i18n', () {
      test('ui_locale', () {
        expect(i18n.ui_locale.length, greaterThan(1));
      });
      test('getMessage', () {
        expect(i18n.getMessage("app_name"), equals("chrome.dart - test"));
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
