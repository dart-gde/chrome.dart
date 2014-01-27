/* This file has been generated from usb.idl - do not edit */

/**
 * Use the `chrome.usb` API to interact with connected USB devices. This API
 * provides access to USB operations from within the context of an app. Using
 * this API, apps can function as drivers for hardware devices.
 */
library chrome.usb;

import '../src/common.dart';

/**
 * Accessor for the `chrome.usb` namespace.
 */
final ChromeUsb usb = new ChromeUsb._();

class ChromeUsb extends ChromeApi {
  static final JsObject _usb = chrome['usb'];

  ChromeUsb._();

  bool get available => _usb != null;

  /**
   * Lists USB devices specified by vendorId/productId/interfaceId tuple.
   * [options]: The properties to search for on target devices.
   * [callback]: Invoked with a list of [Device]s on complete.
   */
  Future<List<Device>> getDevices(EnumerateDevicesOptions options) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<Device>>.oneArg((e) => listify(e, _createDevice));
    _usb.callMethod('getDevices', [jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * This method is ChromeOS specific. Calling this method on other platforms
   * will fail. Requests access from the permission broker to an OS claimed
   * device if the given interface on the device is not claimed.
   * 
   * [device]: The device to request access to.
   * [interfaceId]:
   */
  Future<bool> requestAccess(Device device, int interfaceId) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _usb.callMethod('requestAccess', [jsify(device), interfaceId, completer.callback]);
    return completer.future;
  }

  /**
   * Opens a USB device returned by [getDevices].
   * [device]: The device to open.
   * [callback]: Invoked with the created ConnectionHandle on complete.
   */
  Future<ConnectionHandle> openDevice(Device device) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<ConnectionHandle>.oneArg(_createConnectionHandle);
    _usb.callMethod('openDevice', [jsify(device), completer.callback]);
    return completer.future;
  }

  /**
   * Finds USB devices specified by the vendorId/productId/interfaceId tuple
   * and, if permissions allow, opens them for use.
   * 
   * On Chrome OS, you can specify the interfaceId. In that case the method will
   * request access from permission broker in the same way as in
   * [requestUsbAcess].
   * 
   * If the access request is rejected, or the device is failed to be opened,
   * its connection handle will not be created or returned.
   * 
   * Calling this method is equivalent to calling [getDevices] followed by a
   * series of [requestAccess] (if it is on ChromeOs) and [openDevice] calls,
   * and returning all the successfully opened connection handles.
   * 
   * [options]: The properties to search for on target devices.
   * [callback]: Invoked with the opened ConnectionHandle on complete.
   */
  Future<List<ConnectionHandle>> findDevices(EnumerateDevicesAndRequestAccessOptions options) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<ConnectionHandle>>.oneArg((e) => listify(e, _createConnectionHandle));
    _usb.callMethod('findDevices', [jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Closes a connection handle. Invoking operations on a device after it has
   * been closed is a safe operation, but causes no action to be taken.
   * [handle]: The connection handle to close.
   * [callback]: The callback to invoke once the device is closed.
   */
  Future closeDevice(ConnectionHandle handle) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _usb.callMethod('closeDevice', [jsify(handle), completer.callback]);
    return completer.future;
  }

  /**
   * Lists all the interfaces on the USB device.
   * [handle]: The device from which the interfaces should be listed.
   * [callback]: The callback to invoke when the interfaces are enumerated.
   */
  Future<List<InterfaceDescriptor>> listInterfaces(ConnectionHandle handle) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<InterfaceDescriptor>>.oneArg((e) => listify(e, _createInterfaceDescriptor));
    _usb.callMethod('listInterfaces', [jsify(handle), completer.callback]);
    return completer.future;
  }

