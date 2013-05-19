// http://developer.chrome.com/trunk/apps/runtime.html
library chrome_runtime;

import 'dart:async';
import 'dart:json' as JSON;

import 'package:js/js.dart' as js;
import 'package:logging/logging.dart';

typedef void onStartupCallback();
typedef void onInstalledCallback(Map details); // TODO(adam): replace map with structured object.
typedef void onSuspendCallback();
typedef void onSuspendCanceledCallback();
typedef void onUpdateAvailableCallback(Map details); // TODO(adam): replace map with structured object.

/**
 * Created from [Runtime].[lastError] checks.
 */
class RuntimeError {
  /**
   * Details about the error which occurred.
   */
  String message;
  RuntimeError([this.message = ""]);
}

class Runtime {

  /**
   * This will be defined during an API method callback if there was an error.
   */
  static RuntimeError get lastError {
    return js.scoped(() {
      var chrome = js.context.chrome;
      var lastError = null;

      try {
        lastError = chrome.runtime.lastError;
      } on NoSuchMethodError catch (e, trace) {
        // No error was in the chrome.runtime context.
        return new RuntimeError();
      }

      // This null check might not be needed.
      if (lastError == null) {
        return null;
      } else {
        return new RuntimeError(lastError.message);
      }
    });
  }

  /**
   * The ID of the extension/app.
   */
  static String get id {
    return js.scoped(() {
      return js.context.chrome.runtime.id;
    });
  }

  /// Methods

  /**
   * Retrieves the js.Proxy [window] object for the background page
   * running inside the current extension.
   *
   * If the background page is an event page,
   * the system will ensure it is loaded before calling the callback.
   * If there is no background page, an error is set.
   */
  static Future<js.Proxy> getBackgroundPage() {
    var completer = new Completer();

    js.scoped(() {
      /**
       * callback returns a proxy to the window object.
       */
      void callback(js.Proxy window) {
        var le = lastError;
        if (le.message.isEmpty) {
          // XXX: This is a hack, remove or dont send the entire window object
          // as a js.Proxy to the completer.
          js.retain(window);
          completer.complete(window);
        } else {
          completer.completeException(le);
        }
      };

      js.context.getBackgroundPageCallback = new js.Callback.once(callback);
      var chrome = js.context.chrome;
      chrome.runtime.getBackgroundPage(js.context.getBackgroundPageCallback);
    });

    return completer.future;
  }

  /**
   * Returns details about the app or extension from the manifest.
   *
   * The [Map] returned is a de-serialization of the full [manifest] file.
   */
  static Map getManifest() {
    return js.scoped(() {
      var chrome = js.context.chrome;
      return JSON.parse(js.context.JSON.stringify(chrome.runtime.getManifest()));
    });
  }

  /**
   * Converts a relative path within an app/extension
   * install directory to a fully-qualified URL.
   *
   * A [path] to a resource within an app/extension
   * expressed relative to its install directory.
   */
  static String getURL(String path) {
    return js.scoped(() {
      return js.context.chrome.runtime.getURL(path);
    });
  }

  /**
   * Reloads the app or extension.
   */
  static void reload() {
    js.scoped(() {
      js.context.chrome.runtime.reload();
    });
  }

  /**
   * Requests an update check for this app/extension.
   *
   * Completed Map contains key 'status' with the following enumeration of
   * strings "throttled", "no_update", "update_available".
   *
   * Completed Map will also contain key 'details' which could be Map or null.
   * null object is returned if no details are provided. In the case of details
   * available, a Map with 'version' key, value being the version of the
   * available update.
   */
  static Future<Map> requestUpdateCheck() {
    var completer = new Completer();

    js.scoped(() {
      void callback(status, [details]) {
        var le = lastError;
        if (le.message.isEmpty) {
          var d = JSON.parse(js.context.JSON.stringify(details));
          completer.complete({"status": status, "details": d});
        } else {
          completer.completeException(le);
        }
      };
      js.context.requestUpdateCheckCallback = new js.Callback.once(callback);
      var chrome = js.context.chrome;
      chrome.runtime.requestUpdateCheck(js.context.requestUpdateCheckCallback);
    });

    return completer.future;
  }

