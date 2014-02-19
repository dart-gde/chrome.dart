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
   * Accessor for the `chrome.system.display` namespace.
   */
  final ChromeSystemDisplay display = new ChromeSystemDisplay._();

  /**
   * Accessor for the `chrome.system.memory` namespace.
   */
  final ChromeSystemMemory memory = new ChromeSystemMemory._();

  /**
   * Accessor for the `chrome.system.network` namespace.
   */
  final ChromeSystemNetwork network = new ChromeSystemNetwork._();

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
 * Use the `system.display` API to query display metadata.
 */
class ChromeSystemDisplay extends ChromeApi {
  static final JsObject _system_display = chrome['system']['display'];

  ChromeSystemDisplay._();

  bool get available => _system_display != null;

  /**
   * Get the information of all attached display devices.
   */
  Future<List<DisplayUnitInfo>> getInfo() {
    if (_system_display == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<DisplayUnitInfo>>.oneArg((e) => listify(e, _createDisplayUnitInfo));
    _system_display.callMethod('getInfo', [completer.callback]);
    return completer.future;
  }

  /**
   * Updates the properties for the display specified by [id], according to the
   * information provided in [info]. On failure, [runtime.lastError] will be
   * set.
   * [id]: The display's unique identifier.
   * [info]: The information about display properties that should be changed. A
   * property will be changed only if a new value for it is specified in [info].
   * [callback]: Empty function called when the function finishes. To find out
   * whether the function succeeded, [runtime.lastError] should be queried.
   */
  Future setDisplayProperties(String id, DisplayProperties info) {
    if (_system_display == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _system_display.callMethod('setDisplayProperties', [id, jsify(info), completer.callback]);
    return completer.future;
  }

  Stream get onDisplayChanged => _onDisplayChanged.stream;

  final ChromeStreamController _onDisplayChanged =
      new ChromeStreamController.noArgs(_system_display, 'onDisplayChanged');

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.system.display' is not available");
  }
}

class Insets extends ChromeObject {
  Insets({int left, int top, int right, int bottom}) {
    if (left != null) this.left = left;
    if (top != null) this.top = top;
    if (right != null) this.right = right;
    if (bottom != null) this.bottom = bottom;
  }
  Insets.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get left => jsProxy['left'];
  set left(int value) => jsProxy['left'] = value;

  int get top => jsProxy['top'];
  set top(int value) => jsProxy['top'] = value;

  int get right => jsProxy['right'];
  set right(int value) => jsProxy['right'] = value;

  int get bottom => jsProxy['bottom'];
  set bottom(int value) => jsProxy['bottom'] = value;
}

class DisplayUnitInfo extends ChromeObject {
  DisplayUnitInfo({String id, String name, String mirroringSourceId, bool isPrimary, bool isInternal, bool isEnabled, num dpiX, num dpiY, int rotation, Bounds bounds, Insets overscan, Bounds workArea}) {
    if (id != null) this.id = id;
    if (name != null) this.name = name;
    if (mirroringSourceId != null) this.mirroringSourceId = mirroringSourceId;
    if (isPrimary != null) this.isPrimary = isPrimary;
    if (isInternal != null) this.isInternal = isInternal;
    if (isEnabled != null) this.isEnabled = isEnabled;
    if (dpiX != null) this.dpiX = dpiX;
    if (dpiY != null) this.dpiY = dpiY;
    if (rotation != null) this.rotation = rotation;
    if (bounds != null) this.bounds = bounds;
    if (overscan != null) this.overscan = overscan;
    if (workArea != null) this.workArea = workArea;
  }
  DisplayUnitInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  String get mirroringSourceId => jsProxy['mirroringSourceId'];
  set mirroringSourceId(String value) => jsProxy['mirroringSourceId'] = value;

  bool get isPrimary => jsProxy['isPrimary'];
  set isPrimary(bool value) => jsProxy['isPrimary'] = value;

  bool get isInternal => jsProxy['isInternal'];
  set isInternal(bool value) => jsProxy['isInternal'] = value;

  bool get isEnabled => jsProxy['isEnabled'];
  set isEnabled(bool value) => jsProxy['isEnabled'] = value;

