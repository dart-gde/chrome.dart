library chrome.common;

import 'dart:async';
import 'dart:convert' show JSON;

import 'package:js/js.dart' as js;

import 'runtime.dart';

dynamic get jsContext => js.context as dynamic;
dynamic get chromeProxy => jsContext.chrome;

dynamic convertJsonResponse(dynamic response) {
  return js.scoped(() {
    return JSON.decode(jsContext.JSON.stringify(response));
  });
}

dynamic jsifyMessage(dynamic message) {
  if (message is Map) {
    return js.map(message);
  } else if (message is Iterable) {
    return js.array(message);
  } else {
    return message;
  }
}

List listify(dynamic jsArray) {
  var list = [];
  for (int i = 0; i < jsArray.length; i++) {
    list.add(jsArray[i]);
  }
  // TODO(DrMarcII) consider having this return an unmodifiable list
  return list;
}

/**
 * An object for handling completion callbacks that are common in the chrome.*
 * APIs.
 */
class ChromeCompleter<T> {
  final Completer<T> _completer = new Completer();
  js.Callback _callback;

  ChromeCompleter.noArgs() {
    this._callback = new js.Callback.once(() {
      var le = runtime.lastError;
      if (le != null) {
        _completer.completeError(le);
      } else {
        _completer.complete();
      }
    });
  }

  ChromeCompleter.oneArg([Function transformer]) {
    this._callback = new js.Callback.once(([arg1]) {
      var le = runtime.lastError;
      if (le != null) {
        _completer.completeError(le);
      } else {
        if (transformer != null) {
          arg1 = transformer(arg1);
        }
        _completer.complete(arg1);
      }
    });
  }

  ChromeCompleter.twoArgs(Function transformer) {
    this._callback = new js.Callback.once(([arg1, arg2]) {
      var le = runtime.lastError;
      if (le != null) {
        _completer.completeError(le);
      } else {
        _completer.complete(transformer(arg1, arg2));
      }
    });
  }

  Future<T> get future => _completer.future;

  js.Callback get callback => _callback;
}

class ChromeStreamController<T> {
  final Function _event;
  StreamController<T> _controller = new StreamController<T>.broadcast();
  bool _handlerAdded = false;
  js.Callback _listener;

  ChromeStreamController.zeroArgs(this._event, Function transformer, [returnVal]) {
    _controller = new StreamController<T>.broadcast(
        onListen: _ensureHandlerAdded, onCancel: _removeHandler);
    _listener = new js.Callback.many(() {
      _controller.add(transformer());
      return returnVal;
    });
  }

  ChromeStreamController.oneArg(this._event, Function transformer, [returnVal])  {
    _controller = new StreamController<T>.broadcast(
        onListen: _ensureHandlerAdded, onCancel: _removeHandler);
    _listener = new js.Callback.many(([arg1]) {
      _controller.add(transformer(arg1));
      return returnVal;
    });
  }

  ChromeStreamController.twoArgs(this._event, Function transformer, [returnVal]) {
    _controller = new StreamController<T>.broadcast(
        onListen: _ensureHandlerAdded, onCancel: _removeHandler);
    _listener = new js.Callback.many(([arg1, arg2]) {
      _controller.add(transformer(arg1, arg2));
      return returnVal;
    });
  }

  ChromeStreamController.threeArgs(this._event, Function transformer, [returnVal]) {
    _controller = new StreamController<T>.broadcast(
        onListen: _ensureHandlerAdded, onCancel: _removeHandler);
    _listener = new js.Callback.many(([arg1, arg2, arg3]) {
        _controller.add(transformer(arg1, arg2, arg3));
        return returnVal;
    });
  }

  bool get hasListener => _controller.hasListener;

  Stream<T> get stream {
    return _controller.stream;
  }

  void _ensureHandlerAdded() {
    if (!_handlerAdded) {
      js.scoped(() {
        _event().addListener(_listener);
      });
      _handlerAdded = true;
    }
  }

  void _removeHandler() {
    if (_handlerAdded) {
      js.scoped(() {
        _event().removeListener(_listener);
      });
      _handlerAdded = false;
    }
  }
}