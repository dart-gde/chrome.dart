
/**
 * Use the chrome.power module to temporarily disable aspects of system power
 * management.
 */
library chrome.power;

import 'dart:async';

import 'package:js/js.dart' as js;

import 'common.dart';

final ChromePower power = new ChromePower();

// chrome.power

/**
 * By default, operating systems dim the screen when users are inactive and
 * eventually suspend the system. With the power API, an app or extension can
 * keep the system awake.
 * 
 * Using this API, you can specify the Level to which power management is
 * disabled. The "system" level keeps the system active, but allows the screen
 * to be dimmed or turned off. For example, a communication app can continue to
 * receive messages while the screen is off. The "display" level keeps the
 * screen and system active. E-book and presentation apps, for example, can keep
 * the screen and system active while users read.
 * 
 * When a user has more than one app or extension active, each with its own
 * power level, the highest-precedence level takes effect; "display" always
 * takes precendence over "system". For example, if app A asks for "system"
 * power management, and app B asks for "display", "display" is used until app
 * B is unloaded or releases its request. If app A is still active, "system" is
 * then used.
 */
class ChromePower {
  /**
   * The "system" level keeps the system active, but allows the screen to be
   * dimmed or turned off.
   */
  static final String SYSTEM = 'system';
  
  /**
   * The "display" level keeps the screen and system active.
   */
  static final String DISPLAY = 'display';
  
  /**
   * Requests that power management be temporarily disabled. [:level:] describes
   * the degree to which power management should be disabled.
   */
  void requestKeepAwake(String level) {
    return chromeProxy.power.requestKeepAwake(level);
  }

  /**
   * Releases a request previously made via requestKeepAwake().
   */
  void releaseKeepAwake() {
    chromeProxy.power.releaseKeepAwake();
  }
}
