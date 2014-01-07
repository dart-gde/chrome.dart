
library chrome.src.common;

import 'dart:convert';

import 'dart:async';
export 'dart:async';

import 'dart:js';
export 'dart:js';

import 'common_exp.dart';
export 'common_exp.dart';

final JsObject _jsJSON = context['JSON'];

final JsObject chrome = context['chrome'];
final JsObject _runtime = context['chrome']['runtime'];

String get lastError {
  JsObject error = _runtime['lastError'];
  return error != null ? error['message'] : null;
}

List listify(JsObject obj, [Function transformer = null]) {
  if (obj == null) {
    return null;
  } else {
    List l = new List(obj['length']);

    for (int i = 0; i < l.length; i++) {
      if (transformer != null) {
        l[i] = transformer(obj[i]);
      } else {
        l[i] = obj[i];
      }
    }

    return l;
  }
}

Map mapify(JsObject obj) {
  if (obj == null) return null;
  return JSON.decode(_jsJSON.callMethod('stringify', [obj]));
}

dynamic jsify(dynamic obj) {
  if (obj == null || obj is num || obj is String) {
    return obj;
  } else if (obj is ChromeObject) {
    return (obj as ChromeObject).jsProxy;
  } else if (obj is ChromeEnum) {
    return (obj as ChromeEnum).value;
  } else if (obj is Map) {
    // Do a deep convert.
    Map m = {};
    for (var key in obj.keys) {
      m[key] = jsify(obj[key]);
    }
    return new JsObject.jsify(m);
  } else if (obj is Iterable) {
    // Do a deep convert.
    return new JsArray.from((obj as Iterable).map(jsify));
  } else {
    return obj;
  }
}

dynamic selfConverter(var obj) => obj;

/**
 * An object for handling completion callbacks that are common in the chrome.*
 * APIs.
 */
class ChromeCompleter<T> {
  final Completer<T> _completer = new Completer();
  Function _callback;

  ChromeCompleter.noArgs() {
    this._callback = () {
      var le = lastError;
      if (le != null) {
        _completer.completeError(le);
      } else {
        _completer.complete();
      }
    };
  }

  ChromeCompleter.oneArg([Function transformer]) {
    this._callback = ([arg1]) {
      var le = lastError;
      if (le != null) {
        _completer.completeError(le);
      } else {
        if (transformer != null) {
          arg1 = transformer(arg1);
        }
        _completer.complete(arg1);
      }
    };
  }

  ChromeCompleter.twoArgs(Function transformer) {
    this._callback = ([arg1, arg2]) {
      var le = lastError;
      if (le != null) {
        _completer.completeError(le);
      } else {
        _completer.complete(transformer(arg1, arg2));
      }
    };
  }

  Future<T> get future => _completer.future;

  Function get callback => _callback;
}

class ChromeStreamController<T> {
  final JsObject _api;
  final String _eventName;
  StreamController<T> _controller = new StreamController<T>.broadcast();
  bool _handlerAdded = false;
  Function _listener;

  ChromeStreamController.noArgs(this._api, this._eventName) {
    _controller = new StreamController<T>.broadcast(
        onListen: _ensureHandlerAdded, onCancel: _removeHandler);
    _listener = () {
      _controller.add(null);
    };
  }

  ChromeStreamController.oneArg(this._api, this._eventName, Function transformer, [returnVal])  {
    _controller = new StreamController<T>.broadcast(
        onListen: _ensureHandlerAdded, onCancel: _removeHandler);
    _listener = ([arg1]) {
      _controller.add(transformer(arg1));
      return returnVal;
    };
  }

  ChromeStreamController.twoArgs(this._api, this._eventName, Function transformer, [returnVal]) {
    _controller = new StreamController<T>.broadcast(
        onListen: _ensureHandlerAdded, onCancel: _removeHandler);
    _listener = ([arg1, arg2]) {
      _controller.add(transformer(arg1, arg2));
      return returnVal;
    };
  }

  ChromeStreamController.threeArgs(this._api, this._eventName, Function transformer, [returnVal]) {
    _controller = new StreamController<T>.broadcast(
        onListen: _ensureHandlerAdded, onCancel: _removeHandler);
    _listener = ([arg1, arg2, arg3]) {
        _controller.add(transformer(arg1, arg2, arg3));
        return returnVal;
    };
  }

  bool get hasListener => _controller.hasListener;

  Stream<T> get stream {
    return _controller.stream;
  }

  void _ensureHandlerAdded() {
    if (!_handlerAdded) {
      _api[_eventName].callMethod('addListener', [_listener]);
      _handlerAdded = true;
    }
  }

  void _removeHandler() {
    if (_handlerAdded) {
      _api[_eventName].callMethod('removeListener', [_listener]);
      _handlerAdded = false;
    }
  }
}
