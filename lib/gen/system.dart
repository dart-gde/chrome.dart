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
  JsObject get _system_cpu => chrome['system']['cpu'];

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

/**
 * Counters for assessing CPU utilization. Each field is monotonically
 * increasing while the processor is powered on. Values are in milliseconds.
 */
class CpuTime extends ChromeObject {
  CpuTime({num user, num kernel, num idle, num total}) {
    if (user != null) this.user = user;
    if (kernel != null) this.kernel = kernel;
    if (idle != null) this.idle = idle;
    if (total != null) this.total = total;
  }
  CpuTime.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  num get user => jsProxy['user'];
  set user(num value) => jsProxy['user'] = jsify(value);

  num get kernel => jsProxy['kernel'];
  set kernel(num value) => jsProxy['kernel'] = jsify(value);

  num get idle => jsProxy['idle'];
  set idle(num value) => jsProxy['idle'] = jsify(value);

  num get total => jsProxy['total'];
  set total(num value) => jsProxy['total'] = jsify(value);
}

class ProcessorInfo extends ChromeObject {
  ProcessorInfo({CpuTime usage}) {
    if (usage != null) this.usage = usage;
  }
  ProcessorInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  CpuTime get usage => _createCpuTime(jsProxy['usage']);
  set usage(CpuTime value) => jsProxy['usage'] = jsify(value);
}

class CpuInfo extends ChromeObject {
  CpuInfo({int numOfProcessors, String archName, String modelName, List<String> features, List<ProcessorInfo> processors, List<num> temperatures}) {
    if (numOfProcessors != null) this.numOfProcessors = numOfProcessors;
    if (archName != null) this.archName = archName;
    if (modelName != null) this.modelName = modelName;
    if (features != null) this.features = features;
    if (processors != null) this.processors = processors;
    if (temperatures != null) this.temperatures = temperatures;
  }
  CpuInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get numOfProcessors => jsProxy['numOfProcessors'];
  set numOfProcessors(int value) => jsProxy['numOfProcessors'] = value;

  String get archName => jsProxy['archName'];
  set archName(String value) => jsProxy['archName'] = value;

  String get modelName => jsProxy['modelName'];
  set modelName(String value) => jsProxy['modelName'] = value;

  List<String> get features => listify(jsProxy['features']);
  set features(List<String> value) => jsProxy['features'] = jsify(value);

  List<ProcessorInfo> get processors => listify(jsProxy['processors'], _createProcessorInfo);
  set processors(List<ProcessorInfo> value) => jsProxy['processors'] = jsify(value);

  List<num> get temperatures => listify(jsProxy['temperatures']);
  set temperatures(List<num> value) => jsProxy['temperatures'] = jsify(value);
}

CpuInfo _createCpuInfo(JsObject jsProxy) => jsProxy == null ? null : new CpuInfo.fromProxy(jsProxy);
CpuTime _createCpuTime(JsObject jsProxy) => jsProxy == null ? null : new CpuTime.fromProxy(jsProxy);
ProcessorInfo _createProcessorInfo(JsObject jsProxy) => jsProxy == null ? null : new ProcessorInfo.fromProxy(jsProxy);

/**
 * Use the `system.display` API to query display metadata.
 */
class ChromeSystemDisplay extends ChromeApi {
  JsObject get _system_display => chrome['system']['display'];

  Stream get onDisplayChanged => _onDisplayChanged.stream;
  ChromeStreamController _onDisplayChanged;

  ChromeSystemDisplay._() {
    var getApi = () => _system_display;
    _onDisplayChanged = new ChromeStreamController.noArgs(getApi, 'onDisplayChanged');
  }

  bool get available => _system_display != null;

