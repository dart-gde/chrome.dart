library omaha;

import 'dart:async';

import 'simple_http_client.dart';

/// This extractor parses the latest data at omahaproxy to determine the latest
/// stable version of chrome.
class OmahaVersionExtractor {
  static const _omahaDataUrl = 'https://omahaproxy.appspot.com/all?csv=1';
  static const _missingField = 'N/A';
  static const _stableRelease = 'stable';
  static const _stableOS = 'mac';

  final SimpleHttpClient _client;

  OmahaVersionExtractor({SimpleHttpClient client})
      : this._client = client ?? new SimpleHttpClient();

  Future<String> get stableVersion async {
    var omahaData = await _client.getHtmlAtUri(Uri.parse(_omahaDataUrl));
    var stableCommits = omahaData.split('\n')
      ..removeWhere((line) =>
          !line.contains(_stableRelease) || line.contains(_missingField));
    var stableCommitVersions = new Map.fromIterable(stableCommits,
        key: (line) => line.split(',')[0], value: (line) => line.split(',')[2]);
    return stableCommitVersions[_stableOS];
  }
}
