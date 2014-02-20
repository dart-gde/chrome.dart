/* This file has been generated from signed_in_devices.idl - do not edit */

/**
 * Use the `chrome.signedInDevices` API to get a list of devices signed into
 * chrome with the same account as the current profile.
 */
library chrome.signedInDevices;

import '../src/common.dart';

/**
 * Accessor for the `chrome.signedInDevices` namespace.
 */
final ChromeSignedInDevices signedInDevices = new ChromeSignedInDevices._();

class ChromeSignedInDevices extends ChromeApi {
  static final JsObject _signedInDevices = chrome['signedInDevices'];

  ChromeSignedInDevices._();

  bool get available => _signedInDevices != null;

  /**
   * Gets the array of signed in devices, signed into the same account as the
   * current profile.
   * [isLocal]: If true only return the information for the local device. If
   * false or omitted return the list of all devices including the local device.
   * [callback]: The callback to be invoked with the array of DeviceInfo
   * objects.
   */
  Future<List<DeviceInfo>> get([bool isLocal]) {
    if (_signedInDevices == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<DeviceInfo>>.oneArg((e) => listify(e, _createDeviceInfo));
    _signedInDevices.callMethod('get', [isLocal, completer.callback]);
    return completer.future;
  }

  Stream<List<DeviceInfo>> get onDeviceInfoChange => _onDeviceInfoChange.stream;

  final ChromeStreamController<List<DeviceInfo>> _onDeviceInfoChange =
      new ChromeStreamController<List<DeviceInfo>>.oneArg(_signedInDevices, 'onDeviceInfoChange', (e) => listify(e, _createDeviceInfo));

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.signedInDevices' is not available");
  }
}

class OS extends ChromeEnum {
  static const OS WIN = const OS._('win');
  static const OS MAC = const OS._('mac');
  static const OS LINUX = const OS._('linux');
  static const OS CHROME_OS = const OS._('chrome_os');
  static const OS ANDROID = const OS._('android');
  static const OS IOS = const OS._('ios');
  static const OS UNKNOWN = const OS._('unknown');

  static const List<OS> VALUES = const[WIN, MAC, LINUX, CHROME_OS, ANDROID, IOS, UNKNOWN];

  const OS._(String str): super(str);
}

class DeviceType extends ChromeEnum {
  static const DeviceType DESKTOP_OR_LAPTOP = const DeviceType._('desktop_or_laptop');
  static const DeviceType PHONE = const DeviceType._('phone');
  static const DeviceType TABLET = const DeviceType._('tablet');
  static const DeviceType UNKNOWN = const DeviceType._('unknown');

  static const List<DeviceType> VALUES = const[DESKTOP_OR_LAPTOP, PHONE, TABLET, UNKNOWN];

  const DeviceType._(String str): super(str);
}

class DeviceInfo extends ChromeObject {
  DeviceInfo({String name, String id, OS os, DeviceType type, String chromeVersion}) {
    if (name != null) this.name = name;
    if (id != null) this.id = id;
    if (os != null) this.os = os;
    if (type != null) this.type = type;
    if (chromeVersion != null) this.chromeVersion = chromeVersion;
  }
  DeviceInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  OS get os => _createOS(jsProxy['os']);
  set os(OS value) => jsProxy['os'] = jsify(value);

  DeviceType get type => _createDeviceType(jsProxy['type']);
  set type(DeviceType value) => jsProxy['type'] = jsify(value);

  String get chromeVersion => jsProxy['chromeVersion'];
  set chromeVersion(String value) => jsProxy['chromeVersion'] = value;
}

DeviceInfo _createDeviceInfo(JsObject jsProxy) => jsProxy == null ? null : new DeviceInfo.fromProxy(jsProxy);
OS _createOS(String value) => OS.VALUES.singleWhere((ChromeEnum e) => e.value == value);
DeviceType _createDeviceType(String value) => DeviceType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
