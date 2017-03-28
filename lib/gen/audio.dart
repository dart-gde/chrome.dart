/* This file has been generated from audio.idl - do not edit */

/**
 * The `chrome.audio` API is provided to allow users to get information about
 * and control the audio devices attached to the system. This API is currently
 * only implemented for ChromeOS.
 */
library chrome.audio;

import '../src/common.dart';

/**
 * Accessor for the `chrome.audio` namespace.
 */
final ChromeAudio audio = new ChromeAudio._();

class ChromeAudio extends ChromeApi {
  JsObject get _audio => chrome['audio'];

  Stream get onDeviceChanged => _onDeviceChanged.stream;
  ChromeStreamController _onDeviceChanged;

  Stream<OnLevelChangedEvent> get OnLevelChanged => _OnLevelChanged.stream;
  ChromeStreamController<OnLevelChangedEvent> _OnLevelChanged;

  Stream<OnMuteChangedEvent> get OnMuteChanged => _OnMuteChanged.stream;
  ChromeStreamController<OnMuteChangedEvent> _OnMuteChanged;

  Stream<List<AudioDeviceInfo>> get OnDevicesChanged => _OnDevicesChanged.stream;
  ChromeStreamController<List<AudioDeviceInfo>> _OnDevicesChanged;

  ChromeAudio._() {
    var getApi = () => _audio;
    _onDeviceChanged = new ChromeStreamController.noArgs(getApi, 'onDeviceChanged');
    _OnLevelChanged = new ChromeStreamController<OnLevelChangedEvent>.twoArgs(getApi, 'OnLevelChanged', _createOnLevelChangedEvent);
    _OnMuteChanged = new ChromeStreamController<OnMuteChangedEvent>.twoArgs(getApi, 'OnMuteChanged', _createOnMuteChangedEvent);
    _OnDevicesChanged = new ChromeStreamController<List<AudioDeviceInfo>>.oneArg(getApi, 'OnDevicesChanged', (e) => listify(e, _createAudioDeviceInfo));
  }

  bool get available => _audio != null;

  /**
   * Gets the information of all audio output and input devices.
   * 
   * Returns:
   * [outputInfo] null
   * [inputInfo] null
   */
  Future<GetInfoResult> getInfo() {
    if (_audio == null) _throwNotAvailable();

    var completer = new ChromeCompleter<GetInfoResult>.twoArgs(GetInfoResult._create);
    _audio.callMethod('getInfo', [completer.callback]);
    return completer.future;
  }

