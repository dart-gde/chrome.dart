/* This file has been generated from notifications.idl - do not edit */

/**
 * Use the `chrome.notifications` API to create rich notifications using
 * templates and show these notifications to users in the system tray.
 */
library chrome.notifications;

import '../src/common.dart';

/**
 * Accessor for the `chrome.notifications` namespace.
 */
final ChromeNotifications notifications = new ChromeNotifications._();

class ChromeNotifications extends ChromeApi {
  static final JsObject _notifications = chrome['notifications'];

  ChromeNotifications._();

  bool get available => _notifications != null;

  /**
   * Creates and displays a notification.
   * [notificationId]: Identifier of the notification. If it is empty, this
   * method generates an id. If it matches an existing notification, this method
   * first clears that notification before proceeding with the create operation.
   * [options]: Contents of the notification.
   * [callback]: Returns the notification id (either supplied or generated) that
   * represents the created notification.
   */
  Future<String> create(String notificationId, NotificationOptions options) {
    if (_notifications == null) _throwNotAvailable();

    var completer = new ChromeCompleter<String>.oneArg();
    _notifications.callMethod('create', [notificationId, jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Updates an existing notification.
   * [notificationId]: The id of the notification to be updated. This is
   * returned by [notifications.create] method.
   * [options]: Contents of the notification to update to.
   * [callback]: Called to indicate whether a matching notification existed.
   */
  Future<bool> update(String notificationId, NotificationOptions options) {
    if (_notifications == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _notifications.callMethod('update', [notificationId, jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Clears the specified notification.
   * [notificationId]: The id of the notification to be cleared. This is
   * returned by [notifications.create] method.
   * [callback]: Called to indicate whether a matching notification existed.
   */
  Future<bool> clear(String notificationId) {
    if (_notifications == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _notifications.callMethod('clear', [notificationId, completer.callback]);
    return completer.future;
  }

  /**
   * Retrieves all the notifications.
   * [callback]: Returns the set of notification_ids currently in the system.
   */
  Future<dynamic> getAll() {
    if (_notifications == null) _throwNotAvailable();

    var completer = new ChromeCompleter<dynamic>.oneArg();
    _notifications.callMethod('getAll', [completer.callback]);
    return completer.future;
  }

  /**
   * Retrieves whether the user has enabled notifications from this app or
   * extension.
   * [callback]: Returns the current permission level.
   */
  Future<PermissionLevel> getPermissionLevel() {
    if (_notifications == null) _throwNotAvailable();

    var completer = new ChromeCompleter<PermissionLevel>.oneArg(_createPermissionLevel);
    _notifications.callMethod('getPermissionLevel', [completer.callback]);
    return completer.future;
  }

  Stream<OnClosedEvent> get onClosed => _onClosed.stream;

  final ChromeStreamController<OnClosedEvent> _onClosed =
      new ChromeStreamController<OnClosedEvent>.twoArgs(_notifications, 'onClosed', _createOnClosedEvent);

  Stream<String> get onClicked => _onClicked.stream;

  final ChromeStreamController<String> _onClicked =
      new ChromeStreamController<String>.oneArg(_notifications, 'onClicked', selfConverter);

  Stream<OnButtonClickedEvent> get onButtonClicked => _onButtonClicked.stream;

  final ChromeStreamController<OnButtonClickedEvent> _onButtonClicked =
      new ChromeStreamController<OnButtonClickedEvent>.twoArgs(_notifications, 'onButtonClicked', _createOnButtonClickedEvent);

  Stream<PermissionLevel> get onPermissionLevelChanged => _onPermissionLevelChanged.stream;

  final ChromeStreamController<PermissionLevel> _onPermissionLevelChanged =
      new ChromeStreamController<PermissionLevel>.oneArg(_notifications, 'onPermissionLevelChanged', _createPermissionLevel);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.notifications' is not available");
  }
}

class OnClosedEvent {
  final String notificationId;

  final bool byUser;

  OnClosedEvent(this.notificationId, this.byUser);
}

class OnButtonClickedEvent {
  final String notificationId;

  final int buttonIndex;

  OnButtonClickedEvent(this.notificationId, this.buttonIndex);
}

class TemplateType extends ChromeEnum {
  static const TemplateType BASIC = const TemplateType._('basic');
  static const TemplateType IMAGE = const TemplateType._('image');
  static const TemplateType LIST = const TemplateType._('list');
  static const TemplateType PROGRESS = const TemplateType._('progress');

  static const List<TemplateType> VALUES = const[BASIC, IMAGE, LIST, PROGRESS];

  const TemplateType._(String str): super(str);
}

class PermissionLevel extends ChromeEnum {
  static const PermissionLevel GRANTED = const PermissionLevel._('granted');
  static const PermissionLevel DENIED = const PermissionLevel._('denied');

  static const List<PermissionLevel> VALUES = const[GRANTED, DENIED];

  const PermissionLevel._(String str): super(str);
}

class NotificationItem extends ChromeObject {
  NotificationItem({String title, String message}) {
    if (title != null) this.title = title;
    if (message != null) this.message = message;
  }
  NotificationItem.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get title => jsProxy['title'];
  set title(String value) => jsProxy['title'] = value;

  String get message => jsProxy['message'];
  set message(String value) => jsProxy['message'] = value;
}

class NotificationBitmap extends ChromeObject {
  NotificationBitmap({int width, int height, ArrayBuffer data}) {
    if (width != null) this.width = width;
    if (height != null) this.height = height;
    if (data != null) this.data = data;
  }
  NotificationBitmap.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get width => jsProxy['width'];
  set width(int value) => jsProxy['width'] = value;

  int get height => jsProxy['height'];
  set height(int value) => jsProxy['height'] = value;

  ArrayBuffer get data => _createArrayBuffer(jsProxy['data']);
  set data(ArrayBuffer value) => jsProxy['data'] = jsify(value);
}

class NotificationButton extends ChromeObject {
  NotificationButton({String title, String iconUrl, NotificationBitmap iconBitmap}) {
    if (title != null) this.title = title;
    if (iconUrl != null) this.iconUrl = iconUrl;
    if (iconBitmap != null) this.iconBitmap = iconBitmap;
  }
  NotificationButton.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get title => jsProxy['title'];
  set title(String value) => jsProxy['title'] = value;

  String get iconUrl => jsProxy['iconUrl'];
  set iconUrl(String value) => jsProxy['iconUrl'] = value;

  NotificationBitmap get iconBitmap => _createNotificationBitmap(jsProxy['iconBitmap']);
  set iconBitmap(NotificationBitmap value) => jsProxy['iconBitmap'] = jsify(value);
}

class NotificationOptions extends ChromeObject {
  NotificationOptions({TemplateType type, String iconUrl, NotificationBitmap iconBitmap, String title, String message, String contextMessage, int priority, num eventTime, List<NotificationButton> buttons, String expandedMessage, String imageUrl, NotificationBitmap imageBitmap, List<NotificationItem> items, int progress, bool isClickable}) {
    if (type != null) this.type = type;
    if (iconUrl != null) this.iconUrl = iconUrl;
    if (iconBitmap != null) this.iconBitmap = iconBitmap;
    if (title != null) this.title = title;
    if (message != null) this.message = message;
    if (contextMessage != null) this.contextMessage = contextMessage;
    if (priority != null) this.priority = priority;
    if (eventTime != null) this.eventTime = eventTime;
    if (buttons != null) this.buttons = buttons;
    if (expandedMessage != null) this.expandedMessage = expandedMessage;
    if (imageUrl != null) this.imageUrl = imageUrl;
    if (imageBitmap != null) this.imageBitmap = imageBitmap;
    if (items != null) this.items = items;
    if (progress != null) this.progress = progress;
    if (isClickable != null) this.isClickable = isClickable;
  }
  NotificationOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  TemplateType get type => _createTemplateType(jsProxy['type']);
  set type(TemplateType value) => jsProxy['type'] = jsify(value);

  String get iconUrl => jsProxy['iconUrl'];
  set iconUrl(String value) => jsProxy['iconUrl'] = value;

  NotificationBitmap get iconBitmap => _createNotificationBitmap(jsProxy['iconBitmap']);
  set iconBitmap(NotificationBitmap value) => jsProxy['iconBitmap'] = jsify(value);

  String get title => jsProxy['title'];
  set title(String value) => jsProxy['title'] = value;

  String get message => jsProxy['message'];
  set message(String value) => jsProxy['message'] = value;

  String get contextMessage => jsProxy['contextMessage'];
  set contextMessage(String value) => jsProxy['contextMessage'] = value;

  int get priority => jsProxy['priority'];
  set priority(int value) => jsProxy['priority'] = value;

  num get eventTime => jsProxy['eventTime'];
  set eventTime(num value) => jsProxy['eventTime'] = jsify(value);

  List<NotificationButton> get buttons => listify(jsProxy['buttons'], _createNotificationButton);
  set buttons(List<NotificationButton> value) => jsProxy['buttons'] = jsify(value);

  String get expandedMessage => jsProxy['expandedMessage'];
  set expandedMessage(String value) => jsProxy['expandedMessage'] = value;

  String get imageUrl => jsProxy['imageUrl'];
  set imageUrl(String value) => jsProxy['imageUrl'] = value;

  NotificationBitmap get imageBitmap => _createNotificationBitmap(jsProxy['imageBitmap']);
  set imageBitmap(NotificationBitmap value) => jsProxy['imageBitmap'] = jsify(value);

  List<NotificationItem> get items => listify(jsProxy['items'], _createNotificationItem);
  set items(List<NotificationItem> value) => jsProxy['items'] = jsify(value);

  int get progress => jsProxy['progress'];
  set progress(int value) => jsProxy['progress'] = value;

  bool get isClickable => jsProxy['isClickable'];
  set isClickable(bool value) => jsProxy['isClickable'] = value;
}

PermissionLevel _createPermissionLevel(String value) => PermissionLevel.VALUES.singleWhere((ChromeEnum e) => e.value == value);
OnClosedEvent _createOnClosedEvent(String notificationId, bool byUser) =>
    new OnClosedEvent(notificationId, byUser);
OnButtonClickedEvent _createOnButtonClickedEvent(String notificationId, int buttonIndex) =>
    new OnButtonClickedEvent(notificationId, buttonIndex);
ArrayBuffer _createArrayBuffer(/*JsObject*/ jsProxy) => jsProxy == null ? null : new ArrayBuffer.fromProxy(jsProxy);
NotificationBitmap _createNotificationBitmap(JsObject jsProxy) => jsProxy == null ? null : new NotificationBitmap.fromProxy(jsProxy);
TemplateType _createTemplateType(String value) => TemplateType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
NotificationButton _createNotificationButton(JsObject jsProxy) => jsProxy == null ? null : new NotificationButton.fromProxy(jsProxy);
NotificationItem _createNotificationItem(JsObject jsProxy) => jsProxy == null ? null : new NotificationItem.fromProxy(jsProxy);
