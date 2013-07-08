library chrome.common;

import 'dart:async';
import 'dart:html';

import 'package:js/js.dart' as js;
import 'package:logging/logging.dart';

typedef T transformer<T>(dynamic value);

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

/**
 * An object for handling completion callbacks that are common in the
 * chrome.* APIs.
 */
class ChromeCompleter<T> {
  final Completer<T> _completer = new Completer();
  js.Callback _callback;

  ChromeCompleter.noArgs() {
    this._callback = new js.Callback.once(_complete);
  }

  ChromeCompleter.oneArg() {
    this._callback = new js.Callback.once(_complete);
  }

  ChromeCompleter.transform(transformer<T> function) {
    this._callback = new js.Callback.once((dynamic value) {
      _complete(function(value));
    });
  }

  Future<T> get future {
    return _completer.future;
  }

  js.Callback get callback {
    return _callback;
  }

  void _complete([value]) {
    var le = lastError;
    if (le != null) {
      _completer.completeError(le);
    } else {
      _completer.complete(value);
    }
  }
}