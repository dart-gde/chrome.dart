/* This file has been generated from gcm.json - do not edit */

/**
 * Use `chrome.gcm` to enable apps and extensions to send and receive messages
 * through the [Google Cloud Messaging
 * Service](http://developer.android.com/google/gcm/).
 */
library chrome.gcm;

import '../src/common.dart';

/**
 * Accessor for the `chrome.gcm` namespace.
 */
final ChromeGcm gcm = new ChromeGcm._();

class ChromeGcm extends ChromeApi {
  JsObject get _gcm => chrome['gcm'];

  /**
   * Fired when a message is received through GCM.
   */
  Stream<Map> get onMessage => _onMessage.stream;
  ChromeStreamController<Map> _onMessage;

  /**
   * Fired when a GCM server had to delete messages sent by an app server to the
   * application. See [Messages deleted
   * event](cloudMessaging#messages_deleted_event) section of Cloud Messaging
   * documentation for details on handling this event.
   */
  Stream get onMessagesDeleted => _onMessagesDeleted.stream;
  ChromeStreamController _onMessagesDeleted;

  /**
   * Fired when it was not possible to send a message to the GCM server.
   */
  Stream<Map> get onSendError => _onSendError.stream;
  ChromeStreamController<Map> _onSendError;

  ChromeGcm._() {
    var getApi = () => _gcm;
    _onMessage = new ChromeStreamController<Map>.oneArg(getApi, 'onMessage', mapify);
    _onMessagesDeleted = new ChromeStreamController.noArgs(getApi, 'onMessagesDeleted');
    _onSendError = new ChromeStreamController<Map>.oneArg(getApi, 'onSendError', mapify);
  }

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
   * Unregisters the application from GCM.
   */
  Future unregister() {
    if (_gcm == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _gcm.callMethod('unregister', [completer.callback]);
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
   * The ID of the message. It must be unique for each message in scope of the
   * applications. See the [Cloud Messaging
   * documentation](cloudMessaging#send_messages) for advice for picking and
   * handling an ID.
   */
  String get messageId => jsProxy['messageId'];
  set messageId(String value) => jsProxy['messageId'] = value;

  /**
   * Time-to-live of the message in seconds. If it is not possible to send the
   * message within that time, an onSendError event will be raised. A
   * time-to-live of 0 indicates that the message should be sent immediately or
   * fail if it's not possible. The maximum and a default value of time-to-live
   * is 86400 seconds (1 day).
   */
  int get timeToLive => jsProxy['timeToLive'];
  set timeToLive(int value) => jsProxy['timeToLive'] = value;

  /**
   * Message data to send to the server. Case-insensitive `goog.` and `google`,
   * as well as case-sensitive `collapse_key` are disallowed as key prefixes.
   * Sum of all key/value pairs should not exceed [gcm.MAX_MESSAGE_SIZE].
   */
  Map get data => mapify(jsProxy['data']);
  set data(Map value) => jsProxy['data'] = jsify(value);
}