  /**
   * Sets lists of active input and/or output devices.
   * [ids]: <p>Specifies IDs of devices that should be active. If either the
   * input or output list is not set, devices in that category are unaffected.
   * </p> <p>It is an error to pass in a non-existent device ID.</p>
   * <p><b>NOTE:</b> While the method signature allows device IDs to be passed
   * as a list of strings, this method of setting active devices is deprecated
   * and should not be relied upon to work. Please use $(ref: DeviceIdLists)
   * instead. </p>
   */
  Future setActiveDevices(dynamic ids) {
    if (_audio == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _audio.callMethod('setActiveDevices', [jsify(ids), completer.callback]);
    return completer.future;
  }

  /**
   * Sets the properties for the input or output device.
   */
  Future setProperties(String id, DeviceProperties properties) {
    if (_audio == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _audio.callMethod('setProperties', [id, jsify(properties), completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.audio' is not available");
  }
}

class OnLevelChangedEvent {
  final String id;

  final int level;

  OnLevelChangedEvent(this.id, this.level);
}

class OnMuteChangedEvent {
  final bool isInput;

  final bool isMuted;

  OnMuteChangedEvent(this.isInput, this.isMuted);
}

class OutputDeviceInfo extends ChromeObject {
  OutputDeviceInfo({String id, String name, bool isActive, bool isMuted, num volume}) {
    if (id != null) this.id = id;
    if (name != null) this.name = name;
    if (isActive != null) this.isActive = isActive;
    if (isMuted != null) this.isMuted = isMuted;
    if (volume != null) this.volume = volume;
  }
  OutputDeviceInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  bool get isActive => jsProxy['isActive'];
  set isActive(bool value) => jsProxy['isActive'] = value;

  bool get isMuted => jsProxy['isMuted'];
  set isMuted(bool value) => jsProxy['isMuted'] = value;

  num get volume => jsProxy['volume'];
  set volume(num value) => jsProxy['volume'] = jsify(value);
}

class InputDeviceInfo extends ChromeObject {
  InputDeviceInfo({String id, String name, bool isActive, bool isMuted, num gain}) {
    if (id != null) this.id = id;
    if (name != null) this.name = name;
    if (isActive != null) this.isActive = isActive;
    if (isMuted != null) this.isMuted = isMuted;
    if (gain != null) this.gain = gain;
  }
  InputDeviceInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  bool get isActive => jsProxy['isActive'];
  set isActive(bool value) => jsProxy['isActive'] = value;

  bool get isMuted => jsProxy['isMuted'];
  set isMuted(bool value) => jsProxy['isMuted'] = value;

  num get gain => jsProxy['gain'];
  set gain(num value) => jsProxy['gain'] = jsify(value);
}

class AudioDeviceInfo extends ChromeObject {
  AudioDeviceInfo({String id, bool isInput, String deviceType, String displayName, String deviceName, bool isActive, bool isMuted, int level, String stableDeviceId}) {
    if (id != null) this.id = id;
    if (isInput != null) this.isInput = isInput;
    if (deviceType != null) this.deviceType = deviceType;
    if (displayName != null) this.displayName = displayName;
    if (deviceName != null) this.deviceName = deviceName;
    if (isActive != null) this.isActive = isActive;
    if (isMuted != null) this.isMuted = isMuted;
    if (level != null) this.level = level;
    if (stableDeviceId != null) this.stableDeviceId = stableDeviceId;
  }
  AudioDeviceInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  bool get isInput => jsProxy['isInput'];
  set isInput(bool value) => jsProxy['isInput'] = value;

  String get deviceType => jsProxy['deviceType'];
  set deviceType(String value) => jsProxy['deviceType'] = value;

  String get displayName => jsProxy['displayName'];
  set displayName(String value) => jsProxy['displayName'] = value;

  String get deviceName => jsProxy['deviceName'];
  set deviceName(String value) => jsProxy['deviceName'] = value;

  bool get isActive => jsProxy['isActive'];
  set isActive(bool value) => jsProxy['isActive'] = value;

  bool get isMuted => jsProxy['isMuted'];
  set isMuted(bool value) => jsProxy['isMuted'] = value;

  int get level => jsProxy['level'];
  set level(int value) => jsProxy['level'] = value;

  String get stableDeviceId => jsProxy['stableDeviceId'];
  set stableDeviceId(String value) => jsProxy['stableDeviceId'] = value;
}

class DeviceProperties extends ChromeObject {
  DeviceProperties({bool isMuted, num volume, num gain}) {
    if (isMuted != null) this.isMuted = isMuted;
    if (volume != null) this.volume = volume;
    if (gain != null) this.gain = gain;
  }
  DeviceProperties.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  bool get isMuted => jsProxy['isMuted'];
  set isMuted(bool value) => jsProxy['isMuted'] = value;

  num get volume => jsProxy['volume'];
  set volume(num value) => jsProxy['volume'] = jsify(value);

  num get gain => jsProxy['gain'];
  set gain(num value) => jsProxy['gain'] = jsify(value);
}

class DeviceIdLists extends ChromeObject {
  DeviceIdLists({List<String> input, List<String> output}) {
    if (input != null) this.input = input;
    if (output != null) this.output = output;
  }
  DeviceIdLists.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  List<String> get input => listify(jsProxy['input']);
  set input(List<String> value) => jsProxy['input'] = jsify(value);

  List<String> get output => listify(jsProxy['output']);
  set output(List<String> value) => jsProxy['output'] = jsify(value);
}

/**
 * The return type for [getInfo].
 */
class GetInfoResult {
  static GetInfoResult _create(outputInfo, inputInfo) {
    return new GetInfoResult._(listify(outputInfo, _createOutputDeviceInfo), listify(inputInfo, _createInputDeviceInfo));
  }

  List<OutputDeviceInfo> outputInfo;
  List<InputDeviceInfo> inputInfo;

  GetInfoResult._(this.outputInfo, this.inputInfo);
}

OnLevelChangedEvent _createOnLevelChangedEvent(String id, int level) =>
    new OnLevelChangedEvent(id, level);
OnMuteChangedEvent _createOnMuteChangedEvent(bool isInput, bool isMuted) =>
    new OnMuteChangedEvent(isInput, isMuted);
AudioDeviceInfo _createAudioDeviceInfo(JsObject jsProxy) => jsProxy == null ? null : new AudioDeviceInfo.fromProxy(jsProxy);
OutputDeviceInfo _createOutputDeviceInfo(JsObject jsProxy) => jsProxy == null ? null : new OutputDeviceInfo.fromProxy(jsProxy);
InputDeviceInfo _createInputDeviceInfo(JsObject jsProxy) => jsProxy == null ? null : new InputDeviceInfo.fromProxy(jsProxy);
