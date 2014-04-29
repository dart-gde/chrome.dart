// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library dartdoc_viewer.transformer;

import 'dart:async';
import 'package:barback/barback.dart';
import 'package:yaml/yaml.dart' as yaml;

/**
 * If web/config.yaml exists in the root of the project and it contains a
 * `siteVerification` value, a corresponding Google Web Master verification
 * page is created in the output web directory.
 */
class GoogleWebmasterVerifier extends Transformer {

  GoogleWebmasterVerifier.asPlugin();

  Future<bool> isPrimary(assetOrId) {
    var id = assetOrId is Asset ? assetOrId.id : assetOrId;
    var contains = id.path.startsWith('asset/config.yaml');
    return new Future.value(contains);
  }

  Future apply(Transform transform) {

    if (transform.primaryInput.id.path != _CONFIG_PATH) {
      return new Future.value();
    }

    return transform.primaryInput.readAsString()
        .then((configContent) {
      var config = new _Config.fromContent(configContent);

      if (config == null) return null;
      if (config.siteVerification == null) return null;

      var code = config.siteVerification;

      var verificationId = new AssetId(_PACKAGE_NAME, 'web/$code.html');

      var verificationContent = 'google-site-verification: $code.html';

      var verificationAsset =
          new Asset.fromString(verificationId, verificationContent);
      transform.addOutput(verificationAsset);
    });
  }
}

/**
 * This transformer only transforms web/index.html from this project.
 *
 * If web/config.yaml exists in the root of the project it is loaded.
 *
 * If the values are valid, they are used to populate the analytics section of
 * index.html
 */
class AnalyticsTransformer extends Transformer {

  AnalyticsTransformer.asPlugin();

  Future<bool> isPrimary(assetOrId) {
    var id = assetOrId is Asset ? assetOrId.id : assetOrId;
    return new Future.value(id.path == _INDEX_FILE_PATH);
  }

  Future apply(Transform transform) {
    var configAssetId = new AssetId(_PACKAGE_NAME, _CONFIG_PATH);

    return transform.getInput(configAssetId)
        .catchError((error, stack) => null)
        .then((configAsset) {
      if (configAsset == null) return null;
      return configAsset.readAsString();
    }).then((configContent) {
      _Config config = null;

      if(configContent != null) {
        config = new _Config.fromContent(configContent);
      }

      if (config == null) {
        transform.logger.warning('No config used.');
        transform.addOutput(transform.primaryInput);
        return null;
      }

      return transform.primaryInput.readAsString().then((String value) {
        _populateAnalytics(value, config, transform);
      });
    });
  }

  void _populateAnalytics(String value, _Config config, Transform transform) {
    var id = transform.primaryInput.id;

    if (value.contains(_ANALYTICS_PLACE_HOLDER) &&
        config.trackingCode != null) {

      var analytics = _ANALYTICS_CODE
          .replaceFirst(_TRACKING_CODE_PLACE_HOLDER, config.trackingCode)
          .replaceFirst(_DOMAIN_PLACE_HOLDER, config.trackingDomain);

      value = value.replaceFirst(_ANALYTICS_PLACE_HOLDER, analytics);
    } else {
      transform.logger.warning('Did not contain the analytics place holder: '
          '$_ANALYTICS_PLACE_HOLDER');
    }

    var asset = new Asset.fromString(id, value);
    transform.addOutput(asset);
  }

}

class _Config {
  final String trackingCode;
  final String trackingDomain;
  final String siteVerification;

  factory _Config.fromContent(String content) {
    var values = yaml.loadYaml(content);
    if (values == null) return null;

    return new _Config(values['trackingCode'], values['trackingDomain'],
        values['siteVerification']);
  }

  _Config(this.trackingCode, this.trackingDomain, this.siteVerification) {

    if ((trackingCode == null) != (trackingDomain == null)) {
      throw new ArgumentError(
          'Both trackingCode and trackingDomain must be set.');
    }
  }
}

const _CONFIG_PATH = 'asset/config.yaml';
const _PACKAGE_NAME = 'dartdoc_viewer';
const _INDEX_FILE_PATH = 'web/index.html';
const _ANALYTICS_PLACE_HOLDER = '<!-- Google Analytics -->';

const _TRACKING_CODE_PLACE_HOLDER = '{TRACKING_CODE}';
const _DOMAIN_PLACE_HOLDER = '{DOMAIN}';

const _ANALYTICS_CODE = '''<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', '{TRACKING_CODE}', '{DOMAIN}');
  ga('send', 'pageview');

</script>''';
