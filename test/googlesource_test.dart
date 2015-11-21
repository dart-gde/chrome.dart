library googlesource_test;

import 'dart:async';
import 'dart:convert';

import 'package:test/test.dart';

import '../tool/src/googlesource.dart';
import '../tool/src/simple_http_client.dart';

void main() => defineTests();

void defineTests() {
  group('GoogleSourceFile', () {
    GoogleSourceFile file;

    void testHtmlConversion(List<String> lines) {
      file = new GoogleSourceFile(asHtml(lines), 'example.com');

      expect(file.fileContents, lines.join('\n'));
    }

    test('correctly parses simple raw html', () {
      testHtmlConversion(['just one line']);
    });

    test('correctly parses multiline raw html', () {
      testHtmlConversion(['multiple', 'small', 'lines']);
    });

    test('correctly parses multiline raw html with whitespace', () {
      testHtmlConversion(['if (true)', '  goto label;', '', '', 'label']);
    });

    test('unescapes files', () {
      var testEscapeString = 'this & that is <\"\'>';
      var escapedHtmlFile = '<table><tr><td></td><td><a name="1"></a><span>'
          '${HTML_ESCAPE.convert(testEscapeString)}</span></td></tr></table>';
      file = new GoogleSourceFile(escapedHtmlFile, 'www.example.com');

      expect(file.fileContents, testEscapeString);
    });
  });

  group('GoogleSourceCrawler', () {
    var baseUri = 'http://www.example.com/';
    FakeSimpleHttpClient client;
    GoogleSourceCrawler crawler;

    setUp(() {
      client = new FakeSimpleHttpClient();
      crawler = new GoogleSourceCrawler(baseUri, client: client);
    });

    test('returns correct files in single directory', () async {
      prepopulateHttpResponses(client, test1);

      var files = await crawler.findAllMatchingFiles('test').toList();

      expect(files.length, 3);
      expect(
          files.map((file) => file.url),
          allOf(contains('/test/a.idl'), contains('/test/b.idl'),
              contains('/test/c.idl')));
    });

    test('correctly follows the file tree', () async {
      prepopulateHttpResponses(client, test2);

      var files = await crawler.findAllMatchingFiles('test').toList();

      expect(files.single.url, '/test/foo/bar/baz/qux.idl');
    });

    test('rejects files with non-matching extensions', () async {
      prepopulateHttpResponses(client, test3);

      var files = await crawler.findAllMatchingFiles('test').toList();

      expect(files.length, 2);
      expect(
          files.map((file) => file.url),
          allOf(contains('/test/a.idl'), contains('/test/c.json')));
    });
  });
}

void prepopulateHttpResponses(
    FakeSimpleHttpClient fakeClient, List<String> responses) {
  fakeClient.reset();
  for (var response in responses) {
    fakeClient.addHtml(response);
  }
}

class FakeSimpleHttpClient implements SimpleHttpClient {
  List<String> _htmlOutputList;
  int _callCount;

  FakeSimpleHttpClient() {
    reset();
  }

  Future<String> getHtmlAtUri(_) {
    var html = '';
    if (_htmlOutputList.isNotEmpty) {
      html = _htmlOutputList[_callCount];
    }
    if (_callCount != _htmlOutputList.length - 1) {
      _callCount++;
    }
    return new Future.value(html);
  }

  void reset() {
    _htmlOutputList = [];
    _callCount = 0;
  }

  void addHtml(String html) {
    _htmlOutputList.add(html);
  }
}

var test1 = [
  '<ol>'
      '<li><a href="/test/a.idl">a.idl</a></li>'
      '<li><a href="/test/b.idl">b.idl</a></li>'
      '<li><a href="/test/c.idl">c.idl</a></li>'
      '</ol>',
  'a contents',
  'b contents',
  'c contents'
];

var test2 = [
  '<ol><li><a href="/test/foo/">foo</a></li></ol>',
  '<ol><li><a href="/test/foo/bar/">bar</a></li></ol>',
  '<ol><li><a href="/test/foo/bar/baz/">baz</a></li></ol>',
  '<ol><li><a href="/test/foo/bar/baz/qux.idl">qux.idl</a></li></ol>',
  'qux contents'
];

var test3 = [
  '<ol><li><a href="/test/a.idl">a.idl</a></li>'
      '<li><a href="/test/b.txt">b.txt</a></li>'
      '<li><a href="/test/c.json">c.json</a></li></ol>',
  'a contents',
  'b contents',
  'c contents'
];

String asHtml(List<String> lines) {
  var liHtml = lines
      .map((line) => '<tr><td></td><td><a></a><span>$line</span></td></tr>')
      .join();
  return '<table>$liHtml</table>';
}

var multilineFileHtml = '''<table>
  <tr>
    <td></td>
    <td><li><a name="1"></a><span>first line</span></li></td>
  </tr>
  <tr>
    <td></td>
    <td><li><a name="2"></a><span>  second line</span></li></td>
  </tr>
  <tr>
    <td></td>
    <td><li><a name="3"></a><span>just one line</span></li></td>
  </tr>
  <tr>
    <td></td>
    <td><li><a name="4"></a><span>just one line</span></li></td>
  </tr>
  <tr>
    <td></td>
    <td><li><a name="5"></a><span>just one line</span></li></td>
  </tr>
  <tr>
    <td></td>
    <td><li><a name="6"></a><span>just one line</span></li></td>
  </tr>
</table>''';
