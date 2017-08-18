library omaha_test;

import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../src/omaha.dart';
import '../src/simple_http_client.dart';

void main() => defineTests();

void defineTests() {
  group('OmahaVersionExtractor', () {
    OmahaVersionExtractor extractor;
    MockSimpleHttpClient client;
    String html;

    setUp(() {
      client = new MockSimpleHttpClient();
      when(client.getHtmlAtUri(any)).thenAnswer((_) => new Future.value(html));
      extractor = new OmahaVersionExtractor(client: client);
    });

    test('correctly parses good, simple input', () async {
      var version = 'alpha';
      html = 'mac,stable,$version';

      expect(await extractor.stableVersion, version);
    });
  });
}

class MockSimpleHttpClient extends Mock implements SimpleHttpClient {
  noSuchMethod(Invocation msg) => super.noSuchMethod(msg);
}