  /**
   * Claims an interface on the specified USB device. Before you can transfer
   * data with endpoints, you must claim their parent interfaces. Only one
   * connection handle on the same host can claim each interface. If the
   * interface is already claimed, this call will fail.
   * 
   * You shall call releaseInterface when the interface is not needed anymore.
   * 
   * [handle]: The device on which the interface is to be claimed.
   * [interface]: The interface number to be claimed.
   * [callback]: The callback to invoke once the interface is claimed.
   */
  Future claimInterface(ConnectionHandle handle, int interfaceNumber) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _usb.callMethod('claimInterface', [jsify(handle), interfaceNumber, completer.callback]);
    return completer.future;
  }

  /**
   * Releases a claim to an interface on the provided device.
   * [handle]: The device on which the interface is to be released.
   * [interface]: The interface number to be released.
   * [callback]: The callback to invoke once the interface is released.
   */
  Future releaseInterface(ConnectionHandle handle, int interfaceNumber) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _usb.callMethod('releaseInterface', [jsify(handle), interfaceNumber, completer.callback]);
    return completer.future;
  }

  /**
   * Selects an alternate setting on a previously claimed interface on a device.
   * [handle]: The device on which the interface settings are to be set.
   * [interface]: The interface number to be set.
   * [alternateSetting]: The alternate setting to set.
   * [callback]: The callback to invoke once the interface setting is set.
   */
  Future setInterfaceAlternateSetting(ConnectionHandle handle, int interfaceNumber, int alternateSetting) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _usb.callMethod('setInterfaceAlternateSetting', [jsify(handle), interfaceNumber, alternateSetting, completer.callback]);
    return completer.future;
  }

  /**
   * Performs a control transfer on the specified device. See the
   * ControlTransferInfo structure for the parameters required to make a
   * transfer.
   * 
   * Conceptually control transfer talks to the device itself. You do not need
   * to claim interface 0 to perform a control transfer.
   * 
   * [handle]: A connection handle to make the transfer on.
   * [transferInfo]: The parameters to the transfer. See ControlTransferInfo.
   * [callback]: Invoked once the transfer has completed.
   */
  Future<TransferResultInfo> controlTransfer(ConnectionHandle handle, ControlTransferInfo transferInfo) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<TransferResultInfo>.oneArg(_createTransferResultInfo);
    _usb.callMethod('controlTransfer', [jsify(handle), jsify(transferInfo), completer.callback]);
    return completer.future;
  }

  /**
   * Performs a bulk transfer on the specified device.
   * [handle]: A connection handle to make the transfer on.
   * [transferInfo]: The parameters to the transfer. See GenericTransferInfo.
   * [callback]: Invoked once the transfer has completed.
   */
  Future<TransferResultInfo> bulkTransfer(ConnectionHandle handle, GenericTransferInfo transferInfo) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<TransferResultInfo>.oneArg(_createTransferResultInfo);
    _usb.callMethod('bulkTransfer', [jsify(handle), jsify(transferInfo), completer.callback]);
    return completer.future;
  }

  /**
   * Performs an interrupt transfer on the specified device.
   * [handle]: A connection handle to make the transfer on.
   * [transferInfo]: The parameters to the transfer. See GenericTransferInfo.
   * [callback]: Invoked once the transfer has completed.
   */
  Future<TransferResultInfo> interruptTransfer(ConnectionHandle handle, GenericTransferInfo transferInfo) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<TransferResultInfo>.oneArg(_createTransferResultInfo);
    _usb.callMethod('interruptTransfer', [jsify(handle), jsify(transferInfo), completer.callback]);
    return completer.future;
  }

  /**
   * Performs an isochronous transfer on the specific device.
   * [handle]: A connection handle to make the transfer on.
   * [transferInfo]: The parameters to the transfer. See
   * IsochronousTransferInfo.
   * [callback]: Invoked once the transfer has been completed.
   */
  Future<TransferResultInfo> isochronousTransfer(ConnectionHandle handle, IsochronousTransferInfo transferInfo) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<TransferResultInfo>.oneArg(_createTransferResultInfo);
    _usb.callMethod('isochronousTransfer', [jsify(handle), jsify(transferInfo), completer.callback]);
    return completer.future;
  }

  /**
   * Tries to reset the USB device and restores it to the previous status. If
   * the reset fails, the given connection handle will be closed and the USB
   * device will appear to be disconnected then reconnected. In that case you
   * must call [getDevices] or [findDevices] again to acquire the device.
   * 
   * [handle]: A connection handle to reset.
   * [callback]: Invoked once the device is reset with a boolean indicating
   * whether the reset is completed successfully.
   */
  Future<bool> resetDevice(ConnectionHandle handle) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _usb.callMethod('resetDevice', [jsify(handle), completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.usb' is not available");
  }
}

