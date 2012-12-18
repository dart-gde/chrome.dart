// http://developer.chrome.com/trunk/apps/runtime.html
library chrome_runtime;

import 'package:js/js.dart' as js;
import 'package:logging/logging.dart';

class Runtime {
  
  /// Properties
  
  /**
   * This will be defined during an API method callback if there was an error.
   */
  Future get lastError {
    Completer completer = new Completer();
    
    js.scoped(() {
      var chrome = js.context.chrome;
      var lastError = chrome.runtime.lastError;
      completer.complete({"message": lastError.message});
    });
    
    return completer.future;
  }
  
  /**
   * The ID of the extension/app.
   */
  Future<String> get id {
    Completer completer = new Completer();
    
    js.scoped(() {
      var chrome = js.context.chrome;
      String id = chrome.runtime.id;
      completer.complete(id);
    });
    
    return completer.future;
  }
  
  /// Methods
  
  /**
   * Retrieves the JavaScript 'window' object for the background page 
   * running inside the current extension. 
   * 
   * If the background page is an event page, 
   * the system will ensure it is loaded before calling the callback. 
   * If there is no background page, an error is set.
   */
  Future getBackgroundPage() { 
    Completer completer = new Completer();
    js.scoped(() {
      
      void callback(object) {
        // TODO(adam): log this value and figure out its proper runtime mapping. 
        completer.complete(object);
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
   * The [object] returned is a serialization of the full [manifest] file.
   */ 
  Future getManifest() {
    Completer completer = new Completer();
    
    js.scoped(() {
      var chrome = js.context.chrome;
      // TODO(adam): figure out what object is returned and 
      // turn into a primative dart object. 
      Object object = chrome.runtime.getManifest();
      completer.complete(object);
    });
    
    return completer.future;    
  }
  
  /**
   * Converts a relative path within an app/extension 
   * install directory to a fully-qualified URL.
   * 
   * A [path] to a resource within an app/extension 
   * expressed relative to its install directory.
   */
  Future<String> getURL(String path) {
    Completer completer = new Completer();
    
    js.scoped(() {
      var chrome = js.context.chrome;
      String full_path = chrome.runtime.getURL(path);
      completer.complete(full_path);
    });
    
    return completer.future;
  }
  
  /**
   * Reloads the app or extension.
   */
  void reload() {
    js.scoped(() {
      var chrome = js.context.chrome;
      chrome.runtime.reload();
    });
  }
  
  /**
   * Requests an update check for this app/extension.
   */
  Future requestUpdateCheck() {
    Completer completer = new Completer();
    js.scoped(() {
      void callback(status, details) {
        // TODO(adam): break out into native dart objects. 
        completer.complete({"status": status, "details": details});
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
  onStartup(Function listener) {
    // TODO(adam): typedef the listener
    js.scoped(() {
      void event() {
        if (listener!=null) {
          listener();
        }
      };
      
      js.context.onStartupEvent = new js.Callback.once(event);
      var chrome = js.context.chrome;
      chrome.runtime.onStartup.addListener(js.context.onStartupEvent);
    });
  }
  
  /**
   * Fired when the extension is first installed, 
   * when the extension is updated to a new version, 
   * and when Chrome is updated to a new version.
   */
  onInstalled(Function listener) {
    // TODO(adam): typedef the listener
    js.scoped(() {
      void event(details) {
        if (listener!=null) {
          listener({"details": details});
        }
      };
      
      js.context.onInstalledEvent = new js.Callback.once(event);
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
  onSuspend(Function listener) {
    // TODO(adam): typedef the listener
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
  onSuspendCanceled(Function listener) {
    // TODO(adam): typedef the listener
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
   */
  onUpdateAvailable(Function listener) {
    // TODO(adam): typedef the listener
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
