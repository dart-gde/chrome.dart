/* This file has been generated from idle.json - do not edit */

/**
 * Use the `chrome.idle` API to detect when the machine's idle state changes.
 */
library chrome.idle;

import '../src/common.dart';

/**
 * Accessor for the `chrome.idle` namespace.
 */
final ChromeIdle idle = new ChromeIdle._();

class ChromeIdle extends ChromeApi {
  static final JsObject _idle = chrome['idle'];

  ChromeIdle._();

  bool get available => _idle != null;

  /**
   * Returns "locked" if the system is locked, "idle" if the user has not
   * generated any input for a specified number of seconds, or "active"
   * otherwise.
   * 
   * [detectionIntervalInSeconds] The system is considered idle if
   * detectionIntervalInSeconds seconds have elapsed since the last user input
   * detected.
   * 
   * Returns:
   * enum of `active`, `idle`, `locked`
   */
  Future<String> queryState(int detectionIntervalInSeconds) {
    if (_idle == null) _throwNotAvailable();

    var completer = new ChromeCompleter<String>.oneArg();
    _idle.callMethod('queryState', [detectionIntervalInSeconds, completer.callback]);
    return completer.future;
  }

  /**
   * Sets the interval, in seconds, used to determine when the system is in an
   * idle state for onStateChanged events. The default interval is 60 seconds.
   * 
   * [intervalInSeconds] Threshold, in seconds, used to determine when the
   * system is in an idle state.
   */
  void setDetectionInterval(int intervalInSeconds) {
    if (_idle == null) _throwNotAvailable();

    _idle.callMethod('setDetectionInterval', [intervalInSeconds]);
  }

  /**
   * Fired when the system changes to an active, idle or locked state. The event
   * fires with "locked" if the screen is locked or the screensaver activates,
   * "idle" if the system is unlocked and the user has not generated any input
   * for a specified number of seconds, and "active" when the user generates
   * input on an idle system.
   */
  Stream<String> get onStateChanged => _onStateChanged.stream;

  final ChromeStreamController<String> _onStateChanged =
      new ChromeStreamController<String>.oneArg(_idle, 'onStateChanged', selfConverter);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.idle' is not available");
  }
}
