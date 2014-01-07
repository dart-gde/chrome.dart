/* This file has been generated from push_messaging.idl - do not edit */

/**
 * Use `chrome.pushMessaging` to enable apps and extensions to receive message
 * data sent through <a href="cloudMessaging.html">Google Cloud Messaging</a>.
 */
library chrome.pushMessaging;

import '../src/common.dart';

/**
 * Accessor for the `chrome.pushMessaging` namespace.
 */
final ChromePushMessaging pushMessaging = new ChromePushMessaging._();

class ChromePushMessaging extends ChromeApi {
  static final JsObject _pushMessaging = chrome['pushMessaging'];

  ChromePushMessaging._();

  bool get available => _pushMessaging != null;

  /**
   * Retrieves the channel ID associated with this app or extension. Typically
   * an app or extension will want to send this value to its application server
   * so the server can use it to trigger push messages back to the app or
   * extension. If the interactive flag is set, we will ask the user to log in
   * when they are not already logged in.
   */
  Future<ChannelIdResult> getChannelId([bool interactive]) {
    if (_pushMessaging == null) _throwNotAvailable();

    var completer = new ChromeCompleter<ChannelIdResult>.oneArg(_createChannelIdResult);
    _pushMessaging.callMethod('getChannelId', [interactive, completer.callback]);
    return completer.future;
  }

  Stream<Message> get onMessage => _onMessage.stream;

  final ChromeStreamController<Message> _onMessage =
      new ChromeStreamController<Message>.oneArg(_pushMessaging, 'onMessage', _createMessage);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.pushMessaging' is not available");
  }
}

class Message extends ChromeObject {
  Message({int subchannelId, String payload}) {
    if (subchannelId != null) this.subchannelId = subchannelId;
    if (payload != null) this.payload = payload;
  }
  Message.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get subchannelId => jsProxy['subchannelId'];
  set subchannelId(int value) => jsProxy['subchannelId'] = value;

  String get payload => jsProxy['payload'];
  set payload(String value) => jsProxy['payload'] = value;
}

class ChannelIdResult extends ChromeObject {
  ChannelIdResult({String channelId}) {
    if (channelId != null) this.channelId = channelId;
  }
  ChannelIdResult.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get channelId => jsProxy['channelId'];
  set channelId(String value) => jsProxy['channelId'] = value;
}

ChannelIdResult _createChannelIdResult(JsObject jsProxy) => jsProxy == null ? null : new ChannelIdResult.fromProxy(jsProxy);
Message _createMessage(JsObject jsProxy) => jsProxy == null ? null : new Message.fromProxy(jsProxy);
