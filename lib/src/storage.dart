library chrome.storage;

import 'dart:async';

import 'package:js/js.dart' as js;
import 'package:js/js_wrapping.dart' as jsw;

import 'common.dart';

final ChromeStorage storage = new ChromeStorage._();

// chrome.storage

class ChromeStorage {
  ChromeStorage._();

  final StorageArea local = new StorageArea._('local');
  final SyncStorageArea sync = new SyncStorageArea._('sync');
}

// TODO: implement chrome.storage.onChanged.addListener(
//         function(object changes, string areaName) {...});

class StorageArea {
  final String _type;

  StorageArea._(this._type);

  /**
   * The maximum amount (in bytes) of data that can be stored in local storage,
   * as measured by the JSON stringification of every value plus every key's
   * length. This value will be ignored if the extension has the
   * unlimitedStorage permission. Updates that would cause this limit to be
   * exceeded fail immediately and set runtime.lastError.
   */
  num get QUOTA_BYTES {
    return js.scoped(() {
      return chromeProxy.storage[_type].QUOTA_BYTES;
    });
  }

  /**
   * Gets one or more items from storage.
   */
  Future<Map<String, String>> getAll() => get(null);

  /**
   * Gets one or more items from storage.
   */
  Future<Map<String, dynamic>> get(List<String> keys) {
    ChromeCompleter completer = new ChromeCompleter.oneArg((items) {
      Map<String, dynamic> map = new Map<String, dynamic>();

      Map m = new jsw.JsObjectToMapAdapter.fromProxy(items);

      for (Object key in m.keys) {
        if (key is String) {
          map[key] = m[key];
        }
      }

      return map;
    });

    js.scoped(() {
      if (keys == null) {
        chromeProxy.storage[_type].get(null, completer.callback);
      } else {
        chromeProxy.storage[_type].get(js.array(keys), completer.callback);
      }
    });

    return completer.future;
  }

  /**
   * Sets multiple items.
   */
  Future set(Map<String, dynamic> items) {
    ChromeCompleter completer = new ChromeCompleter.noArgs();

    js.scoped(() {
      chromeProxy.storage[_type].set(js.map(items), completer.callback);
    });

    return completer.future;
  }

  /**
   * Removes one or more items from storage.
   */
  Future remove(List<String> keys) {
    ChromeCompleter completer = new ChromeCompleter.noArgs();

    js.scoped(() {
      chromeProxy.storage[_type].remove(js.array(keys), completer.callback);
    });

    return completer.future;
  }

  /**
   * Removes all items from storage.
   */
  Future clear() {
    ChromeCompleter completer = new ChromeCompleter.noArgs();

    js.scoped(() {
      chromeProxy.storage[_type].clear(completer.callback);
    });

    return completer.future;
  }

  String toString() {
    return "StorageArea ${_type}";
  }
}

class SyncStorageArea extends StorageArea {

  SyncStorageArea._(String type) : super._(type);

  num get MAX_ITEMS {
    return js.scoped(() {
      return chromeProxy.storage[_type].MAX_ITEMS;
    });
  }

  num get QUOTA_BYTES_PER_ITEM {
    return js.scoped(() {
      return chromeProxy.storage[_type].MAX_ITEMS;
    });
  }

  num get MAX_WRITE_OPERATIONS_PER_HOUR {
    return js.scoped(() {
      return chromeProxy.storage[_type].MAX_ITEMS;
    });
  }

  num get MAX_SUSTAINED_WRITE_OPERATIONS_PER_MINUTE {
    return js.scoped(() {
      return chromeProxy.storage[_type].MAX_ITEMS;
    });
  }

}
