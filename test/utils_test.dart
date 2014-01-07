
library utils_test;

import 'package:unittest/unittest.dart';

import '../tool/src/utils.dart';

main() {
  group('utility.dart', () {
    test('toCamelCase', () {
      expect(toCamelCase('foo.bar'), 'fooBar');
    });

    test('fromCamelCase', () {
      expect(fromCamelCase('fooBar'), 'foo_bar');
    });

    test('titleCase', () {
      expect(titleCase('foo'), 'Foo');
    });

    test('convertHtmlToDartdoc', () {
      expect(
          convertHtmlToDartdoc("Use the <code>chrome.contextMenus</code> API to <em>add</em> items to <a href='index.html'>index html</a>"),
          "Use the `chrome.contextMenus` API to _add_ items to [index html](index.html)");
    });
  });
}