  /// Events

  /**
   * Fired when the browser first starts up.
   */
  static void onStartup(onStartupCallback listener) {
    // TODO(adam): typedef the listener
    js.scoped(() {
      void event() {
        if (listener!=null) {
          listener();
        }
      };

      js.context.onStartupEvent = new js.Callback.once(event);
      js.retain(js.context.onStartupEvent);
      var chrome = js.context.chrome;
      chrome.runtime.onStartup.addListener(js.context.onStartupEvent);
    });
  }

  /**
   * Fired when the extension is first installed,
   * when the extension is updated to a new version,
   * and when Chrome is updated to a new version.
   *
   * [details] Map passed to the [listener] will contain keys
   * 'reason' and 'previousVersion'.
   *
   * 'reason' is an enumerated string of "install", "update", "chrome_update".
   *
   * 'previousVersion' is optionally passed. Indicates the previous version
   * of the extension, which has just been updated. This is present only if
   * 'reason' is 'update'.
   */
  static void onInstalled(onInstalledCallback listener) {
    js.scoped(() {
      void event(details) {
        if (listener!=null) {
          var d = JSON.parse(js.context.JSON.stringify(details));
          listener({"details": d});
        }
      };

      js.context.onInstalledEvent = new js.Callback.once(event);
      js.retain(js.context.onInstalledEvent);
      var chrome = js.context.chrome;
      chrome.runtime.onInstalled.addListener(js.context.onInstalledEvent);
    });
  }

  /**
   * Sent to the event page just before it is unloaded.
   *
   * This gives the extension opportunity to do some clean up.
   * Note that since the page is unloading, any asynchronous
   * operations started while handling this event are not guaranteed
   * to complete. If more activity for the event page occurs
   * before it gets unloaded the onSuspendCanceled event will be
   * sent and the page won't be unloaded.
   */
  static void onSuspend(onSuspendCallback listener) {
    js.scoped(() {
      void event() {
        if (listener!=null) {
          listener();
        }
      };

      js.context.onSuspendEvent = new js.Callback.many(event);
      js.context.retain(js.context.onSuspendEvent);
      var chrome = js.context.chrome;
      chrome.runtime.onSuspend.addListener(js.context.onSuspendEvent);
    });
  }

  /**
   * Sent after onSuspend() to indicate that the app won't be unloaded after all.
   */
  static void onSuspendCanceled(onSuspendCanceledCallback listener) {
    js.scoped(() {
      void event() {
        if (listener!=null) {
          listener();
        }
      };

      js.context.onSuspendCanceledEvent = new js.Callback.many(event);
      js.context.retain(js.context.onSuspendCanceledEvent);
      var chrome = js.context.chrome;
      chrome.runtime.onSuspendCanceled.addListener(js.context.onSuspendCanceledEvent);
    });
  }

  /**
   * Fired when an update is available.
   *
   * Isn't installed immediately because the app is currently running.
   * If you do nothing, the update will be installed the next time
   * the background page gets unloaded, if you want it to be installed
   * sooner you can explicitly call chrome.runtime.reload().
   *
   * [details] Map passed to the [listener] will contain keys 'version'.
   * 'version' is the version number of the available update.
   */
  static void onUpdateAvailable(onUpdateAvailableCallback listener) {
    js.scoped(() {
      void event(details) {
        if (listener!=null) {
          listener({"details": details});
        }
      };

      js.context.onUpdateAvailableEvent = new js.Callback.many(event);
      js.context.retain(js.context.onUpdateAvailableEvent);
      var chrome = js.context.chrome;
      chrome.runtime.onUpdateAvailable.addListener(js.context.onUpdateAvailableEvent);
    });
  }

}
