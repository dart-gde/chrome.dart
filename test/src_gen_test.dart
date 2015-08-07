
library src_gen_test;

import 'package:unittest/unittest.dart';

import '../tool/src/src_gen.dart';

main() {
  group('generate_dart', () {
    DartGenerator generator;

    setUp(() {
      generator = new DartGenerator();
    });

    test('wrap', () {
      expect(wrap('foo\nbarbar baz'), 'foo\nbarbar baz');
      expect(wrap('foo\nbarbar baz', 4), 'foo\nbarbar\nbaz');
    });

    test('generate.indent', () {
      generator.writeln("class {");
      generator.writeln("foo.bar();");
      generator.writeln("}");

      expect(generator.toString(), "class {\n  foo.bar();\n}\n");
    });

    test('generate.docs', () {
      generator.writeDocs("My foo bar.");
      generator.writeln("class {}");
      generator.writeln("bar();");

      expect(generator.toString(), "/**\n * My foo bar.\n */\nclass {}\nbar();\n");
    });

    test('generate.docs.singleLine', () {
      generator.writeDocs("My foo bar.", preferSingle: true);
      generator.writeln("class {}");
      generator.writeln("bar();");

      expect(generator.toString(), "/// My foo bar.\nclass {}\nbar();\n");
    });

    test('generate.writeStatement1', () {
      generator.writeStatement("corn.muffins();");

      expect(generator.toString(), "corn.muffins();\n");
    });

    test('generate.writeStatement2', () {
      generator = new DartGenerator(colBoundary: 40);
      generator.writeStatement("corn.muffins(param1, param2, param3, param4);");

      expect(generator.toString(), "corn.muffins(\n    param1, param2, param3, param4);\n");
    });
  });
}
