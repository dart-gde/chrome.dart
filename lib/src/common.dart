library common;

import 'dart:async';
import 'dart:html';
import 'dart:web_audio';

import 'package:js/js.dart' as js;
import 'package:logging/logging.dart';

dynamic get context => js.context;
dynamic get chrome => context.chrome;

String get lastError {
  js.Proxy error = chrome.runtime['lastError'];

  if (error != null) {
    return error['message'];
  } else {
    return null;
  }
}

String toTitleCase(String str) {
  if (str.length < 2) {
    return str.toUpperCase();
  } else {
    return str.substring(0, 1).toUpperCase() + str.substring(1).toLowerCase();
  }
}
/**
 * Strip off one set of leading and trailing single or double quotes.
 */
String stripQuotes(String str) {
  if (str.length < 2) {
    return str;
  }

  if (str.startsWith("'") && str.endsWith("'")) {
    return str.substring(1, str.length - 1);
  }

  if (str.startsWith('"') && str.endsWith('"')) {
    return str.substring(1, str.length - 1);
  }

  return str;
}

void jsRelease(js.Proxy proxy) {
  // TODO: workaround a js interop / CSP bug? seems to only happen with ace
  try {
    js.release(proxy);
  } catch (ex) {
    try {
      print("Exception call js.release() on ${proxy}");
    } catch (_) {

    }

    print(ex);
  }
}

bool isLinux() {
  return _platform().indexOf('linux') != -1;
}

bool isMac() {
  return _platform().indexOf('mac') != -1;
}

bool isWin() {
  return _platform().indexOf('win') != -1;
}

String _platform() {
  String str = window.navigator.platform;

  return (str != null) ? str.toLowerCase() : '';
}

AudioContext _ctx;

void beep() {
  if (_ctx == null) {
    _ctx = new AudioContext();
  }

  OscillatorNode osc = _ctx.createOscillator();

  osc.connect(_ctx.destination, 0, 0);
  osc.start(0);
  osc.stop(_ctx.currentTime + 0.1);
}