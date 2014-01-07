library test_i18n;

import 'dart:async';

import 'package:unittest/unittest.dart';
import 'package:chrome/chrome_app.dart' as chrome;

void main() {
  group('chrome.i18n', () {
    test('ui_locale', () {

      expect(chrome.i18n.getMessage("@@ui_locale").length, greaterThan(1));
    });
    test('getMessage', () {
      expect(chrome.i18n.getMessage("app_name"), equals("chrome.dart - test"));
    });
    test('not_found', () {
      expect(chrome.i18n.getMessage('not_found'), equals(''));
    });
    test('getAcceptLanguages', () {
      Future future = chrome.i18n.getAcceptLanguages().then((List<String> languages) {
        expect(languages, isList);
        expect(languages.length, greaterThan(0));
      });

      expect(future, completes);
    });
  });
}
