/* This file has been generated from tab_capture.idl - do not edit */

/**
 * Use the `chrome.tabCapture` API to interact with tab media streams.
 */
library chrome.tabCapture;

import '../src/common.dart';

/**
 * Accessor for the `chrome.tabCapture` namespace.
 */
final ChromeTabCapture tabCapture = new ChromeTabCapture._();

class ChromeTabCapture extends ChromeApi {
  static final JsObject _tabCapture = chrome['tabCapture'];

  ChromeTabCapture._();

  bool get available => _tabCapture != null;

  /**
   * Captures the visible area of the currently active tab. This method can only
   * be used on the currently active page after the extension has been
   * _invoked_, similar to the way that <a href="activeTab.html">activeTab</a>
   * works.
   * [options]: Configures the returned media stream.
   * [callback]: Callback with either the stream returned or null.
   */
  Future<LocalMediaStream> capture(CaptureOptions options) {
    if (_tabCapture == null) _throwNotAvailable();

    var completer = new ChromeCompleter<LocalMediaStream>.oneArg(_createLocalMediaStream);
    _tabCapture.callMethod('capture', [jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Returns a list of tabs that have requested capture or are being captured,
   * i.e. status != stopped and status != error. This allows extensions to
   * inform the user that there is an existing tab capture that would prevent a
   * new tab capture from succeeding (or to prevent redundant requests for the
   * same tab).
   */
  Future<List<CaptureInfo>> getCapturedTabs() {
    if (_tabCapture == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<CaptureInfo>>.oneArg((e) => listify(e, _createCaptureInfo));
    _tabCapture.callMethod('getCapturedTabs', [completer.callback]);
    return completer.future;
  }

  Stream<CaptureInfo> get onStatusChanged => _onStatusChanged.stream;

  final ChromeStreamController<CaptureInfo> _onStatusChanged =
      new ChromeStreamController<CaptureInfo>.oneArg(_tabCapture, 'onStatusChanged', _createCaptureInfo);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.tabCapture' is not available");
  }
}

class TabCaptureState extends ChromeEnum {
  static const TabCaptureState PENDING = const TabCaptureState._('pending');
  static const TabCaptureState ACTIVE = const TabCaptureState._('active');
  static const TabCaptureState STOPPED = const TabCaptureState._('stopped');
  static const TabCaptureState ERROR = const TabCaptureState._('error');

  static const List<TabCaptureState> VALUES = const[PENDING, ACTIVE, STOPPED, ERROR];

  const TabCaptureState._(String str): super(str);
}

class CaptureInfo extends ChromeObject {
  CaptureInfo({int tabId, TabCaptureState status, bool fullscreen}) {
    if (tabId != null) this.tabId = tabId;
    if (status != null) this.status = status;
    if (fullscreen != null) this.fullscreen = fullscreen;
  }
  CaptureInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;

  TabCaptureState get status => _createTabCaptureState(jsProxy['status']);
  set status(TabCaptureState value) => jsProxy['status'] = jsify(value);

  bool get fullscreen => jsProxy['fullscreen'];
  set fullscreen(bool value) => jsProxy['fullscreen'] = value;
}

/**
 * MediaTrackConstraints for the media streams that will be passed to WebRTC.
 * See section on MediaTrackConstraints:
 * http://dev.w3.org/2011/webrtc/editor/getusermedia.html
 */
class MediaStreamConstraint extends ChromeObject {
  MediaStreamConstraint({var mandatory, var optional}) {
    if (mandatory != null) this.mandatory = mandatory;
    if (optional != null) this.optional = optional;
  }
  MediaStreamConstraint.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  dynamic get mandatory => jsProxy['mandatory'];
  set mandatory(var value) => jsProxy['mandatory'] = jsify(value);

  dynamic get optional => jsProxy['_optional'];
  set optional(var value) => jsProxy['_optional'] = jsify(value);
}

/**
 * Whether we are requesting tab video and/or audio and the
 * MediaTrackConstraints that should be set for these streams.
 */
class CaptureOptions extends ChromeObject {
  CaptureOptions({bool audio, bool video, MediaStreamConstraint audioConstraints, MediaStreamConstraint videoConstraints}) {
    if (audio != null) this.audio = audio;
    if (video != null) this.video = video;
    if (audioConstraints != null) this.audioConstraints = audioConstraints;
    if (videoConstraints != null) this.videoConstraints = videoConstraints;
  }
  CaptureOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  bool get audio => jsProxy['audio'];
  set audio(bool value) => jsProxy['audio'] = value;

  bool get video => jsProxy['video'];
  set video(bool value) => jsProxy['video'] = value;

  MediaStreamConstraint get audioConstraints => _createMediaStreamConstraint(jsProxy['audioConstraints']);
  set audioConstraints(MediaStreamConstraint value) => jsProxy['audioConstraints'] = jsify(value);

  MediaStreamConstraint get videoConstraints => _createMediaStreamConstraint(jsProxy['videoConstraints']);
  set videoConstraints(MediaStreamConstraint value) => jsProxy['videoConstraints'] = jsify(value);
}

LocalMediaStream _createLocalMediaStream(JsObject jsProxy) => jsProxy == null ? null : new LocalMediaStream.fromProxy(jsProxy);
CaptureInfo _createCaptureInfo(JsObject jsProxy) => jsProxy == null ? null : new CaptureInfo.fromProxy(jsProxy);
TabCaptureState _createTabCaptureState(String value) => TabCaptureState.VALUES.singleWhere((ChromeEnum e) => e.value == value);
MediaStreamConstraint _createMediaStreamConstraint(JsObject jsProxy) => jsProxy == null ? null : new MediaStreamConstraint.fromProxy(jsProxy);
