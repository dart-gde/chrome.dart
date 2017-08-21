library simple_http_client_test;

import 'dart:async';
import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../src/simple_http_client.dart';

void main() => defineTests();

void defineTests() {
  group('SimpleHttpClient', () {
    SimpleHttpClient simpleClient;
    MockHttpClient mockClient;
    MockHttpClientRequest mockRequest;
    MockHttpClientResponse mockResponse;
    List<String> html;

    setUp(() {
      mockClient = new MockHttpClient();
      mockRequest = new MockHttpClientRequest();
      mockResponse = new MockHttpClientResponse();

      when(mockClient.getUrl(any)).thenReturn(mockRequest);
      when(mockRequest.done).thenReturn(new Future(() => mockResponse));
      when(mockResponse.transform(any)).thenAnswer((_) => html);

      simpleClient = new SimpleHttpClient(client: mockClient);
    });

    test('returns string', () async {
      var testString = 'this is some great testHtml';
      html = [testString];

      expect(await simpleClient.getHtmlAtUri(Uri.parse('example.com')),
          testString);
    });
  });
}

class MockHttpClient extends Mock implements HttpClient {
  noSuchMethod(Invocation msg) => super.noSuchMethod(msg);
}

class MockHttpClientRequest extends Mock implements HttpClientRequest {
  noSuchMethod(Invocation msg) => super.noSuchMethod(msg);
}

class MockHttpClientResponse extends Mock implements HttpClientResponse {
  noSuchMethod(Invocation msg) => super.noSuchMethod(msg);
}
