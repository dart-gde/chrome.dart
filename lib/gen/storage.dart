/* This file has been generated from storage.json - do not edit */

/**
 * Use the `chrome.storage` API to store, retrieve, and track changes to user
 * data.
 */
library chrome.storage;

import '../src/common.dart';

/**
 * Accessor for the `chrome.storage` namespace.
 */
final ChromeStorage storage = new ChromeStorage._();

class ChromeStorage extends ChromeApi {
  static final JsObject _storage = chrome['storage'];

  ChromeStorage._();

  bool get available => _storage != null;

  /**
   * Items in the `sync` storage area are synced using Chrome Sync.
   */
  SyncStorageArea get sync => _createSyncStorageArea(_storage['sync']);

  /**
   * Items in the `local` storage area are local to each machine.
   */
  LocalStorageArea get local => _createLocalStorageArea(_storage['local']);

  /**
   * Fired when one or more items change.
   */
  Stream<StorageOnChangedEvent> get onChanged => _onChanged.stream;

  final ChromeStreamController<StorageOnChangedEvent> _onChanged =
      new ChromeStreamController<StorageOnChangedEvent>.twoArgs(_storage, 'onChanged', _createOnChangedEvent);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.storage' is not available");
  }
}

/**
 * Fired when one or more items change.
 */
class StorageOnChangedEvent {
  /**
   * Object mapping each key that changed to its corresponding [StorageChange]
   * for that item.
   */
  final Map changes;

  /**
   * The name of the storage area (`sync` or `local`) the changes are for.
   */
  final String areaName;

  StorageOnChangedEvent(this.changes, this.areaName);
}

class SyncStorageArea extends StorageArea {
  SyncStorageArea();
  SyncStorageArea.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The maximum total amount (in bytes) of data that can be stored in sync
   * storage, as measured by the JSON stringification of every value plus every
   * key's length. Updates that would cause this limit to be exceeded fail
   * immediately and set [runtime.lastError.]
   */
  int get QUOTA_BYTES => jsProxy['QUOTA_BYTES'];

  /**
   * The maximum size (in bytes) of each individual item in sync storage, as
   * measured by the JSON stringification of its value plus its key length.
   * Updates containing items larger than this limit will fail immediately and
   * set [runtime.lastError.]
   */
  int get QUOTA_BYTES_PER_ITEM => jsProxy['QUOTA_BYTES_PER_ITEM'];

  /**
   * The maximum number of items that can be stored in sync storage. Updates
   * that would cause this limit to be exceeded will fail immediately and set
   * [runtime.lastError.]
   */
  int get MAX_ITEMS => jsProxy['MAX_ITEMS'];

  /**
   * The maximum number of `set`, `remove`, or `clear` operations that can be
   * performed each hour. Updates that would cause this limit to be exceeded
   * fail immediately and set [runtime.lastError.]
   */
  int get MAX_WRITE_OPERATIONS_PER_HOUR => jsProxy['MAX_WRITE_OPERATIONS_PER_HOUR'];

  /**
   * The maximum number of `set`, `remove`, or `clear` operations that can be
   * performed each minute, sustained over 10 minutes. Updates that would cause
   * this limit to be exceeded fail immediately and set [runtime.lastError.]
   */
  int get MAX_SUSTAINED_WRITE_OPERATIONS_PER_MINUTE => jsProxy['MAX_SUSTAINED_WRITE_OPERATIONS_PER_MINUTE'];
}

class LocalStorageArea extends StorageArea {
  LocalStorageArea();
  LocalStorageArea.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The maximum amount (in bytes) of data that can be stored in local storage,
   * as measured by the JSON stringification of every value plus every key's
   * length. This value will be ignored if the extension has the
   * `unlimitedStorage` permission. Updates that would cause this limit to be
   * exceeded fail immediately and set [runtime.lastError.]
   */
  int get QUOTA_BYTES => jsProxy['QUOTA_BYTES'];
}

class StorageChange extends ChromeObject {
  StorageChange({var oldValue, var newValue}) {
    if (oldValue != null) this.oldValue = oldValue;
    if (newValue != null) this.newValue = newValue;
  }
  StorageChange.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The old value of the item, if there was an old value.
   */
  dynamic get oldValue => jsProxy['oldValue'];
  set oldValue(var value) => jsProxy['oldValue'] = jsify(value);

  /**
   * The new value of the item, if there is a new value.
   */
  dynamic get newValue => jsProxy['newValue'];
  set newValue(var value) => jsProxy['newValue'] = jsify(value);
}

class StorageArea extends ChromeObject {
  StorageArea();
  StorageArea.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Gets one or more items from storage.
   * 
   * [keys] A single key to get, list of keys to get, or a dictionary specifying
   * default values (see description of the object).  An empty list or object
   * will return an empty result object.  Pass in `null` to get the entire
   * contents of storage.
   * 
   * Returns:
   * Object with items in their key-value mappings.
   */
  Future<Map<String, dynamic>> get([dynamic keys]) {
    var completer = new ChromeCompleter<Map<String, dynamic>>.oneArg(mapify);
    jsProxy.callMethod('get', [jsify(keys), completer.callback]);
    return completer.future;
  }

  /**
   * Gets the amount of space (in bytes) being used by one or more items.
   * 
   * [keys] A single key or list of keys to get the total usage for. An empty
   * list will return 0. Pass in `null` to get the total usage of all of
   * storage.
   * 
   * Returns:
   * Amount of space being used in storage, in bytes.
   */
  Future<int> getBytesInUse([dynamic keys]) {
    var completer = new ChromeCompleter<int>.oneArg();
    jsProxy.callMethod('getBytesInUse', [jsify(keys), completer.callback]);
    return completer.future;
  }

  /**
   * Sets multiple items.
   * 
   * [items] An object which gives each key/value pair to update storage with.
   * Any other key/value pairs in storage will not be affected.
   * 
   * Primitive values such as numbers will serialize as expected. Values with a
   * `typeof` `"object"` and `"function"` will typically serialize to `{}`, with
   * the exception of `Array` (serializes as expected), `Date`, and `Regex`
   * (serialize using their `String` representation).
   */
  Future set(Map<String, dynamic> items) {
    var completer = new ChromeCompleter.noArgs();
    jsProxy.callMethod('set', [jsify(items), completer.callback]);
    return completer.future;
  }

  /**
   * Removes one or more items from storage.
   * 
   * [keys] A single key or a list of keys for items to remove.
   */
  Future remove(dynamic keys) {
    var completer = new ChromeCompleter.noArgs();
    jsProxy.callMethod('remove', [jsify(keys), completer.callback]);
    return completer.future;
  }

  /**
   * Removes all items from storage.
   */
  Future clear() {
    var completer = new ChromeCompleter.noArgs();
    jsProxy.callMethod('clear', [completer.callback]);
    return completer.future;
  }
}

SyncStorageArea _createSyncStorageArea(JsObject jsProxy) => jsProxy == null ? null : new SyncStorageArea.fromProxy(jsProxy);
LocalStorageArea _createLocalStorageArea(JsObject jsProxy) => jsProxy == null ? null : new LocalStorageArea.fromProxy(jsProxy);
StorageOnChangedEvent _createOnChangedEvent(JsObject changes, String areaName) =>
    new StorageOnChangedEvent(mapify(changes), areaName);
