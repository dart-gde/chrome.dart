/* This file has been generated - do not edit */

library chrome.system;

import '../src/common.dart';

final ChromeSystem system = new ChromeSystem._();

class ChromeSystem {
  ChromeSystem._();

  /**
   * Accessor for the `chrome.system.cpu` namespace.
   */
  final ChromeSystemCpu cpu = new ChromeSystemCpu._();

  /**
   * Accessor for the `chrome.system.memory` namespace.
   */
  final ChromeSystemMemory memory = new ChromeSystemMemory._();

  /**
   * Accessor for the `chrome.system.storage` namespace.
   */
  final ChromeSystemStorage storage = new ChromeSystemStorage._();
}

/**
 * Use the `system.cpu` API to query CPU metadata.
 */
class ChromeSystemCpu extends ChromeApi {
  static final JsObject _system_cpu = chrome['system']['cpu'];

  ChromeSystemCpu._();

  bool get available => _system_cpu != null;

  /**
   * Queries basic CPU information of the system.
   */
  Future<CpuInfo> getInfo() {
    if (_system_cpu == null) _throwNotAvailable();

    var completer = new ChromeCompleter<CpuInfo>.oneArg(_createCpuInfo);
    _system_cpu.callMethod('getInfo', [completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.system.cpu' is not available");
  }
}

class CpuInfo extends ChromeObject {
  CpuInfo({int numOfProcessors, String archName, String modelName}) {
    if (numOfProcessors != null) this.numOfProcessors = numOfProcessors;
    if (archName != null) this.archName = archName;
    if (modelName != null) this.modelName = modelName;
  }
  CpuInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get numOfProcessors => jsProxy['numOfProcessors'];
  set numOfProcessors(int value) => jsProxy['numOfProcessors'] = value;

  String get archName => jsProxy['archName'];
  set archName(String value) => jsProxy['archName'] = value;

  String get modelName => jsProxy['modelName'];
  set modelName(String value) => jsProxy['modelName'] = value;
}

CpuInfo _createCpuInfo(JsObject jsProxy) => jsProxy == null ? null : new CpuInfo.fromProxy(jsProxy);

/**
 * The `chrome.system.memory` API.
 */
class ChromeSystemMemory extends ChromeApi {
  static final JsObject _system_memory = chrome['system']['memory'];

  ChromeSystemMemory._();

  bool get available => _system_memory != null;

  /**
   * Get physical memory information.
   */
  Future<MemoryInfo> getInfo() {
    if (_system_memory == null) _throwNotAvailable();

    var completer = new ChromeCompleter<MemoryInfo>.oneArg(_createMemoryInfo);
    _system_memory.callMethod('getInfo', [completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.system.memory' is not available");
  }
}

class MemoryInfo extends ChromeObject {
  MemoryInfo({num capacity, num availableCapacity}) {
    if (capacity != null) this.capacity = capacity;
    if (availableCapacity != null) this.availableCapacity = availableCapacity;
  }
  MemoryInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  num get capacity => jsProxy['capacity'];
  set capacity(num value) => jsProxy['capacity'] = jsify(value);

  num get availableCapacity => jsProxy['availableCapacity'];
  set availableCapacity(num value) => jsProxy['availableCapacity'] = jsify(value);
}

MemoryInfo _createMemoryInfo(JsObject jsProxy) => jsProxy == null ? null : new MemoryInfo.fromProxy(jsProxy);

/**
 * Use the `chrome.system.storage` API to query storage device information and
 * be notified when a removable storage device is attached and detached.
 */
class ChromeSystemStorage extends ChromeApi {
  static final JsObject _system_storage = chrome['system']['storage'];

  ChromeSystemStorage._();

  bool get available => _system_storage != null;

  /**
   * Get the storage information from the system. The argument passed to the
   * callback is an array of StorageUnitInfo objects.
   */
  Future<List<StorageUnitInfo>> getInfo() {
    if (_system_storage == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<StorageUnitInfo>>.oneArg((e) => listify(e, _createStorageUnitInfo));
    _system_storage.callMethod('getInfo', [completer.callback]);
    return completer.future;
  }

  /**
   * Ejects a removable storage device.
   */
  Future<EjectDeviceResultCode> ejectDevice(String id) {
    if (_system_storage == null) _throwNotAvailable();

    var completer = new ChromeCompleter<EjectDeviceResultCode>.oneArg(_createEjectDeviceResultCode);
    _system_storage.callMethod('ejectDevice', [id, completer.callback]);
    return completer.future;
  }

  /**
   * Get the available capacity of a specified [id] storage device. The [id] is
   * the transient device ID from StorageUnitInfo.
   */
  Future<StorageAvailableCapacityInfo> getAvailableCapacity(String id) {
    if (_system_storage == null) _throwNotAvailable();

    var completer = new ChromeCompleter<StorageAvailableCapacityInfo>.oneArg(_createStorageAvailableCapacityInfo);
    _system_storage.callMethod('getAvailableCapacity', [id, completer.callback]);
    return completer.future;
  }

  Stream<StorageUnitInfo> get onAttached => _onAttached.stream;

  final ChromeStreamController<StorageUnitInfo> _onAttached =
      new ChromeStreamController<StorageUnitInfo>.oneArg(_system_storage, 'onAttached', _createStorageUnitInfo);

  Stream<String> get onDetached => _onDetached.stream;

  final ChromeStreamController<String> _onDetached =
      new ChromeStreamController<String>.oneArg(_system_storage, 'onDetached', selfConverter);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.system.storage' is not available");
  }
}

class StorageUnitType extends ChromeEnum {
  static const StorageUnitType FIXED = const StorageUnitType._('fixed');
  static const StorageUnitType REMOVABLE = const StorageUnitType._('removable');
  static const StorageUnitType UNKNOWN = const StorageUnitType._('unknown');

  static const List<StorageUnitType> VALUES = const[FIXED, REMOVABLE, UNKNOWN];

  const StorageUnitType._(String str): super(str);
}

class EjectDeviceResultCode extends ChromeEnum {
  static const EjectDeviceResultCode SUCCESS = const EjectDeviceResultCode._('success');
  static const EjectDeviceResultCode IN_USE = const EjectDeviceResultCode._('in_use');
  static const EjectDeviceResultCode NO_SUCH_DEVICE = const EjectDeviceResultCode._('no_such_device');
  static const EjectDeviceResultCode FAILURE = const EjectDeviceResultCode._('failure');

  static const List<EjectDeviceResultCode> VALUES = const[SUCCESS, IN_USE, NO_SUCH_DEVICE, FAILURE];

  const EjectDeviceResultCode._(String str): super(str);
}

class StorageUnitInfo extends ChromeObject {
  StorageUnitInfo({String id, String name, StorageUnitType type, num capacity}) {
    if (id != null) this.id = id;
    if (name != null) this.name = name;
    if (type != null) this.type = type;
    if (capacity != null) this.capacity = capacity;
  }
  StorageUnitInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  StorageUnitType get type => _createStorageUnitType(jsProxy['type']);
  set type(StorageUnitType value) => jsProxy['type'] = jsify(value);

  num get capacity => jsProxy['capacity'];
  set capacity(num value) => jsProxy['capacity'] = jsify(value);
}

class StorageAvailableCapacityInfo extends ChromeObject {
  StorageAvailableCapacityInfo({String id, num availableCapacity}) {
    if (id != null) this.id = id;
    if (availableCapacity != null) this.availableCapacity = availableCapacity;
  }
  StorageAvailableCapacityInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  num get availableCapacity => jsProxy['availableCapacity'];
  set availableCapacity(num value) => jsProxy['availableCapacity'] = jsify(value);
}

StorageUnitInfo _createStorageUnitInfo(JsObject jsProxy) => jsProxy == null ? null : new StorageUnitInfo.fromProxy(jsProxy);
EjectDeviceResultCode _createEjectDeviceResultCode(String value) => EjectDeviceResultCode.VALUES.singleWhere((ChromeEnum e) => e.value == value);
StorageAvailableCapacityInfo _createStorageAvailableCapacityInfo(JsObject jsProxy) => jsProxy == null ? null : new StorageAvailableCapacityInfo.fromProxy(jsProxy);
StorageUnitType _createStorageUnitType(String value) => StorageUnitType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
