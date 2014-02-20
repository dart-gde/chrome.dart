/* This file has been generated from gcm.json - do not edit */

/**
 * Use `chrome.gcm` to enable apps and extensions to send and receive messages
 * through [Google Cloud Messaging for
 * Android](http://developer.android.com/google/gcm/index.html).
 */
library chrome.gcm;

import '../src/common.dart';

/**
 * Accessor for the `chrome.gcm` namespace.
 */
final ChromeGcm gcm = new ChromeGcm._();

class ChromeGcm extends ChromeApi {
  static final JsObject _gcm = chrome['gcm'];

  ChromeGcm._();

  bool get available => _gcm != null;

  /**
   * The maximum size (in bytes) of all key/value pairs in a message.
   */
  int get MAX_MESSAGE_SIZE => _gcm['MAX_MESSAGE_SIZE'];

  /**
   * Registers the application with GCM. The registration ID will be returned by
   * the `callback`. If `register` is called again with the same list of
   * `senderIds`, the same registration ID will be returned.
   * 
   * [senderIds] A list of server IDs that are allowed to send messages to the
   * application. It should contain at least one and no more than 100 sender
   * IDs.
   * 
   * Returns:
   * A registration ID assigned to the application by the GCM.
   */
  Future<String> register(List<String> senderIds) {
    if (_gcm == null) _throwNotAvailable();

    var completer = new ChromeCompleter<String>.oneArg();
    _gcm.callMethod('register', [jsify(senderIds), completer.callback]);
    return completer.future;
  }

  /**
   * Sends a message according to its contents.
   * 
   * [message] A message to send to the other party via GCM.
   * 
   * Returns:
   * The ID of the message that the callback was issued for.
   */
  Future<String> send(GcmSendParams message) {
    if (_gcm == null) _throwNotAvailable();

    var completer = new ChromeCompleter<String>.oneArg();
    _gcm.callMethod('send', [jsify(message), completer.callback]);
    return completer.future;
  }

  /**
   * Fired when a message is received through GCM.
   */
  Stream<Map> get onMessage => _onMessage.stream;

  final ChromeStreamController<Map> _onMessage =
      new ChromeStreamController<Map>.oneArg(_gcm, 'onMessage', mapify);

  /**
   * Fired when a GCM server had to delete messages to the application from its
   * queue in order to manage its size. The app is expected to handle that case
   * gracefully, e.g. by running a full sync with its server.
   */
  Stream get onMessagesDeleted => _onMessagesDeleted.stream;

  final ChromeStreamController _onMessagesDeleted =
      new ChromeStreamController.noArgs(_gcm, 'onMessagesDeleted');

  /**
   * Fired when it was not possible to send a message to the GCM server.
   */
  Stream<Map> get onSendError => _onSendError.stream;

  final ChromeStreamController<Map> _onSendError =
      new ChromeStreamController<Map>.oneArg(_gcm, 'onSendError', mapify);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.gcm' is not available");
  }
}

class GcmSendParams extends ChromeObject {
  GcmSendParams({String destinationId, String messageId, int timeToLive, Map data}) {
    if (destinationId != null) this.destinationId = destinationId;
    if (messageId != null) this.messageId = messageId;
    if (timeToLive != null) this.timeToLive = timeToLive;
    if (data != null) this.data = data;
  }
  GcmSendParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The ID of the server to send the message to as assigned by [Google API
   * Console](https://code.google.com/apis/console).
   */
  String get destinationId => jsProxy['destinationId'];
  set destinationId(String value) => jsProxy['destinationId'] = value;

  /**
   * The ID of the message. It must be unique for each message.
   */
  String get messageId => jsProxy['messageId'];
  set messageId(String value) => jsProxy['messageId'] = value;

  /**
   * Time-to-live of the message in seconds. If it is not possible to send the
   * message wihtin that time an error will be raised. A time-to-live of 0
   * indicates that the message should be sent immediately or fail if it's not
   * possible. The maximum and a default value of time-to-live is 2419200
   * seconds (4 weeks).
   */
  int get timeToLive => jsProxy['timeToLive'];
  set timeToLive(int value) => jsProxy['timeToLive'] = value;

  /**
   * Message data to send to the server. `goog.` and `google` are disallowed as
   * key prefixes. Sum of all key/value pairs should not exceed
   * [MAX_MESSAGE_SIZE.]
   */
  Map get data => mapify(jsProxy['data']);
  set data(Map value) => jsProxy['data'] = jsify(value);
}