  num get dpiX => jsProxy['dpiX'];
  set dpiX(num value) => jsProxy['dpiX'] = jsify(value);

  num get dpiY => jsProxy['dpiY'];
  set dpiY(num value) => jsProxy['dpiY'] = jsify(value);

  int get rotation => jsProxy['rotation'];
  set rotation(int value) => jsProxy['rotation'] = value;

  Bounds get bounds => _createBounds(jsProxy['bounds']);
  set bounds(Bounds value) => jsProxy['bounds'] = jsify(value);

  Insets get overscan => _createInsets(jsProxy['overscan']);
  set overscan(Insets value) => jsProxy['overscan'] = jsify(value);

  Bounds get workArea => _createBounds(jsProxy['workArea']);
  set workArea(Bounds value) => jsProxy['workArea'] = jsify(value);
}

class DisplayProperties extends ChromeObject {
  DisplayProperties({String mirroringSourceId, bool isPrimary, Insets overscan, int rotation, int boundsOriginX, int boundsOriginY}) {
    if (mirroringSourceId != null) this.mirroringSourceId = mirroringSourceId;
    if (isPrimary != null) this.isPrimary = isPrimary;
    if (overscan != null) this.overscan = overscan;
    if (rotation != null) this.rotation = rotation;
    if (boundsOriginX != null) this.boundsOriginX = boundsOriginX;
    if (boundsOriginY != null) this.boundsOriginY = boundsOriginY;
  }
  DisplayProperties.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get mirroringSourceId => jsProxy['mirroringSourceId'];
  set mirroringSourceId(String value) => jsProxy['mirroringSourceId'] = value;

  bool get isPrimary => jsProxy['isPrimary'];
  set isPrimary(bool value) => jsProxy['isPrimary'] = value;

  Insets get overscan => _createInsets(jsProxy['overscan']);
  set overscan(Insets value) => jsProxy['overscan'] = jsify(value);

  int get rotation => jsProxy['rotation'];
  set rotation(int value) => jsProxy['rotation'] = value;

  int get boundsOriginX => jsProxy['boundsOriginX'];
  set boundsOriginX(int value) => jsProxy['boundsOriginX'] = value;

  int get boundsOriginY => jsProxy['boundsOriginY'];
  set boundsOriginY(int value) => jsProxy['boundsOriginY'] = value;
}

DisplayUnitInfo _createDisplayUnitInfo(JsObject jsProxy) => jsProxy == null ? null : new DisplayUnitInfo.fromProxy(jsProxy);
Bounds _createBounds(JsObject jsProxy) => jsProxy == null ? null : new Bounds.fromProxy(jsProxy);
Insets _createInsets(JsObject jsProxy) => jsProxy == null ? null : new Insets.fromProxy(jsProxy);

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
 * Use the `chrome.system.network` API.
 */
class ChromeSystemNetwork extends ChromeApi {
  static final JsObject _system_network = chrome['system']['network'];

  ChromeSystemNetwork._();

  bool get available => _system_network != null;

  /**
   * Retrieves information about local adapters on this system.
   * [callback]: Called when local adapter information is available.
   * 
   * Returns:
   * Callback from the `getNetworkInterfaces` method.
   * [networkInterfaces]: Array of object containing network interfaces
   * information.
   */
  Future<List<NetworkInterface>> getNetworkInterfaces() {
    if (_system_network == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<NetworkInterface>>.oneArg((e) => listify(e, _createNetworkInterface));
    _system_network.callMethod('getNetworkInterfaces', [completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.system.network' is not available");
  }
}

class NetworkInterface extends ChromeObject {
  NetworkInterface({String name, String address, int prefixLength}) {
    if (name != null) this.name = name;
    if (address != null) this.address = address;
    if (prefixLength != null) this.prefixLength = prefixLength;
  }
  NetworkInterface.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  String get address => jsProxy['address'];
  set address(String value) => jsProxy['address'] = value;

  int get prefixLength => jsProxy['prefixLength'];
  set prefixLength(int value) => jsProxy['prefixLength'] = value;
}

NetworkInterface _createNetworkInterface(JsObject jsProxy) => jsProxy == null ? null : new NetworkInterface.fromProxy(jsProxy);

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
