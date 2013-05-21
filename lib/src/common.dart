library common;

import 'dart:async';
import 'dart:html';

import 'package:js/js.dart' as js;
import 'package:logging/logging.dart';

dynamic get chromeProxy => js.context.chrome;

String get lastError {
  js.Proxy error = chromeProxy.runtime['lastError'];

  if (error != null) {
    return error['message'];
  } else {
    return null;
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
