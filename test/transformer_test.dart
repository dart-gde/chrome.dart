
library transformer_test;

import 'package:test/test.dart';

import 'package:chrome/transformer.dart';

ChromeTransformer transformer = new ChromeTransformer.asPlugin();

defineTests() {
  group('transformer', () {

    test('invalid html', () {
      expect(
          transformer.rewriteContent("foo bar"),
          "foo bar");
    });

    test('test1', () {
      _check(
          '<script src="demo.dart" type="application/dart"></script>',
          '<script src="demo.dart.js"></script>');
    });

    test('test2', () {
      _check(
          "<script src='demo.dart' type='application/dart'></script>",
          '<script src="demo.dart.js"></script>');
    });

    test('test3', () {
      _check(
          '<script type="application/dart" src="demo.dart"></script>',
          '<script src="demo.dart.js"></script>');
    });

    test('test4', () {
      _check(
          "<script type='application/dart' src='demo.dart'></script>",
          '<script src="demo.dart.js"></script>');
    });
  });
}

void _check(String input, String expected) {
  expect(transformer.rewriteContent(input), expected);
}
