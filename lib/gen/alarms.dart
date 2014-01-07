/* This file has been generated from alarms.idl - do not edit */

/**
 * Use the `chrome.alarms` API to schedule code to run periodically or at a
 * specified time in the future.
 */
library chrome.alarms;

import '../src/common.dart';

/**
 * Accessor for the `chrome.alarms` namespace.
 */
final ChromeAlarms alarms = new ChromeAlarms._();

class ChromeAlarms extends ChromeApi {
  static final JsObject _alarms = chrome['alarms'];

  ChromeAlarms._();

  bool get available => _alarms != null;

  /**
   * Creates an alarm. Near the time(s) specified by [alarmInfo], the `onAlarm`
   * event is fired. If there is another alarm with the same name (or no name if
   * none is specified), it will be cancelled and replaced by this alarm.
   * 
   * In order to reduce the load on the user's machine, Chrome limits alarms to
   * at most once every 1 minute but may delay them an arbitrary amount more.
   * That is, setting `delayInMinutes` or `periodInMinutes` to less than `1`
   * will not be honored and will cause a warning. `when` can be set to less
   * than 1 minute after "now" without warning but won't actually cause the
   * alarm to fire for at least 1 minute.
   * 
   * To help you debug your app or extension, when you've loaded it unpacked,
   * there's no limit to how often the alarm can fire.
   * 
   * [name]: Optional name to identify this alarm. Defaults to the empty string.
   * 
   * [alarmInfo]: Describes when the alarm should fire. The initial time must be
   * specified by either [when] or [delayInMinutes] (but not both). If
   * [periodInMinutes] is set, the alarm will repeat every [periodInMinutes]
   * minutes after the initial event. If neither [when] or [delayInMinutes] is
   * set for a repeating alarm, [periodInMinutes] is used as the default for
   * [delayInMinutes].
   */
  void create(AlarmCreateInfo alarmInfo, [String name]) {
    if (_alarms == null) _throwNotAvailable();

    _alarms.callMethod('create', [name, jsify(alarmInfo)]);
  }

  /**
   * Retrieves details about the specified alarm.
   * [name]: The name of the alarm to get. Defaults to the empty string.
   */
  Future<Alarm> get([String name]) {
    if (_alarms == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Alarm>.oneArg(_createAlarm);
    _alarms.callMethod('get', [name, completer.callback]);
    return completer.future;
  }

  /**
   * Gets an array of all the alarms.
   */
  Future<List<Alarm>> getAll() {
    if (_alarms == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<Alarm>>.oneArg((e) => listify(e, _createAlarm));
    _alarms.callMethod('getAll', [completer.callback]);
    return completer.future;
  }

  /**
   * Clears the alarm with the given name.
   * [name]: The name of the alarm to clear. Defaults to the empty string.
   */
  void clear([String name]) {
    if (_alarms == null) _throwNotAvailable();

    _alarms.callMethod('clear', [name]);
  }

  /**
   * Clears all alarms.
   */
  void clearAll() {
    if (_alarms == null) _throwNotAvailable();

    _alarms.callMethod('clearAll');
  }

  Stream<Alarm> get onAlarm => _onAlarm.stream;

  final ChromeStreamController<Alarm> _onAlarm =
      new ChromeStreamController<Alarm>.oneArg(_alarms, 'onAlarm', _createAlarm);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.alarms' is not available");
  }
}

class Alarm extends ChromeObject {
  Alarm({String name, num scheduledTime, num periodInMinutes}) {
    if (name != null) this.name = name;
    if (scheduledTime != null) this.scheduledTime = scheduledTime;
    if (periodInMinutes != null) this.periodInMinutes = periodInMinutes;
  }
  Alarm.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  num get scheduledTime => jsProxy['scheduledTime'];
  set scheduledTime(num value) => jsProxy['scheduledTime'] = jsify(value);

  num get periodInMinutes => jsProxy['periodInMinutes'];
  set periodInMinutes(num value) => jsProxy['periodInMinutes'] = jsify(value);
}

/**
 * todo(mpcomplete): rename to CreateInfo when http://crbug.com/123073 is fixed.
 */
class AlarmCreateInfo extends ChromeObject {
  AlarmCreateInfo({num when, num delayInMinutes, num periodInMinutes}) {
    if (when != null) this.when = when;
    if (delayInMinutes != null) this.delayInMinutes = delayInMinutes;
    if (periodInMinutes != null) this.periodInMinutes = periodInMinutes;
  }
  AlarmCreateInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  num get when => jsProxy['when'];
  set when(num value) => jsProxy['when'] = jsify(value);

  num get delayInMinutes => jsProxy['delayInMinutes'];
  set delayInMinutes(num value) => jsProxy['delayInMinutes'] = jsify(value);

  num get periodInMinutes => jsProxy['periodInMinutes'];
  set periodInMinutes(num value) => jsProxy['periodInMinutes'] = jsify(value);
}

Alarm _createAlarm(JsObject jsProxy) => jsProxy == null ? null : new Alarm.fromProxy(jsProxy);
