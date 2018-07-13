library simple_http_client;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// Encapsulates an [HttpClient] for accessing HTML at a given [URI].
class SimpleHttpClient {
  final HttpClient _client;

  SimpleHttpClient({HttpClient client})
      : this._client = client ?? new HttpClient();

  /// Download the HTML source of the page at the given [Uri].
  Future<String> getHtmlAtUri(Uri uri) async {
    HttpClientRequest request = await _client.getUrl(uri);
    request.close();
    HttpClientResponse response = await request.done;
    return await response.transform(utf8.decoder).join('');
  }
}