/**
 * Direction, Recipient, RequestType, and TransferType all map to their
 * namesakes within the USB specification.
 */
class Direction extends ChromeEnum {
  static const Direction IN = const Direction._('in');
  static const Direction OUT = const Direction._('out');

  static const List<Direction> VALUES = const[IN, OUT];

  const Direction._(String str): super(str);
}

class Recipient extends ChromeEnum {
  static const Recipient DEVICE = const Recipient._('device');
  static const Recipient INTERFACE = const Recipient._('interface');
  static const Recipient ENDPOINT = const Recipient._('endpoint');
  static const Recipient OTHER = const Recipient._('other');

  static const List<Recipient> VALUES = const[DEVICE, INTERFACE, ENDPOINT, OTHER];

  const Recipient._(String str): super(str);
}

class RequestType extends ChromeEnum {
  static const RequestType STANDARD = const RequestType._('standard');
  static const RequestType CLASS = const RequestType._('class');
  static const RequestType VENDOR = const RequestType._('vendor');
  static const RequestType RESERVED = const RequestType._('reserved');

  static const List<RequestType> VALUES = const[STANDARD, CLASS, VENDOR, RESERVED];

  const RequestType._(String str): super(str);
}

class TransferType extends ChromeEnum {
  static const TransferType CONTROL = const TransferType._('control');
  static const TransferType INTERRUPT = const TransferType._('interrupt');
  static const TransferType ISOCHRONOUS = const TransferType._('isochronous');
  static const TransferType BULK = const TransferType._('bulk');

  static const List<TransferType> VALUES = const[CONTROL, INTERRUPT, ISOCHRONOUS, BULK];

  const TransferType._(String str): super(str);
}

/**
 * For isochronous mode, SynchronizationType and UsageType map to their
 * namesakes within the USB specification.
 */
class SynchronizationType extends ChromeEnum {
  static const SynchronizationType ASYNCHRONOUS = const SynchronizationType._('asynchronous');
  static const SynchronizationType ADAPTIVE = const SynchronizationType._('adaptive');
  static const SynchronizationType SYNCHRONOUS = const SynchronizationType._('synchronous');

  static const List<SynchronizationType> VALUES = const[ASYNCHRONOUS, ADAPTIVE, SYNCHRONOUS];

  const SynchronizationType._(String str): super(str);
}

class UsageType extends ChromeEnum {
  static const UsageType DATA = const UsageType._('data');
  static const UsageType FEEDBACK = const UsageType._('feedback');
  static const UsageType EXPLICIT_FEEDBACK = const UsageType._('explicitFeedback');

  static const List<UsageType> VALUES = const[DATA, FEEDBACK, EXPLICIT_FEEDBACK];

  const UsageType._(String str): super(str);
}

/**
 * Returned by [getDevices] to identify a connected USB device.
 */
class Device extends ChromeObject {
  Device({int device, int vendorId, int productId}) {
    if (device != null) this.device = device;
    if (vendorId != null) this.vendorId = vendorId;
    if (productId != null) this.productId = productId;
  }
  Device.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get device => jsProxy['device'];
  set device(int value) => jsProxy['device'] = value;

  int get vendorId => jsProxy['vendorId'];
  set vendorId(int value) => jsProxy['vendorId'] = value;

