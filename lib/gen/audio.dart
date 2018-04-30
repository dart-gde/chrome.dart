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

  Stream<LevelChangedEvent> get onLevelChanged => _onLevelChanged.stream;
  ChromeStreamController<LevelChangedEvent> _onLevelChanged;

  Stream<MuteChangedEvent> get onMuteChanged => _onMuteChanged.stream;
  ChromeStreamController<MuteChangedEvent> _onMuteChanged;

  Stream<List<AudioDeviceInfo>> get onDeviceListChanged => _onDeviceListChanged.stream;
  ChromeStreamController<List<AudioDeviceInfo>> _onDeviceListChanged;

  Stream get onDeviceChanged => _onDeviceChanged.stream;
  ChromeStreamController _onDeviceChanged;

  ChromeAudio._() {
    var getApi = () => _audio;
    _onLevelChanged = new ChromeStreamController<LevelChangedEvent>.oneArg(getApi, 'onLevelChanged', _createLevelChangedEvent);
    _onMuteChanged = new ChromeStreamController<MuteChangedEvent>.oneArg(getApi, 'onMuteChanged', _createMuteChangedEvent);
    _onDeviceListChanged = new ChromeStreamController<List<AudioDeviceInfo>>.oneArg(getApi, 'onDeviceListChanged', (e) => listify(e, _createAudioDeviceInfo));
    _onDeviceChanged = new ChromeStreamController.noArgs(getApi, 'onDeviceChanged');
  }

  bool get available => _audio != null;

  /**
   * Gets a list of audio devices filtered based on [filter].
   * [filter]: Device properties by which to filter the list of returned audio
   * devices. If the filter is not set or set to `{}`, returned device list will
   * contain all available audio devices.
   * [callback]: Reports the requested list of audio devices.
   */
  Future<List<AudioDeviceInfo>> getDevices([DeviceFilter filter]) {
    if (_audio == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<AudioDeviceInfo>>.oneArg((e) => listify(e, _createAudioDeviceInfo));
    _audio.callMethod('getDevices', [jsify(filter), completer.callback]);
    return completer.future;
  }

  /**
   * Sets lists of active input and/or output devices.
   * [ids]: <p>Specifies IDs of devices that should be active. If either the
   * input or output list is not set, devices in that category are unaffected.
   * </p> <p>It is an error to pass in a non-existent device ID.</p>
   * <p><b>NOTE:</b> While the method signature allows device IDs to be passed
   * as a list of strings, this method of setting active devices is deprecated
   * and should not be relied upon to work. Please use [DeviceIdLists] instead.
   * </p>
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

  /**
   * Gets the system-wide mute state for the specified stream type.
   * [streamType]: Stream type for which mute state should be fetched.
   * [callback]: Callback reporting whether mute is set or not for specified
   * stream type.
   */
  Future<bool> getMute(StreamType streamType) {
    if (_audio == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _audio.callMethod('getMute', [jsify(streamType), completer.callback]);
    return completer.future;
  }

  /**
   * Sets mute state for a stream type. The mute state will apply to all audio
   * devices with the specified audio stream type.
   * [streamType]: Stream type for which mute state should be set.
   * [isMuted]: New mute value.
   */
  Future setMute(StreamType streamType, bool isMuted) {
    if (_audio == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _audio.callMethod('setMute', [jsify(streamType), isMuted, completer.callback]);
    return completer.future;
  }

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

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.audio' is not available");
  }
}

/**
 * Type of stream an audio device provides.
 */
class StreamType extends ChromeEnum {
  static const StreamType INPUT = const StreamType._('INPUT');
  static const StreamType OUTPUT = const StreamType._('OUTPUT');

  static const List<StreamType> VALUES = const[INPUT, OUTPUT];

  const StreamType._(String str): super(str);
}

/**
 * Available audio device types.
 */
class DeviceType extends ChromeEnum {
  static const DeviceType HEADPHONE = const DeviceType._('HEADPHONE');
  static const DeviceType MIC = const DeviceType._('MIC');
  static const DeviceType USB = const DeviceType._('USB');
  static const DeviceType BLUETOOTH = const DeviceType._('BLUETOOTH');
  static const DeviceType HDMI = const DeviceType._('HDMI');
  static const DeviceType INTERNAL_SPEAKER = const DeviceType._('INTERNAL_SPEAKER');
  static const DeviceType INTERNAL_MIC = const DeviceType._('INTERNAL_MIC');
  static const DeviceType FRONT_MIC = const DeviceType._('FRONT_MIC');
  static const DeviceType REAR_MIC = const DeviceType._('REAR_MIC');
  static const DeviceType KEYBOARD_MIC = const DeviceType._('KEYBOARD_MIC');
  static const DeviceType HOTWORD = const DeviceType._('HOTWORD');
  static const DeviceType LINEOUT = const DeviceType._('LINEOUT');
  static const DeviceType POST_MIX_LOOPBACK = const DeviceType._('POST_MIX_LOOPBACK');
  static const DeviceType POST_DSP_LOOPBACK = const DeviceType._('POST_DSP_LOOPBACK');
  static const DeviceType OTHER = const DeviceType._('OTHER');

  static const List<DeviceType> VALUES = const[HEADPHONE, MIC, USB, BLUETOOTH, HDMI, INTERNAL_SPEAKER, INTERNAL_MIC, FRONT_MIC, REAR_MIC, KEYBOARD_MIC, HOTWORD, LINEOUT, POST_MIX_LOOPBACK, POST_DSP_LOOPBACK, OTHER];

  const DeviceType._(String str): super(str);
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
  AudioDeviceInfo({String id, StreamType streamType, DeviceType deviceType, String displayName, String deviceName, bool isActive, int level, String stableDeviceId}) {
    if (id != null) this.id = id;
    if (streamType != null) this.streamType = streamType;
    if (deviceType != null) this.deviceType = deviceType;
    if (displayName != null) this.displayName = displayName;
    if (deviceName != null) this.deviceName = deviceName;
    if (isActive != null) this.isActive = isActive;
    if (level != null) this.level = level;
    if (stableDeviceId != null) this.stableDeviceId = stableDeviceId;
  }
  AudioDeviceInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  StreamType get streamType => _createStreamType(jsProxy['streamType']);
  set streamType(StreamType value) => jsProxy['streamType'] = jsify(value);

  DeviceType get deviceType => _createDeviceType(jsProxy['deviceType']);
  set deviceType(DeviceType value) => jsProxy['deviceType'] = jsify(value);

  String get displayName => jsProxy['displayName'];
  set displayName(String value) => jsProxy['displayName'] = value;

  String get deviceName => jsProxy['deviceName'];
  set deviceName(String value) => jsProxy['deviceName'] = value;

  bool get isActive => jsProxy['isActive'];
  set isActive(bool value) => jsProxy['isActive'] = value;

  int get level => jsProxy['level'];
  set level(int value) => jsProxy['level'] = value;

  String get stableDeviceId => jsProxy['stableDeviceId'];
  set stableDeviceId(String value) => jsProxy['stableDeviceId'] = value;
}

class DeviceFilter extends ChromeObject {
  DeviceFilter({List<StreamType> streamTypes, bool isActive}) {
    if (streamTypes != null) this.streamTypes = streamTypes;
    if (isActive != null) this.isActive = isActive;
  }
  DeviceFilter.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  List<StreamType> get streamTypes => listify(jsProxy['streamTypes'], _createStreamType);
  set streamTypes(List<StreamType> value) => jsProxy['streamTypes'] = jsify(value);

  bool get isActive => jsProxy['isActive'];
  set isActive(bool value) => jsProxy['isActive'] = value;
}

class DeviceProperties extends ChromeObject {
  DeviceProperties({bool isMuted, num volume, num gain, int level}) {
    if (isMuted != null) this.isMuted = isMuted;
    if (volume != null) this.volume = volume;
    if (gain != null) this.gain = gain;
    if (level != null) this.level = level;
  }
  DeviceProperties.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  bool get isMuted => jsProxy['isMuted'];
  set isMuted(bool value) => jsProxy['isMuted'] = value;

  num get volume => jsProxy['volume'];
  set volume(num value) => jsProxy['volume'] = jsify(value);

  num get gain => jsProxy['gain'];
  set gain(num value) => jsProxy['gain'] = jsify(value);

  int get level => jsProxy['level'];
  set level(int value) => jsProxy['level'] = value;
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

class MuteChangedEvent extends ChromeObject {
  MuteChangedEvent({StreamType streamType, bool isMuted}) {
    if (streamType != null) this.streamType = streamType;
    if (isMuted != null) this.isMuted = isMuted;
  }
  MuteChangedEvent.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  StreamType get streamType => _createStreamType(jsProxy['streamType']);
  set streamType(StreamType value) => jsProxy['streamType'] = jsify(value);

  bool get isMuted => jsProxy['isMuted'];
  set isMuted(bool value) => jsProxy['isMuted'] = value;
}

class LevelChangedEvent extends ChromeObject {
  LevelChangedEvent({String deviceId, int level}) {
    if (deviceId != null) this.deviceId = deviceId;
    if (level != null) this.level = level;
  }
  LevelChangedEvent.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get deviceId => jsProxy['deviceId'];
  set deviceId(String value) => jsProxy['deviceId'] = value;

  int get level => jsProxy['level'];
  set level(int value) => jsProxy['level'] = value;
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

LevelChangedEvent _createLevelChangedEvent(JsObject jsProxy) => jsProxy == null ? null : new LevelChangedEvent.fromProxy(jsProxy);
MuteChangedEvent _createMuteChangedEvent(JsObject jsProxy) => jsProxy == null ? null : new MuteChangedEvent.fromProxy(jsProxy);
AudioDeviceInfo _createAudioDeviceInfo(JsObject jsProxy) => jsProxy == null ? null : new AudioDeviceInfo.fromProxy(jsProxy);
StreamType _createStreamType(String value) => StreamType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
DeviceType _createDeviceType(String value) => DeviceType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
OutputDeviceInfo _createOutputDeviceInfo(JsObject jsProxy) => jsProxy == null ? null : new OutputDeviceInfo.fromProxy(jsProxy);
InputDeviceInfo _createInputDeviceInfo(JsObject jsProxy) => jsProxy == null ? null : new InputDeviceInfo.fromProxy(jsProxy);
