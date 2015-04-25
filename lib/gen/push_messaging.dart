/* This file has been generated from push_messaging.idl - do not edit */

/**
 * The `chrome.pushMessaging` API is deprecated since Chrome 38, and will no
 * longer be supported in Chrome 41. Switch to `$(ref:gcm chrome.gcm)` to take
 * advantage of <a href="cloudMessaging.html">Google Cloud Messaging</a>.
 */
library chrome.pushMessaging;

import '../src/common.dart';

/**
 * Accessor for the `chrome.pushMessaging` namespace.
 */
final ChromePushMessaging pushMessaging = new ChromePushMessaging._();

class ChromePushMessaging extends ChromeApi {
  JsObject get _pushMessaging => chrome['pushMessaging'];

  Stream<Message> get onMessage => _onMessage.stream;
  ChromeStreamController<Message> _onMessage;

  ChromePushMessaging._() {
    var getApi = () => _pushMessaging;
    _onMessage = new ChromeStreamController<Message>.oneArg(getApi, 'onMessage', _createMessage);
  }

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

Message _createMessage(JsObject jsProxy) => jsProxy == null ? null : new Message.fromProxy(jsProxy);
ChannelIdResult _createChannelIdResult(JsObject jsProxy) => jsProxy == null ? null : new ChannelIdResult.fromProxy(jsProxy);