  int get productId => jsProxy['productId'];
  set productId(int value) => jsProxy['productId'] = value;
}

/**
 * Returned by [openDevice] to be used for USB communication. Every time a
 * device is opened, a new connection handle is created.
 * 
 * A connection handle represents the underlying data structure that contains
 * all the data we need to communicate with a USB device, including the status
 * of interfaces, the pending transfers, the descriptors, and etc. A connectin
 * handle id is different from a USB device id.
 * 
 * All connection handles can work together if the device allows it. The
 * connection handle will be automatically closed when the app is reloaded or
 * suspended.
 * 
 * When a connection handle is closed, all the interfaces it claimed will be
 * released and all the transfers in progress will be canceled immediately.
 */
class ConnectionHandle extends ChromeObject {
  ConnectionHandle({int handle, int vendorId, int productId}) {
    if (handle != null) this.handle = handle;
    if (vendorId != null) this.vendorId = vendorId;
    if (productId != null) this.productId = productId;
  }
  ConnectionHandle.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get handle => jsProxy['handle'];
  set handle(int value) => jsProxy['handle'] = value;

  int get vendorId => jsProxy['vendorId'];
  set vendorId(int value) => jsProxy['vendorId'] = value;

  int get productId => jsProxy['productId'];
  set productId(int value) => jsProxy['productId'] = value;
}

class EndpointDescriptor extends ChromeObject {
  EndpointDescriptor({int address, TransferType type, Direction direction, int maximumPacketSize, SynchronizationType synchronization, UsageType usage, int pollingInterval}) {
    if (address != null) this.address = address;
    if (type != null) this.type = type;
    if (direction != null) this.direction = direction;
    if (maximumPacketSize != null) this.maximumPacketSize = maximumPacketSize;
    if (synchronization != null) this.synchronization = synchronization;
    if (usage != null) this.usage = usage;
    if (pollingInterval != null) this.pollingInterval = pollingInterval;
  }
  EndpointDescriptor.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get address => jsProxy['address'];
  set address(int value) => jsProxy['address'] = value;

  TransferType get type => _createTransferType(jsProxy['type']);
  set type(TransferType value) => jsProxy['type'] = jsify(value);

  Direction get direction => _createDirection(jsProxy['direction']);
  set direction(Direction value) => jsProxy['direction'] = jsify(value);

  int get maximumPacketSize => jsProxy['maximumPacketSize'];
  set maximumPacketSize(int value) => jsProxy['maximumPacketSize'] = value;

  SynchronizationType get synchronization => _createSynchronizationType(jsProxy['synchronization']);
  set synchronization(SynchronizationType value) => jsProxy['synchronization'] = jsify(value);

  UsageType get usage => _createUsageType(jsProxy['usage']);
  set usage(UsageType value) => jsProxy['usage'] = jsify(value);

  int get pollingInterval => jsProxy['pollingInterval'];
  set pollingInterval(int value) => jsProxy['pollingInterval'] = value;
}

class InterfaceDescriptor extends ChromeObject {
  InterfaceDescriptor({int interfaceNumber, int alternateSetting, int interfaceClass, int interfaceSubclass, int interfaceProtocol, String description, List<EndpointDescriptor> endpoints}) {
    if (interfaceNumber != null) this.interfaceNumber = interfaceNumber;
    if (alternateSetting != null) this.alternateSetting = alternateSetting;
    if (interfaceClass != null) this.interfaceClass = interfaceClass;
    if (interfaceSubclass != null) this.interfaceSubclass = interfaceSubclass;
    if (interfaceProtocol != null) this.interfaceProtocol = interfaceProtocol;
    if (description != null) this.description = description;
    if (endpoints != null) this.endpoints = endpoints;
  }
  InterfaceDescriptor.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get interfaceNumber => jsProxy['interfaceNumber'];
  set interfaceNumber(int value) => jsProxy['interfaceNumber'] = value;

