library chrome_transformer;

import 'dart:async';

import 'package:barback/barback.dart';

// TODO: this could also re-write all foo.dart.precompiled.js files to
// foo.dart.js files

/**
 * A Pub transformer to re-write html entry-point files to use the CSP safe
 * versions of dart2js' output.
 *
 * In order to use this transformer, add:
 *
 *     transformers:
 *     - chrome
 *
 * to your `pubspec.yaml` file.
 */
class ChromeTransformer extends Transformer {
  ChromeTransformer.asPlugin();

  Future<bool> isPrimary(Asset input) {
    return new Future.value(input.id.extension == '.html');
  }

  Future apply(Transform transform) {
    return transform.primaryInput.readAsString().then((String content) {
      var id = transform.primaryInput.id;
      String newContent = _rewriteContent(content);
      if (newContent != content) {
        transform.addOutput(new Asset.fromString(id, newContent));
      }
    });
  }

  /**
   * Change:
   *     <script src="demo.dart" type="application/dart"></script>
   * to:
   *     <script src="demo.dart.precompiled.js"></script>
   */
  String _rewriteContent(String content) {
    RegExp regex = new RegExp(
        r'''<script\s+src=["'](\w+\.dart)["']\s+type=["']application/dart["']>\s*</script>''');

    Iterable<Match> matches = regex.allMatches(content).toList().reversed;

    for (Match match in matches) {
      String newScript =
          '<script src="${match.group(1)}.precompiled.js"></script>';

      content = content.substring(0, match.start)
          + newScript + content.substring(match.end);
    }

    return content;
  }
}
