library googlesource;

import 'dart:async';
import 'dart:convert';

import 'simple_http_client.dart';
import 'tag_matcher.dart';

/// A [GoogleSourceEntity] represents either a file or a directory in the file
/// system at chromium.googlesource.com. It knows its own [Uri] and the html
/// source for the page at that Uri.
abstract class GoogleSourceEntity {
  final String _rawHtml;
  final String _url;

  GoogleSourceEntity(this._rawHtml, this._url);
  String get url => _url;
  String get _lines;
}

/// A [GoogleSourceFile] is a [GoogleSourceEntity] that represents a file. As
/// such, it knows how to access its own contents.
class GoogleSourceFile extends GoogleSourceEntity {
  static const _encodedCharacters = const ['\'', '&', '<', '>', '\"'];
  static final encodings =
      new Map.fromIterable(_encodedCharacters, key: HTML_ESCAPE.convert);

  GoogleSourceFile(rawHtml, url) : super(rawHtml, url);

  /// Parse this file's raw html and return its contents.
  String get fileContents => _unescapeHtml(new TagMatcher('tr')
      .allContents(_lines)
      .map((tableRow) {
    var line = new TagMatcher('td').allContents(tableRow).toList()[1];
    var lineStripped = line.replaceFirst(TagMatcher.aMatcher, '');
    return TagMatcher.spanMatcher.allContents(lineStripped).join('');
  }).join('\n'));

  String _unescapeHtml(String escapedHtml) {
    encodings.forEach((encodedString, decodedString) {
      escapedHtml = escapedHtml.replaceAll(encodedString, decodedString);
    });
    return escapedHtml;
  }

  String get _lines => new TagMatcher('table').allContents(_rawHtml).single;
}

/// A [GoogleSourceDirectory] represents a directory and can access the [Uri]s
/// of its child [GoogleSourceEntity]s.
class GoogleSourceDirectory extends GoogleSourceEntity {
  GoogleSourceDirectory(rawHtml, url) : super(rawHtml, url);

  String get _lines => TagMatcher.olMatcher.allContents(_rawHtml).single;

  Iterable<String> get listUris => TagMatcher.aMatcher
      .allAttributes(_lines)
      .map((Map<String, String> attributes) => attributes['href']);
}

/// A crawler that can take a [Uri] to a [GoogleSourceEntity], then traverse the
/// directory (or file) that entity represents.
class GoogleSourceCrawler {
  static const matchingExtensions = const ['.idl', '.json'];

  final SimpleHttpClient _client;
  final String _baseUri;

  GoogleSourceCrawler(this._baseUri, {SimpleHttpClient client})
      : this._client = client ?? new SimpleHttpClient();

  /// Asynchronously traverses the google source file system, starting from the
  /// [GoogleSourceEntity] at [relativeUri], to find all [GoogleSourceFile]s
  /// with extensions matching [matchingExtensions].
  Stream<GoogleSourceFile> findAllMatchingFiles(String relativeUri) async* {
    var directory = new GoogleSourceDirectory(
        await _client.getHtmlAtUri(_absoluteUri(relativeUri)), relativeUri);
    for (var childUrl in directory.listUris) {
      if (childUrl.endsWith('/')) {
        yield* findAllMatchingFiles(childUrl);
      } else if (matchingExtensions.any((ext) => childUrl.endsWith(ext))) {
        yield new GoogleSourceFile(
            await _client.getHtmlAtUri(_absoluteUri(childUrl)), childUrl);
      }
    }
  }

  Uri _absoluteUri(String relativeUri) => Uri.parse('$_baseUri$relativeUri');
}