  int get alternateSetting => jsProxy['alternateSetting'];
  set alternateSetting(int value) => jsProxy['alternateSetting'] = value;

  int get interfaceClass => jsProxy['interfaceClass'];
  set interfaceClass(int value) => jsProxy['interfaceClass'] = value;

  int get interfaceSubclass => jsProxy['interfaceSubclass'];
  set interfaceSubclass(int value) => jsProxy['interfaceSubclass'] = value;

  int get interfaceProtocol => jsProxy['interfaceProtocol'];
  set interfaceProtocol(int value) => jsProxy['interfaceProtocol'] = value;

  String get description => jsProxy['description'];
  set description(String value) => jsProxy['description'] = value;

  List<EndpointDescriptor> get endpoints => listify(jsProxy['endpoints'], _createEndpointDescriptor);
  set endpoints(List<EndpointDescriptor> value) => jsProxy['endpoints'] = jsify(value);
}

/**
 * ControlTransferInfo represents that parameters to a single USB control
 * transfer.
 */
class ControlTransferInfo extends ChromeObject {
  ControlTransferInfo({Direction direction, Recipient recipient, RequestType requestType, int request, int value, int index, int length, ArrayBuffer data}) {
    if (direction != null) this.direction = direction;
    if (recipient != null) this.recipient = recipient;
    if (requestType != null) this.requestType = requestType;
    if (request != null) this.request = request;
    if (value != null) this.value = value;
    if (index != null) this.index = index;
    if (length != null) this.length = length;
    if (data != null) this.data = data;
  }
  ControlTransferInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  Direction get direction => _createDirection(jsProxy['direction']);
  set direction(Direction value) => jsProxy['direction'] = jsify(value);

  Recipient get recipient => _createRecipient(jsProxy['recipient']);
  set recipient(Recipient value) => jsProxy['recipient'] = jsify(value);

  RequestType get requestType => _createRequestType(jsProxy['requestType']);
  set requestType(RequestType value) => jsProxy['requestType'] = jsify(value);

  int get request => jsProxy['request'];
  set request(int value) => jsProxy['request'] = value;

  int get value => jsProxy['value'];
  set value(int value) => jsProxy['value'] = value;

  int get index => jsProxy['index'];
  set index(int value) => jsProxy['index'] = value;

  int get length => jsProxy['length'];
  set length(int value) => jsProxy['length'] = value;

  ArrayBuffer get data => _createArrayBuffer(jsProxy['data']);
  set data(ArrayBuffer value) => jsProxy['data'] = jsify(value);
}

/**
 * GenericTransferInfo is used by both bulk and interrupt transfers to specify
 * the parameters of the transfer.
 */
class GenericTransferInfo extends ChromeObject {
  GenericTransferInfo({Direction direction, int endpoint, int length, ArrayBuffer data}) {
    if (direction != null) this.direction = direction;
    if (endpoint != null) this.endpoint = endpoint;
    if (length != null) this.length = length;
    if (data != null) this.data = data;
  }
  GenericTransferInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  Direction get direction => _createDirection(jsProxy['direction']);
  set direction(Direction value) => jsProxy['direction'] = jsify(value);

  int get endpoint => jsProxy['endpoint'];
  set endpoint(int value) => jsProxy['endpoint'] = value;

  int get length => jsProxy['length'];
  set length(int value) => jsProxy['length'] = value;

  ArrayBuffer get data => _createArrayBuffer(jsProxy['data']);
  set data(ArrayBuffer value) => jsProxy['data'] = jsify(value);
}

/**
 * IsochronousTransferInfo describes a single multi-packet isochronous transfer.
 */
class IsochronousTransferInfo extends ChromeObject {
  IsochronousTransferInfo({GenericTransferInfo transferInfo, int packets, int packetLength}) {
    if (transferInfo != null) this.transferInfo = transferInfo;
    if (packets != null) this.packets = packets;
    if (packetLength != null) this.packetLength = packetLength;
  }
  IsochronousTransferInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  GenericTransferInfo get transferInfo => _createGenericTransferInfo(jsProxy['transferInfo']);
  set transferInfo(GenericTransferInfo value) => jsProxy['transferInfo'] = jsify(value);

