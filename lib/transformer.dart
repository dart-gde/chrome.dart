library chrome_transformer;

import 'dart:async';

import 'package:barback/barback.dart';

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
  final RegExp _regex1 = new RegExp(
      r'''<script\s+src=["'](\w+\.dart)["']\s+type=["']application/dart["']\s*>\s*</script>''');
  final RegExp _regex2 = new RegExp(
      r'''<script\s+type=["']application/dart["']\s+src=["'](\w+\.dart)["']\s*>\s*</script>''');

  ChromeTransformer.asPlugin();

  // TODO: Remove the [assetOrId] hack.
  Future<bool> isPrimary(assetOrId) {
    AssetId id = assetOrId is Asset ? assetOrId.id : assetOrId;
    return new Future.value(id.extension == '.html');
  }

  Future apply(Transform transform) {
    return transform.primaryInput.readAsString().then((String content) {
      var id = transform.primaryInput.id;
      String newContent = rewriteContent(content);
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
  String rewriteContent(String content) {
    Iterable<Match> matches = _regex1.allMatches(content).toList().reversed;

    for (Match match in matches) {
      String newScript ='<script src="${match.group(1)}.precompiled.js"></script>';
      content = content.substring(0, match.start)
          + newScript + content.substring(match.end);
    }

    matches = _regex2.allMatches(content).toList().reversed;

    for (Match match in matches) {
      String newScript ='<script src="${match.group(1)}.precompiled.js"></script>';
      content = content.substring(0, match.start)
          + newScript + content.substring(match.end);
    }

    return content;
  }
}
