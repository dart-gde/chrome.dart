/* This file has been generated from hid.idl - do not edit */

/**
 * Use the `chrome.hid` API to interact with connected HID devices. This API
 * provides access to HID operations from within the context of an app. Using
 * this API, apps can function as drivers for hardware devices.
 */
library chrome.hid;

import '../src/common.dart';

/**
 * Accessor for the `chrome.hid` namespace.
 */
final ChromeHid hid = new ChromeHid._();

class ChromeHid extends ChromeApi {
  JsObject get _hid => chrome['hid'];

  ChromeHid._();

  bool get available => _hid != null;

  /**
   * Enumerate all the connected HID devices specified by the vendorId/
   * productId/interfaceId tuple.
   * [options]: The properties to search for on target devices.
   * [callback]: Invoked with the `HidDeviceInfo` array on success.
   */
  Future<List<HidDeviceInfo>> getDevices(HidGetDevicesOptions options) {
    if (_hid == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<HidDeviceInfo>>.oneArg((e) => listify(e, _createHidDeviceInfo));
    _hid.callMethod('getDevices', [jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Open a connection to an HID device for communication.
   * [deviceId]: The ID of the device to open.
   * [callback]: Invoked with an `HidConnectInfo`.
   */
  Future<HidConnectInfo> connect(int deviceId) {
    if (_hid == null) _throwNotAvailable();

    var completer = new ChromeCompleter<HidConnectInfo>.oneArg(_createHidConnectInfo);
    _hid.callMethod('connect', [deviceId, completer.callback]);
    return completer.future;
  }

  /**
   * Disconnect from a device. Invoking operations on a device after calling
   * this is safe but has no effect.
   * [connectionId]: The connection to close.
   * [callback]: The callback to invoke once the device is closed.
   */
  Future disconnect(int connectionId) {
    if (_hid == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _hid.callMethod('disconnect', [connectionId, completer.callback]);
    return completer.future;
  }

  /**
   * Receive an Input report from an HID device.
   * 
   * Input reports are returned to the host through the INTERRUPT IN endpoint.
   * [connectionId]: The connection from which to receive a report.
   * [size]: The size of the Input report to receive.
   * [callback]: The callback to invoke with received report.
   * 
   * Returns:
   * The callback to be invoked when a `receive` or `receiveFeatureReport` call
   * is finished.
   * [data]: The content of the report.
   */
  Future<ArrayBuffer> receive(int connectionId, int size) {
    if (_hid == null) _throwNotAvailable();

    var completer = new ChromeCompleter<ArrayBuffer>.oneArg(_createArrayBuffer);
    _hid.callMethod('receive', [connectionId, size, completer.callback]);
    return completer.future;
  }

  /**
   * Send an Output report to an HID device. `send` will send the data on the
   * first OUT endpoint, if one exists. If one does not exist, the report will
   * be sent through the Control endpoint.
   * 
   * [connectionId]: The connection to which to send a report.
   * [reportId]: The report ID to use, or `0` if none.
   * [data]: The report data.
   * [callback]: The callback to invoke once the write is finished.
   */
  Future send(int connectionId, int reportId, ArrayBuffer data) {
    if (_hid == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _hid.callMethod('send', [connectionId, reportId, jsify(data), completer.callback]);
    return completer.future;
  }

  /**
   * Receive a Feature report from the device.
   * 
   * [connectionId]: The connection to read Input report from.
   * [reportId]: The report ID, or zero if none.
   * [size]: The size of the Feature report to receive.
   * [callback]: The callback to invoke once the write is finished.
   * 
   * Returns:
   * The callback to be invoked when a `receive` or `receiveFeatureReport` call
   * is finished.
   * [data]: The content of the report.
   */
  Future<ArrayBuffer> receiveFeatureReport(int connectionId, int reportId, int size) {
    if (_hid == null) _throwNotAvailable();

    var completer = new ChromeCompleter<ArrayBuffer>.oneArg(_createArrayBuffer);
    _hid.callMethod('receiveFeatureReport', [connectionId, reportId, size, completer.callback]);
    return completer.future;
  }

  /**
   * Send a Feature report to the device.
   * 
   * Feature reports are sent over the Control endpoint as a Set_Report
   * transfer.
   * [connectionId]: The connection to read Input report from.
   * [reportId]: The report ID to use, or `0` if none.
   * [data]: The report data.
   * [callback]: The callback to invoke once the write is finished.
   */
  Future sendFeatureReport(int connectionId, int reportId, ArrayBuffer data) {
    if (_hid == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _hid.callMethod('sendFeatureReport', [connectionId, reportId, jsify(data), completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.hid' is not available");
  }
}

/**
 * HID top-level collection attributes. Each enumerated device interface exposes
 * an array of these objects.
 * [usagePage]: HID usage page identifier.
 * [usage]: Page-defined usage identifier.
 * [reportIds]: Report IDs which belong to the collection and to its children.
 */
class HidCollectionInfo extends ChromeObject {
  HidCollectionInfo({int usagePage, int usage, List<int> reportIds}) {
    if (usagePage != null) this.usagePage = usagePage;
    if (usage != null) this.usage = usage;
    if (reportIds != null) this.reportIds = reportIds;
  }
  HidCollectionInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get usagePage => jsProxy['usagePage'];
  set usagePage(int value) => jsProxy['usagePage'] = value;

  int get usage => jsProxy['usage'];
  set usage(int value) => jsProxy['usage'] = value;

  List<int> get reportIds => listify(jsProxy['reportIds']);
  set reportIds(List<int> value) => jsProxy['reportIds'] = jsify(value);
}

/**
 * Returned by `getDevices` functions to describes a connected HID device. Use
 * `connect` to connect to any of the returned devices.
 * [deviceId]: Device opaque ID.
 * [vendorId]: Vendor ID.
 * [productId]: Product ID.
 * [collections]: Top-level collections from this device's report descriptor.
 * [maxInputReportSize]: Top-level collection's max input report size.
 * [maxOutputReportSize]: Top-level collection's max output report size.
 * [maxFeatureReportSize]: Top-level collection's max feature report size.
 */
class HidDeviceInfo extends ChromeObject {
  HidDeviceInfo({int deviceId, int vendorId, int productId, List<HidCollectionInfo> collections, int maxInputReportSize, int maxOutputReportSize, int maxFeatureReportSize}) {
    if (deviceId != null) this.deviceId = deviceId;
    if (vendorId != null) this.vendorId = vendorId;
    if (productId != null) this.productId = productId;
    if (collections != null) this.collections = collections;
    if (maxInputReportSize != null) this.maxInputReportSize = maxInputReportSize;
    if (maxOutputReportSize != null) this.maxOutputReportSize = maxOutputReportSize;
    if (maxFeatureReportSize != null) this.maxFeatureReportSize = maxFeatureReportSize;
  }
  HidDeviceInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get deviceId => jsProxy['deviceId'];
  set deviceId(int value) => jsProxy['deviceId'] = value;

  int get vendorId => jsProxy['vendorId'];
  set vendorId(int value) => jsProxy['vendorId'] = value;

  int get productId => jsProxy['productId'];
  set productId(int value) => jsProxy['productId'] = value;

  List<HidCollectionInfo> get collections => listify(jsProxy['collections'], _createHidCollectionInfo);
  set collections(List<HidCollectionInfo> value) => jsProxy['collections'] = jsify(value);

  int get maxInputReportSize => jsProxy['maxInputReportSize'];
  set maxInputReportSize(int value) => jsProxy['maxInputReportSize'] = value;

  int get maxOutputReportSize => jsProxy['maxOutputReportSize'];
  set maxOutputReportSize(int value) => jsProxy['maxOutputReportSize'] = value;

  int get maxFeatureReportSize => jsProxy['maxFeatureReportSize'];
  set maxFeatureReportSize(int value) => jsProxy['maxFeatureReportSize'] = value;
}

/**
 * Returned by `connect` to represent a communication session with an HID
 * device. Must be closed with a call to `disconnect`.
 */
class HidConnectInfo extends ChromeObject {
  HidConnectInfo({int connectionId}) {
    if (connectionId != null) this.connectionId = connectionId;
  }
  HidConnectInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get connectionId => jsProxy['connectionId'];
  set connectionId(int value) => jsProxy['connectionId'] = value;
}

/**
 * Searching criteria to enumerate devices with.
 */
class HidGetDevicesOptions extends ChromeObject {
  HidGetDevicesOptions({int vendorId, int productId}) {
    if (vendorId != null) this.vendorId = vendorId;
    if (productId != null) this.productId = productId;
  }
  HidGetDevicesOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get vendorId => jsProxy['vendorId'];
  set vendorId(int value) => jsProxy['vendorId'] = value;

  int get productId => jsProxy['productId'];
  set productId(int value) => jsProxy['productId'] = value;
}

HidDeviceInfo _createHidDeviceInfo(JsObject jsProxy) => jsProxy == null ? null : new HidDeviceInfo.fromProxy(jsProxy);
HidConnectInfo _createHidConnectInfo(JsObject jsProxy) => jsProxy == null ? null : new HidConnectInfo.fromProxy(jsProxy);
ArrayBuffer _createArrayBuffer(/*JsObject*/ jsProxy) => jsProxy == null ? null : new ArrayBuffer.fromProxy(jsProxy);
HidCollectionInfo _createHidCollectionInfo(JsObject jsProxy) => jsProxy == null ? null : new HidCollectionInfo.fromProxy(jsProxy);
