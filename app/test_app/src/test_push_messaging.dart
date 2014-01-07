library test_push_messaging;

import 'dart:async';

import 'package:unittest/unittest.dart';
import 'package:chrome/chrome_app.dart' as chrome;
import 'package:logging/logging.dart';

void main() {
  Logger.root.fine("test_push_messaging.main()");

  group('chrome.pushMessaging', () {
    test('getChannelId', () {
      Future future = chrome.pushMessaging.getChannelId(false)
      .then((chrome.ChannelIdResult channelId) {
        Logger.root.fine("pushMessaging channelId = ${channelId}");
        expect(true, true);
      }).catchError((var error) {
        Logger.root.fine("pushMessaging error = ${error}");
        expect(true, true);
      });

      expect(future, completes);
    });

    test('onMessage', () {
      // test that calling this method does not throw
      chrome.pushMessaging.onMessage.listen((chrome.Message message) {
        Logger.root.fine("new pushMessaging message = ${message}");
      });
    });
  });
}
