
library chrome.push_messaging;

import 'dart:async';

import 'package:js/js.dart' as js;

import 'common.dart';

final ChromePushMessaging pushMessaging = new ChromePushMessaging();

// chrome.pushMessaging

/**
 * Use chrome.pushMessaging to send message data to app or extension users.
 */
class ChromePushMessaging {
  StreamController<PushMessage> _streamController = new StreamController<PushMessage>();
  Stream<PushMessage> _stream;

  /**
   * Retrieves the channel ID associated with this app or extension. Typically
   * an app or extension will want to send this value to its application server
   * so the server can use it to trigger push messages back to the app or
   * extension. If the interactive flag is set, we will ask the user to log in
   * when they are not already logged in.
   *
   * Returns the channel ID for this app to use for push messaging.
   */
  Future<String> getChannelId(bool interactive) {
    ChromeCompleter completer = new ChromeCompleter.oneArg();

    js.scoped(() {
      chromeProxy.pushMessaging.getChannelId(interactive, completer.callback);
    });

    return completer.future;
  }

  /**
   * Fired when a push message has been received.
   */
  Stream<PushMessage> get onMessage {
    if (_stream == null) {
      _stream = _streamController.stream.asBroadcastStream();

      js.scoped(() {
        js.Callback callback = new js.Callback.many((var message) {
          _streamController.add(
              // TODO: test that this correctly pulls the params out of the JS
              // object.
              new PushMessage(message['subchannelId'], message['payload']));
        });

        chromeProxy.pushMessaging.onMessage.addListener(callback);
      });
    }

    return _stream;
  }
}

/**
 * The details associated with the message.
 */
class PushMessage {
  /**
   * The subchannel the message was sent on; only values 0-3 are valid.
   */
  int subchannelId;

  /**
   * The payload associated with the message, if any.
   */
  String payload;

  PushMessage(this.subchannelId, this.payload);

  String toString() => "subchannelId: ${subchannelId}, payload: ${payload}";
}
