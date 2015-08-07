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
  JsObject get _idle => chrome['idle'];

  /**
   * Fired when the system changes to an active, idle or locked state. The event
   * fires with "locked" if the screen is locked or the screensaver activates,
   * "idle" if the system is unlocked and the user has not generated any input
   * for a specified number of seconds, and "active" when the user generates
   * input on an idle system.
   */
  Stream<IdleState> get onStateChanged => _onStateChanged.stream;
  ChromeStreamController<IdleState> _onStateChanged;

  ChromeIdle._() {
    var getApi = () => _idle;
    _onStateChanged = new ChromeStreamController<IdleState>.oneArg(getApi, 'onStateChanged', _createIdleState);
  }

  bool get available => _idle != null;

  /**
   * Returns "locked" if the system is locked, "idle" if the user has not
   * generated any input for a specified number of seconds, or "active"
   * otherwise.
   * 
   * [detectionIntervalInSeconds] The system is considered idle if
   * detectionIntervalInSeconds seconds have elapsed since the last user input
   * detected.
   */
  Future<IdleState> queryState(int detectionIntervalInSeconds) {
    if (_idle == null) _throwNotAvailable();

    var completer = new ChromeCompleter<IdleState>.oneArg(_createIdleState);
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

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.idle' is not available");
  }
}

/**
 * enum of `active`, `idle`, `locked`
 */
class IdleState extends ChromeObject {
  IdleState();
  IdleState.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

IdleState _createIdleState(JsObject jsProxy) => jsProxy == null ? null : new IdleState.fromProxy(jsProxy);