  /**
   * Requests the information for all attached display devices.
   * [flags]: Options affecting how the information is returned.
   * [callback]: The callback to invoke with the results.
   */
  Future<List<DisplayUnitInfo>> getInfo([GetInfoFlags flags]) {
    if (_system_display == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<DisplayUnitInfo>>.oneArg((e) => listify(e, _createDisplayUnitInfo));
    _system_display.callMethod('getInfo', [jsify(flags), completer.callback]);
    return completer.future;
  }

  /**
   * Requests the layout info for all displays. NOTE: This is only available to
   * Chrome OS Kiosk apps and Web UI.
   * [callback]: The callback to invoke with the results.
   */
  Future<List<DisplayLayout>> getDisplayLayout() {
    if (_system_display == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<DisplayLayout>>.oneArg((e) => listify(e, _createDisplayLayout));
    _system_display.callMethod('getDisplayLayout', [completer.callback]);
    return completer.future;
  }

  /**
   * Updates the properties for the display specified by [id], according to the
   * information provided in [info]. On failure, [runtime.lastError] will be
   * set. NOTE: This is only available to Chrome OS Kiosk apps and Web UI.
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

  /**
   * Set the layout for all displays. Any display not included will use the
   * default layout. If a layout would overlap or be otherwise invalid it will
   * be adjusted to a valid layout. After layout is resolved, an
   * onDisplayChanged event will be triggered. NOTE: This is only available to
   * Chrome OS Kiosk apps and Web UI.
   * [layouts]: The layout information, required for all displays except the
   * primary display.
   * [callback]: Empty function called when the function finishes. To find out
   * whether the function succeeded, [runtime.lastError] should be queried.
   */
  Future setDisplayLayout(List<DisplayLayout> layouts) {
    if (_system_display == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _system_display.callMethod('setDisplayLayout', [jsify(layouts), completer.callback]);
    return completer.future;
  }

  /**
   * Enables/disables the unified desktop feature. Note that this simply enables
   * the feature, but will not change the actual desktop mode. (That is, if the
   * desktop is in mirror mode, it will stay in mirror mode) NOTE: This is only
   * available to Chrome OS Kiosk apps and Web UI.
   * [enabled]: True if unified desktop should be enabled.
   */
  void enableUnifiedDesktop(bool enabled) {
    if (_system_display == null) _throwNotAvailable();

    _system_display.callMethod('enableUnifiedDesktop', [enabled]);
  }

  /**
   * Starts overscan calibration for a display. This will show an overlay on the
   * screen indicating the current overscan insets. If overscan calibration for
   * display [id] is in progress this will reset calibration.
   * [id]: The display's unique identifier.
   */
  void overscanCalibrationStart(String id) {
    if (_system_display == null) _throwNotAvailable();

    _system_display.callMethod('overscanCalibrationStart', [id]);
  }

  /**
   * Adjusts the current overscan insets for a display. Typically this should
   * etiher move the display along an axis (e.g. left+right have the same value)
   * or scale it along an axis (e.g. top+bottom have opposite values). Each
   * Adjust call is cumulative with previous calls since Start.
   * [id]: The display's unique identifier.
   * [delta]: The amount to change the overscan insets.
   */
  void overscanCalibrationAdjust(String id, Insets delta) {
    if (_system_display == null) _throwNotAvailable();

    _system_display.callMethod('overscanCalibrationAdjust', [id, jsify(delta)]);
  }

  /**
   * Resets the overscan insets for a display to the last saved value (i.e
   * before Start was called).
   * [id]: The display's unique identifier.
   */
  void overscanCalibrationReset(String id) {
    if (_system_display == null) _throwNotAvailable();

    _system_display.callMethod('overscanCalibrationReset', [id]);
  }

  /**
   * Complete overscan adjustments for a display by saving the current values
   * and hiding the overlay.
   * [id]: The display's unique identifier.
   */
  void overscanCalibrationComplete(String id) {
    if (_system_display == null) _throwNotAvailable();

    _system_display.callMethod('overscanCalibrationComplete', [id]);
  }

  /**
   * Displays the native touch calibration UX for the display with [id] as
   * display id. This will show an overlay on the screen with required
   * instructions on how to proceed. The callback will be invoked in case of
   * successful calibraion only. If the calibration fails, this will throw an
   * error.
   * [id]: The display's unique identifier.
   * [callback]: Optional callback to inform the caller that the touch
   * calibration has ended. The argument of the callback informs if the
   * calibration was a success or not.
   */
  Future<bool> showNativeTouchCalibration(String id) {
    if (_system_display == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _system_display.callMethod('showNativeTouchCalibration', [id, completer.callback]);
    return completer.future;
  }

  /**
   * Starts custom touch calibration for a display. This should be called when
   * using a custom UX for collecting calibration data. If another touch
   * calibration is already in progress this will throw an error.
   * [id]: The display's unique identifier.
   */
  void startCustomTouchCalibration(String id) {
    if (_system_display == null) _throwNotAvailable();

    _system_display.callMethod('startCustomTouchCalibration', [id]);
  }

  /**
   * Sets the touch calibration pairs for a display. These [pairs] would be used
   * to calibrate the touch screen for display with [id] called in
   * startCustomTouchCalibration(). Always call [startCustomTouchCalibration]
   * before calling this method. If another touch calibration is already in
   * progress this will throw an error.
   * [pairs]: The pairs of point used to calibrate the display.
   * [bounds]: Bounds of the display when the touch calibration was performed.
   * |bounds.left| and |bounds.top| values are ignored.
   */
  void completeCustomTouchCalibration(TouchCalibrationPairQuad pairs, Bounds bounds) {
    if (_system_display == null) _throwNotAvailable();

    _system_display.callMethod('completeCustomTouchCalibration', [jsify(pairs), jsify(bounds)]);
  }

  /**
   * Resets the touch calibration for the display and brings it back to its
   * default state by clearing any touch calibration data associated with the
   * display.
   * [id]: The display's unique identifier.
   */
  void clearTouchCalibration(String id) {
    if (_system_display == null) _throwNotAvailable();

    _system_display.callMethod('clearTouchCalibration', [id]);
  }

  /**
   * Sets the display mode to the specified mirror mode. Each call resets the
   * state from previous calls. Calling setDisplayProperties() will fail for the
   * mirroring destination displays. NOTE: This is only available to Chrome OS
   * Kiosk apps and Web UI.
   * [info]: The information of the mirror mode that should be applied to the
   * display mode.
   * [callback]: Empty function called when the function finishes. To find out
   * whether the function succeeded, [runtime.lastError] should be queried.
   */
  Future setMirrorMode(MirrorModeInfo info) {
    if (_system_display == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _system_display.callMethod('setMirrorMode', [jsify(info), completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.system.display' is not available");
  }
}

/**
 * Layout position, i.e. edge of parent that the display is attached to.
 */
class LayoutPosition extends ChromeEnum {
  static const LayoutPosition TOP = const LayoutPosition._('top');
  static const LayoutPosition RIGHT = const LayoutPosition._('right');
  static const LayoutPosition BOTTOM = const LayoutPosition._('bottom');
  static const LayoutPosition LEFT = const LayoutPosition._('left');

  static const List<LayoutPosition> VALUES = const[TOP, RIGHT, BOTTOM, LEFT];

  const LayoutPosition._(String str): super(str);
}

/**
 * Mirror mode, i.e. different ways of how a display is mirrored to other
 * displays.
 */
class MirrorMode extends ChromeEnum {
  static const MirrorMode OFF = const MirrorMode._('off');
  static const MirrorMode NORMAL = const MirrorMode._('normal');
  static const MirrorMode MIXED = const MirrorMode._('mixed');

  static const List<MirrorMode> VALUES = const[OFF, NORMAL, MIXED];

  const MirrorMode._(String str): super(str);
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

class Point extends ChromeObject {
  Point({int x, int y}) {
    if (x != null) this.x = x;
    if (y != null) this.y = y;
  }
  Point.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get x => jsProxy['x'];
  set x(int value) => jsProxy['x'] = value;

  int get y => jsProxy['y'];
  set y(int value) => jsProxy['y'] = value;
}

class TouchCalibrationPair extends ChromeObject {
  TouchCalibrationPair({Point displayPoint, Point touchPoint}) {
    if (displayPoint != null) this.displayPoint = displayPoint;
    if (touchPoint != null) this.touchPoint = touchPoint;
  }
  TouchCalibrationPair.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  Point get displayPoint => _createPoint(jsProxy['displayPoint']);
  set displayPoint(Point value) => jsProxy['displayPoint'] = jsify(value);

  Point get touchPoint => _createPoint(jsProxy['touchPoint']);
  set touchPoint(Point value) => jsProxy['touchPoint'] = jsify(value);
}

class TouchCalibrationPairQuad extends ChromeObject {
  TouchCalibrationPairQuad({TouchCalibrationPair pair1, TouchCalibrationPair pair2, TouchCalibrationPair pair3, TouchCalibrationPair pair4}) {
    if (pair1 != null) this.pair1 = pair1;
    if (pair2 != null) this.pair2 = pair2;
    if (pair3 != null) this.pair3 = pair3;
    if (pair4 != null) this.pair4 = pair4;
  }
  TouchCalibrationPairQuad.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  TouchCalibrationPair get pair1 => _createTouchCalibrationPair(jsProxy['pair1']);
  set pair1(TouchCalibrationPair value) => jsProxy['pair1'] = jsify(value);

  TouchCalibrationPair get pair2 => _createTouchCalibrationPair(jsProxy['pair2']);
  set pair2(TouchCalibrationPair value) => jsProxy['pair2'] = jsify(value);

  TouchCalibrationPair get pair3 => _createTouchCalibrationPair(jsProxy['pair3']);
  set pair3(TouchCalibrationPair value) => jsProxy['pair3'] = jsify(value);

  TouchCalibrationPair get pair4 => _createTouchCalibrationPair(jsProxy['pair4']);
  set pair4(TouchCalibrationPair value) => jsProxy['pair4'] = jsify(value);
}

class DisplayMode extends ChromeObject {
  DisplayMode({int width, int height, int widthInNativePixels, int heightInNativePixels, num uiScale, num deviceScaleFactor, bool isNative, bool isSelected}) {
    if (width != null) this.width = width;
    if (height != null) this.height = height;
    if (widthInNativePixels != null) this.widthInNativePixels = widthInNativePixels;
    if (heightInNativePixels != null) this.heightInNativePixels = heightInNativePixels;
    if (uiScale != null) this.uiScale = uiScale;
    if (deviceScaleFactor != null) this.deviceScaleFactor = deviceScaleFactor;
    if (isNative != null) this.isNative = isNative;
    if (isSelected != null) this.isSelected = isSelected;
  }
  DisplayMode.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get width => jsProxy['width'];
  set width(int value) => jsProxy['width'] = value;

  int get height => jsProxy['height'];
  set height(int value) => jsProxy['height'] = value;

  int get widthInNativePixels => jsProxy['widthInNativePixels'];
  set widthInNativePixels(int value) => jsProxy['widthInNativePixels'] = value;

  int get heightInNativePixels => jsProxy['heightInNativePixels'];
  set heightInNativePixels(int value) => jsProxy['heightInNativePixels'] = value;

  num get uiScale => jsProxy['uiScale'];
  set uiScale(num value) => jsProxy['uiScale'] = jsify(value);

  num get deviceScaleFactor => jsProxy['deviceScaleFactor'];
  set deviceScaleFactor(num value) => jsProxy['deviceScaleFactor'] = jsify(value);

  bool get isNative => jsProxy['isNative'];
  set isNative(bool value) => jsProxy['isNative'] = value;

  bool get isSelected => jsProxy['isSelected'];
  set isSelected(bool value) => jsProxy['isSelected'] = value;
}

class DisplayLayout extends ChromeObject {
  DisplayLayout({String id, String parentId, LayoutPosition position, int offset}) {
    if (id != null) this.id = id;
    if (parentId != null) this.parentId = parentId;
    if (position != null) this.position = position;
    if (offset != null) this.offset = offset;
  }
  DisplayLayout.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  String get parentId => jsProxy['parentId'];
  set parentId(String value) => jsProxy['parentId'] = value;

  LayoutPosition get position => _createLayoutPosition(jsProxy['position']);
  set position(LayoutPosition value) => jsProxy['position'] = jsify(value);

  int get offset => jsProxy['offset'];
  set offset(int value) => jsProxy['offset'] = value;
}

class DisplayUnitInfo extends ChromeObject {
  DisplayUnitInfo({String id, String name, String mirroringSourceId, List<String> mirroringDestinationIds, bool isPrimary, bool isInternal, bool isEnabled, bool isUnified, bool isTabletMode, num dpiX, num dpiY, int rotation, Bounds bounds, Insets overscan, Bounds workArea, List<DisplayMode> modes, bool hasTouchSupport, bool hasAccelerometerSupport, num displayZoomFactor}) {
    if (id != null) this.id = id;
    if (name != null) this.name = name;
    if (mirroringSourceId != null) this.mirroringSourceId = mirroringSourceId;
    if (mirroringDestinationIds != null) this.mirroringDestinationIds = mirroringDestinationIds;
    if (isPrimary != null) this.isPrimary = isPrimary;
    if (isInternal != null) this.isInternal = isInternal;
    if (isEnabled != null) this.isEnabled = isEnabled;
    if (isUnified != null) this.isUnified = isUnified;
    if (isTabletMode != null) this.isTabletMode = isTabletMode;
    if (dpiX != null) this.dpiX = dpiX;
    if (dpiY != null) this.dpiY = dpiY;
    if (rotation != null) this.rotation = rotation;
    if (bounds != null) this.bounds = bounds;
    if (overscan != null) this.overscan = overscan;
    if (workArea != null) this.workArea = workArea;
    if (modes != null) this.modes = modes;
    if (hasTouchSupport != null) this.hasTouchSupport = hasTouchSupport;
    if (hasAccelerometerSupport != null) this.hasAccelerometerSupport = hasAccelerometerSupport;
    if (displayZoomFactor != null) this.displayZoomFactor = displayZoomFactor;
  }
  DisplayUnitInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  String get mirroringSourceId => jsProxy['mirroringSourceId'];
  set mirroringSourceId(String value) => jsProxy['mirroringSourceId'] = value;

  List<String> get mirroringDestinationIds => listify(jsProxy['mirroringDestinationIds']);
  set mirroringDestinationIds(List<String> value) => jsProxy['mirroringDestinationIds'] = jsify(value);

  bool get isPrimary => jsProxy['isPrimary'];
  set isPrimary(bool value) => jsProxy['isPrimary'] = value;

  bool get isInternal => jsProxy['isInternal'];
  set isInternal(bool value) => jsProxy['isInternal'] = value;

  bool get isEnabled => jsProxy['isEnabled'];
  set isEnabled(bool value) => jsProxy['isEnabled'] = value;

  bool get isUnified => jsProxy['isUnified'];
  set isUnified(bool value) => jsProxy['isUnified'] = value;

  bool get isTabletMode => jsProxy['isTabletMode'];
  set isTabletMode(bool value) => jsProxy['isTabletMode'] = value;

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

  List<DisplayMode> get modes => listify(jsProxy['modes'], _createDisplayMode);
  set modes(List<DisplayMode> value) => jsProxy['modes'] = jsify(value);

  bool get hasTouchSupport => jsProxy['hasTouchSupport'];
  set hasTouchSupport(bool value) => jsProxy['hasTouchSupport'] = value;

  bool get hasAccelerometerSupport => jsProxy['hasAccelerometerSupport'];
  set hasAccelerometerSupport(bool value) => jsProxy['hasAccelerometerSupport'] = value;

  num get displayZoomFactor => jsProxy['displayZoomFactor'];
  set displayZoomFactor(num value) => jsProxy['displayZoomFactor'] = jsify(value);
}

class DisplayProperties extends ChromeObject {
  DisplayProperties({bool isUnified, String mirroringSourceId, bool isPrimary, Insets overscan, int rotation, int boundsOriginX, int boundsOriginY, DisplayMode displayMode, num displayZoomFactor}) {
    if (isUnified != null) this.isUnified = isUnified;
    if (mirroringSourceId != null) this.mirroringSourceId = mirroringSourceId;
    if (isPrimary != null) this.isPrimary = isPrimary;
    if (overscan != null) this.overscan = overscan;
    if (rotation != null) this.rotation = rotation;
    if (boundsOriginX != null) this.boundsOriginX = boundsOriginX;
    if (boundsOriginY != null) this.boundsOriginY = boundsOriginY;
    if (displayMode != null) this.displayMode = displayMode;
    if (displayZoomFactor != null) this.displayZoomFactor = displayZoomFactor;
  }
  DisplayProperties.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  bool get isUnified => jsProxy['isUnified'];
  set isUnified(bool value) => jsProxy['isUnified'] = value;

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

  DisplayMode get displayMode => _createDisplayMode(jsProxy['displayMode']);
  set displayMode(DisplayMode value) => jsProxy['displayMode'] = jsify(value);

  num get displayZoomFactor => jsProxy['displayZoomFactor'];
  set displayZoomFactor(num value) => jsProxy['displayZoomFactor'] = jsify(value);
}

class GetInfoFlags extends ChromeObject {
  GetInfoFlags({bool singleUnified}) {
    if (singleUnified != null) this.singleUnified = singleUnified;
  }
  GetInfoFlags.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  bool get singleUnified => jsProxy['singleUnified'];
  set singleUnified(bool value) => jsProxy['singleUnified'] = value;
}

class MirrorModeInfo extends ChromeObject {
  MirrorModeInfo({MirrorMode mode, String mirroringSourceId, List<String> mirroringDestinationIds}) {
    if (mode != null) this.mode = mode;
    if (mirroringSourceId != null) this.mirroringSourceId = mirroringSourceId;
    if (mirroringDestinationIds != null) this.mirroringDestinationIds = mirroringDestinationIds;
  }
  MirrorModeInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  MirrorMode get mode => _createMirrorMode(jsProxy['mode']);
  set mode(MirrorMode value) => jsProxy['mode'] = jsify(value);

  String get mirroringSourceId => jsProxy['mirroringSourceId'];
  set mirroringSourceId(String value) => jsProxy['mirroringSourceId'] = value;

  List<String> get mirroringDestinationIds => listify(jsProxy['mirroringDestinationIds']);
  set mirroringDestinationIds(List<String> value) => jsProxy['mirroringDestinationIds'] = jsify(value);
}

DisplayUnitInfo _createDisplayUnitInfo(JsObject jsProxy) => jsProxy == null ? null : new DisplayUnitInfo.fromProxy(jsProxy);
DisplayLayout _createDisplayLayout(JsObject jsProxy) => jsProxy == null ? null : new DisplayLayout.fromProxy(jsProxy);
Point _createPoint(JsObject jsProxy) => jsProxy == null ? null : new Point.fromProxy(jsProxy);
TouchCalibrationPair _createTouchCalibrationPair(JsObject jsProxy) => jsProxy == null ? null : new TouchCalibrationPair.fromProxy(jsProxy);
LayoutPosition _createLayoutPosition(String value) => LayoutPosition.VALUES.singleWhere((ChromeEnum e) => e.value == value);
Bounds _createBounds(JsObject jsProxy) => jsProxy == null ? null : new Bounds.fromProxy(jsProxy);
Insets _createInsets(JsObject jsProxy) => jsProxy == null ? null : new Insets.fromProxy(jsProxy);
DisplayMode _createDisplayMode(JsObject jsProxy) => jsProxy == null ? null : new DisplayMode.fromProxy(jsProxy);
MirrorMode _createMirrorMode(String value) => MirrorMode.VALUES.singleWhere((ChromeEnum e) => e.value == value);

/**
 * The `chrome.system.memory` API.
 */
class ChromeSystemMemory extends ChromeApi {
  JsObject get _system_memory => chrome['system']['memory'];

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
  JsObject get _system_network => chrome['system']['network'];

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
  JsObject get _system_storage => chrome['system']['storage'];

  Stream<StorageUnitInfo> get onAttached => _onAttached.stream;
  ChromeStreamController<StorageUnitInfo> _onAttached;

  Stream<String> get onDetached => _onDetached.stream;
  ChromeStreamController<String> _onDetached;

  ChromeSystemStorage._() {
    var getApi = () => _system_storage;
    _onAttached = new ChromeStreamController<StorageUnitInfo>.oneArg(getApi, 'onAttached', _createStorageUnitInfo);
    _onDetached = new ChromeStreamController<String>.oneArg(getApi, 'onDetached', selfConverter);
  }

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
