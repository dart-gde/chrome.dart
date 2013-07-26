library chrome.common;

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

/**
 * An object for handling completion callbacks that are common in the
 * chrome.* APIs.
 */
class ChromeCompleter<T> {
  final Completer<T> _completer = new Completer();
  Function _transformer = (value) => value;

  ChromeCompleter([Function transformer]) {
    if (transformer != null) {
      this._transformer = transformer;
    }
  }

  // TODO(DrMarcII): remove these unnecessary constructors
  ChromeCompleter.noArgs() : this();

  ChromeCompleter.oneArg() : this();

  ChromeCompleter.transform(Function transformer) : this(transformer);

  Future<T> get future {
    return _completer.future;
  }

  js.Callback get callback {
    return new js.Callback.once(_callback);
  }

  Function _callback([value]) {
    var le = lastError;
    if (le != null) {
      _completer.completeError(le);
    } else {
      _completer.complete(_transformer(value));
    }
  }
}

class ChromeStreamController<T> {
  final _event;
  dynamic _transformer;
  StreamController<T> _controller = new StreamController<T>.broadcast();
  bool _handlerAdded = false;

  ChromeStreamController.zeroArgs(this._event, dynamic transformer) {
    _transformer = () => _controller.add(transformer());
  }

  ChromeStreamController.oneArg(this._event, dynamic transformer) {
    _transformer = ([arg1]) => _controller.add(transformer(arg1));
  }

  ChromeStreamController.twoArgs(this._event, dynamic transformer) {
    _transformer = ([arg1, arg2]) => _controller.add(transformer(arg1, arg2));
  }

  ChromeStreamController.threeArgs(this._event, dynamic transformer) {
    _transformer = ([arg1, arg2, arg3]) =>
        _controller.add(transformer(arg1, arg2, arg3));
  }

  Stream<T> get stream {
    _ensureHandlerAdded();
    return _controller.stream;
  }

  void _ensureHandlerAdded() {
    if (!_handlerAdded) {
      js.scoped(() {
        _event().addListener(new js.Callback.many(_transformer));
      });
      _handlerAdded = true;
    }
  }
}