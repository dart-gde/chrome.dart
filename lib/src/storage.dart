library chrome.storage;

import 'dart:async';

import 'package:js/js.dart' as js;

import 'common.dart';

final ChromeStorage storage = new ChromeStorage();

// chrome.storage

class ChromeStorage {
  final StorageArea local = new StorageArea('local');
  final SyncStorageArea sync = new SyncStorageArea('sync');
}

// TODO: implement chrome.storage.onChanged.addListener(
//         function(object changes, string areaName) {...});

class StorageArea {
  final String _type;

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
  Future<Map<String, String>> getAll() => get(null);

  /**
   * Gets one or more items from storage.
   */
  Future<Map<String, String>> get(List<String> keys) {
    ChromeCompleter completer = new ChromeCompleter.oneArg((items) {
      Map<String, String> map = null;

      if (keys != null) {
        map = new Map<String, String>();

        for (String key in keys) {
          map[key] = items[key];
        }
      }
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
  Future set(Map<String, String> items) {
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
