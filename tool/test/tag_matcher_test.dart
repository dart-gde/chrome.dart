library tag_matcher_test;

import 'package:test/test.dart';

import '../src/tag_matcher.dart';

void main() => defineTests();

void defineTests() {
  group('TagMatcher', () {
    TagMatcher matcher;
    var testString = 'Some untagged <span>This is some text in a span </span>'
        '<a href="path/to/foo">foo link</a> <span>and back to span </span>';

    test('matches tag contents correctly', () {
      matcher = TagMatcher.spanMatcher;
      var allContents = matcher.allContents(testString);

      expect(allContents.length, 2);
      expect(allContents.first, 'This is some text in a span ');
      expect(allContents.last, 'and back to span ');
    });

    test('matches tag contents with attributes', () {
      matcher = TagMatcher.aMatcher;
      var allContents = matcher.allContents(testString);

      expect(allContents.length, 1);
      expect(allContents.first, 'foo link');
    });

    test('matches attributes, even when none are present, for all tags', () {
      matcher = TagMatcher.anyTag;
      var allAttributes = matcher.allAttributes(testString);

      expect(allAttributes.length, 3);
      // Neither span element has attributes.
      expect(allAttributes.first.isEmpty, true);
      expect(allAttributes.last.isEmpty, true);

      var attributes = allAttributes.elementAt(1);

      expect(attributes.length, 1);
      expect(attributes['href'], 'path/to/foo');
    });

    group('matching attributes', () {
      test('multiple tags have multiple attributes', () {
        var lotsOfAttributes = '<li color="blue"></li><li color="black"></li>'
            '<li size="big"    type="dog" color="red"></li>';
        matcher = TagMatcher.liMatcher;

        var allAttributes = matcher.allAttributes(lotsOfAttributes).toList();

        expect(allAttributes[0].length, 1);
        expect(allAttributes[0], containsPair('color', 'blue'));

        expect(allAttributes[1].length, 1);
        expect(allAttributes[1], containsPair('color', 'black'));

        var cliffordAttributes = allAttributes[2];
        expect(cliffordAttributes.length, 3);
        expect(cliffordAttributes, containsPair('size', 'big'));
        expect(cliffordAttributes, containsPair('type', 'dog'));
        expect(cliffordAttributes, containsPair('color', 'red'));
      });
    });
  });
}
