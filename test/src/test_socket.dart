library test_socket;

import 'dart:html' as html;

import 'package:unittest/html_enhanced_config.dart';
import 'package:unittest/unittest.dart';
import 'package:logging/logging.dart';
import 'package:js/js.dart' as js;

import 'package:chrome/chrome.dart';
import 'package:chrome/src/socket.dart';

class TestSocket {
  void main() {

    group('chrome.socket', () {
      test('getNetworkList', () {

        Socket.getNetworkList().then(
            expectAsync1((networklist) {
              logMessage(networklist);
              expect(networklist is List, isTrue);
            }));


        expect(true, isTrue);

      });
    });
  }
}
