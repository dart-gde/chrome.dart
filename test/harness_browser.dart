library harness_browser;

import 'package:unittest/html_enhanced_config.dart';
import 'package:unittest/unittest.dart';

main() {
  groupSep = ' - ';
  useHtmlEnhancedConfiguration();

  group('dummy', () {
    test('hello, world!', () {
      expect(true, isTrue);
    });
  });
}