  int get packets => jsProxy['packets'];
  set packets(int value) => jsProxy['packets'] = value;

  int get packetLength => jsProxy['packetLength'];
  set packetLength(int value) => jsProxy['packetLength'] = value;
}

class TransferResultInfo extends ChromeObject {
  TransferResultInfo({int resultCode, ArrayBuffer data}) {
    if (resultCode != null) this.resultCode = resultCode;
    if (data != null) this.data = data;
  }
  TransferResultInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get resultCode => jsProxy['resultCode'];
  set resultCode(int value) => jsProxy['resultCode'] = value;

  ArrayBuffer get data => _createArrayBuffer(jsProxy['data']);
  set data(ArrayBuffer value) => jsProxy['data'] = jsify(value);
}

/**
 * Describes the properties of devices which are found via [getDevices].
 */
class EnumerateDevicesOptions extends ChromeObject {
  EnumerateDevicesOptions({int vendorId, int productId}) {
    if (vendorId != null) this.vendorId = vendorId;
    if (productId != null) this.productId = productId;
  }
  EnumerateDevicesOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get vendorId => jsProxy['vendorId'];
  set vendorId(int value) => jsProxy['vendorId'] = value;

  int get productId => jsProxy['productId'];
  set productId(int value) => jsProxy['productId'] = value;
}

/**
 * Describes the properties of devices which are found via [findDevices].
 */
class EnumerateDevicesAndRequestAccessOptions extends ChromeObject {
  EnumerateDevicesAndRequestAccessOptions({int vendorId, int productId, int interfaceId}) {
    if (vendorId != null) this.vendorId = vendorId;
    if (productId != null) this.productId = productId;
    if (interfaceId != null) this.interfaceId = interfaceId;
  }
  EnumerateDevicesAndRequestAccessOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get vendorId => jsProxy['vendorId'];
  set vendorId(int value) => jsProxy['vendorId'] = value;

  int get productId => jsProxy['productId'];
  set productId(int value) => jsProxy['productId'] = value;

  int get interfaceId => jsProxy['interfaceId'];
  set interfaceId(int value) => jsProxy['interfaceId'] = value;
}

Device _createDevice(JsObject jsProxy) => jsProxy == null ? null : new Device.fromProxy(jsProxy);
ConnectionHandle _createConnectionHandle(JsObject jsProxy) => jsProxy == null ? null : new ConnectionHandle.fromProxy(jsProxy);
InterfaceDescriptor _createInterfaceDescriptor(JsObject jsProxy) => jsProxy == null ? null : new InterfaceDescriptor.fromProxy(jsProxy);
TransferResultInfo _createTransferResultInfo(JsObject jsProxy) => jsProxy == null ? null : new TransferResultInfo.fromProxy(jsProxy);
TransferType _createTransferType(String value) => TransferType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
Direction _createDirection(String value) => Direction.VALUES.singleWhere((ChromeEnum e) => e.value == value);
SynchronizationType _createSynchronizationType(String value) => SynchronizationType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
UsageType _createUsageType(String value) => UsageType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
EndpointDescriptor _createEndpointDescriptor(JsObject jsProxy) => jsProxy == null ? null : new EndpointDescriptor.fromProxy(jsProxy);
Recipient _createRecipient(String value) => Recipient.VALUES.singleWhere((ChromeEnum e) => e.value == value);
RequestType _createRequestType(String value) => RequestType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
ArrayBuffer _createArrayBuffer(/*JsObject*/ jsProxy) => jsProxy == null ? null : new ArrayBuffer.fromProxy(jsProxy);
GenericTransferInfo _createGenericTransferInfo(JsObject jsProxy) => jsProxy == null ? null : new GenericTransferInfo.fromProxy(jsProxy);
