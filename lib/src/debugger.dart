library chrome.debugger;

import 'dart:async';
import 'package:js/js.dart' as js;
import 'package:js/js_wrapping.dart' as jsw;

import 'runtime.dart';

/// Accessor for the `chrome.debugger` namespace.
final Debugger debugger = new Debugger._();

dynamic get _chrome => (js.context as dynamic).chrome;

/**
 * Debugger API serves as an alternate transport for Chrome's remote debugging
 * protocol. Use chrome.debugger to attach to one or more tabs to instrument
 * network interaction, debug JavaScript, mutate the DOM and CSS, etc. Use the
 * Debuggee tabId to target tabs with sendCommand and route events by tabId from
 * onEvent callbacks.
 *
 * As of today, attaching to the tab by means of the debugger API and using
 * embedded Chrome DevTools with that tab are mutually exclusive. If user
 * invokes Chrome DevTools while extension is attached to the tab, debugging
 * session is terminated. Extension can re-establish it later.
 */
class Debugger {
  StreamController<DetachEvent> _detachStreamController =
      new StreamController<DetachEvent>();
  StreamController<DebuggerEvent> _eventStreamController =
      new StreamController<DebuggerEvent>();

  Stream<DetachEvent> _detachStream;
  Stream<DebuggerEvent> _eventStream;

  Debugger._() {
    _detachStream = _detachStreamController.stream.asBroadcastStream();

    js.Callback detachListener = new js.Callback.many((var source, String reason) {
      _detachStreamController.add(
          new DetachEvent._(new Debuggee._fromProxy(source), reason));
    });

    _eventStream = _eventStreamController.stream.asBroadcastStream();
    js.Callback eventListener = new js.Callback.many((var source, String method, [var params]) {
      _eventStreamController.add(
          new DebuggerEvent._(new Debuggee._fromProxy(source),
              method,
              new jsw.JsObjectToMapAdapter.fromProxy(params)));
    });
  }

  /**
   * Attaches debugger to the given target.
   *
   * Required debugging protocol version ("0.1"). One can only attach to the
   * debuggee with matching major version and greater or equal minor version.
   */
  Future<Debuggee> attach(Debuggee target, String requiredVersion) {
    return js.scoped(() {
      Completer completer = new Completer();

      js.Callback callback = new js.Callback.once(() {
        if (runtime.lastError == null) {
          completer.complete(target);
        } else {
          completer.completeError(runtime.lastError);
        }
      });

      _chrome.debugger.attach(target._toJS(), requiredVersion, callback);

      return completer.future;
    });
  }

  /**
   * Detaches debugger from the given target.
   */
  Future<Debuggee> detach(Debuggee target, String requiredVersion) {
    return js.scoped(() {
      Completer completer = new Completer();

      js.Callback callback = new js.Callback.once(() {
        if (runtime.lastError == null) {
          completer.complete(target);
        } else {
          completer.completeError(runtime.lastError);
        }
      });

      _chrome.debugger.detach(target._toJS(), callback);

      return completer.future;
    });
  }

  /**
   * Sends given command to the debugging target.
   */
  Future<Map> sendCommand(Debuggee target, String method, [Map commandParams]) {
    return js.scoped(() {
      Completer completer = new Completer();

      if (commandParams == null) {
        commandParams = {};
      }

      js.Callback callback = new js.Callback.once(([var result]) {
        if (runtime.lastError == null) {
          if (result == null) {
            completer.complete(null);
          } else {
            completer.complete(
                new jsw.JsObjectToMapAdapter.fromProxy(result));
          }
        } else {
          completer.completeError(runtime.lastError);
        }
      });

      _chrome.debugger.sendCommand(
          target._toJS(), method, commandParams, callback);

      return completer.future;
    });
  }

  Stream<DebuggerEvent> get onEvent => _eventStream;

  Stream<DetachEvent> get onDetach => _detachStream;
}

class Debuggee {
  /**
   * The id of the tab which you intend to debug.
   */
  int tabId;

  /**
   * The id of the extension which you intend to debug. Attaching to an
   * extension background page is only possible when 'enable-silent-debugging'
   * flag is enabled on the target browser.
   */
  String extensionId;

  Debuggee.fromTabId(this.tabId);

  Debuggee.fromExtensionId(this.extensionId);

  Debuggee._fromProxy(js.Proxy proxy) {
    try { tabId = (proxy as dynamic).tabId; } catch (_) { }
    try { extensionId = (proxy as dynamic).extensionId; } catch (_) { }
  }

  js.Proxy _toJS() {
    Map m = {};

    if (tabId != null) {
      m['tabId'] = tabId;
    }

    if (extensionId != null) {
      m['extensionId'] = extensionId;
    }

    return js.map(m);
  }
}

/**
 * Fired when browser terminates debugging session for the tab. This happens
 * when either the tab is being closed or Chrome DevTools is being invoked for
 * the attached tab.
 */
class DetachEvent {
  Debuggee source;

  /**
   * One of:
   * * 'target_closed'
   * * 'canceled_by_user'
   * * 'replaced_with_devtools'
   */
  String reason;

  DetachEvent._(this.source, this.reason);
}

/**
 * Fired whenever debugging target issues instrumentation event.
 */
class DebuggerEvent {
  /**
   * The debuggee that generated this event.
   */
  Debuggee source;
  /**
   * Method name. Should be one of the notifications defined by the remote
   * debugging protocol.
   */
  String method;
  /**
   * JSON object with the response. Structure of the response varies depending
   * on the method and is defined by the remote debugging protocol.
   */
  Map params;

  DebuggerEvent._(this.source, this.method, [this.params]);
}
