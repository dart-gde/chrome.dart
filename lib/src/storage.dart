library chrome_storage;

import 'dart:async';

import 'package:js/js.dart' as js;
import 'package:logging/logging.dart';

import 'common.dart';

// chrome.storage

class ChromeStorage {
  final StorageArea local = new StorageArea('local');
  final SyncStorageArea sync = new SyncStorageArea('sync');
}

// TODO: implement chrome.storage.onChanged.addListener(
//         function(object changes, string areaName) {...});

class StorageArea {
  String _type;

  StorageArea(this._type);

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
  Future<Map<String, String>> getAll() {
    return get(null);
  }

  /**
   * Gets one or more items from storage.
   */
  Future<Map<String, String>> get(List<String> keys) {
    Completer completer = new Completer();

    js.scoped(() {
      js.Callback callback = new js.Callback.once((js.Proxy items) {
        String error = lastError;

        if (lastError == null) {
          Map<String, String> map = null;

          if (keys != null) {
            map = new Map<String, String>();

            for (String key in keys) {
              map[key] = items[key];
            }
          }

          completer.complete(map);
        } else {
          completer.completeError(error);
        }
      });

      if (keys == null) {
        chromeProxy.storage[_type].get(null, callback);
      } else {
        chromeProxy.storage[_type].get(js.array(keys), callback);
      }
    });

    return completer.future;
  }

  /**
   * Sets multiple items.
   */
  Future<StorageArea> set(Map<String, String> items) {
    Completer completer = new Completer();

    js.scoped(() {
      js.Callback callback = new js.Callback.once(() {
        String error = lastError;

        if (lastError == null) {
          completer.complete(this);
        } else {
          completer.completeError(error);
        }
      });

      chromeProxy.storage[_type].set(js.map(items), callback);
    });

    return completer.future;
  }

  /**
   * Removes one or more items from storage.
   */
  Future<StorageArea> remove(List<String> keys) {
    Completer completer = new Completer();

    js.scoped(() {
      js.Callback callback = new js.Callback.once(() {
        String error = lastError;

        if (lastError == null) {
          completer.complete(this);
        } else {
          completer.completeError(error);
        }
      });

      chromeProxy.storage[_type].remove(js.array(keys), callback);
    });

    return completer.future;
  }

  /**
   * Removes all items from storage.
   */
  Future<StorageArea> clear() {
    Completer completer = new Completer();

    js.scoped(() {
      js.Callback callback = new js.Callback.once(() {
        String error = lastError;

        if (lastError == null) {
          completer.complete(this);
        } else {
          completer.completeError(error);
        }
      });

      chromeProxy.storage[_type].clear(callback);
    });

    return completer.future;
  }

  String toString() {
    return "StorageArea ${_type}";
  }
}

class SyncStorageArea extends StorageArea {

  SyncStorageArea(String type) : super(type);

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
