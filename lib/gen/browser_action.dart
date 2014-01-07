/* This file has been generated from browser_action.json - do not edit */

/**
 * Use browser actions to put icons in the main Google Chrome toolbar, to the
 * right of the address bar. In addition to its [icon](#icon), a browser action
 * can also have a [tooltip](#tooltip), a [badge](#badge), and a <a href =
 * '#popups'>popup</a>.
 */
library chrome.browserAction;

import 'tabs.dart';
import '../src/common.dart';

/**
 * Accessor for the `chrome.browserAction` namespace.
 */
final ChromeBrowserAction browserAction = new ChromeBrowserAction._();

class ChromeBrowserAction extends ChromeApi {
  static final JsObject _browserAction = chrome['browserAction'];

  ChromeBrowserAction._();

  bool get available => _browserAction != null;

  /**
   * Sets the title of the browser action. This shows up in the tooltip.
   */
  void setTitle(BrowserActionSetTitleParams details) {
    if (_browserAction == null) _throwNotAvailable();

    _browserAction.callMethod('setTitle', [jsify(details)]);
  }

  /**
   * Gets the title of the browser action.
   */
  Future<String> getTitle(BrowserActionGetTitleParams details) {
    if (_browserAction == null) _throwNotAvailable();

    var completer = new ChromeCompleter<String>.oneArg();
    _browserAction.callMethod('getTitle', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Sets the icon for the browser action. The icon can be specified either as
   * the path to an image file or as the pixel data from a canvas element, or as
   * dictionary of either one of those. Either the <b>path</b> or the
   * <b>imageData</b> property must be specified.
   */
  Future setIcon(BrowserActionSetIconParams details) {
    if (_browserAction == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _browserAction.callMethod('setIcon', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Sets the html document to be opened as a popup when the user clicks on the
   * browser action's icon.
   */
  void setPopup(BrowserActionSetPopupParams details) {
    if (_browserAction == null) _throwNotAvailable();

    _browserAction.callMethod('setPopup', [jsify(details)]);
  }

  /**
   * Gets the html document set as the popup for this browser action.
   */
  Future<String> getPopup(BrowserActionGetPopupParams details) {
    if (_browserAction == null) _throwNotAvailable();

    var completer = new ChromeCompleter<String>.oneArg();
    _browserAction.callMethod('getPopup', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Sets the badge text for the browser action. The badge is displayed on top
   * of the icon.
   */
  void setBadgeText(BrowserActionSetBadgeTextParams details) {
    if (_browserAction == null) _throwNotAvailable();

    _browserAction.callMethod('setBadgeText', [jsify(details)]);
  }

  /**
   * Gets the badge text of the browser action. If no tab is specified, the
   * non-tab-specific badge text is returned.
   */
  Future<String> getBadgeText(BrowserActionGetBadgeTextParams details) {
    if (_browserAction == null) _throwNotAvailable();

    var completer = new ChromeCompleter<String>.oneArg();
    _browserAction.callMethod('getBadgeText', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Sets the background color for the badge.
   */
  void setBadgeBackgroundColor(BrowserActionSetBadgeBackgroundColorParams details) {
    if (_browserAction == null) _throwNotAvailable();

    _browserAction.callMethod('setBadgeBackgroundColor', [jsify(details)]);
  }

  /**
   * Gets the background color of the browser action.
   */
  Future<ColorArray> getBadgeBackgroundColor(BrowserActionGetBadgeBackgroundColorParams details) {
    if (_browserAction == null) _throwNotAvailable();

    var completer = new ChromeCompleter<ColorArray>.oneArg(_createColorArray);
    _browserAction.callMethod('getBadgeBackgroundColor', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Enables the browser action for a tab. By default, browser actions are
   * enabled.
   * 
   * [tabId] The id of the tab for which you want to modify the browser action.
   */
  void enable([int tabId]) {
    if (_browserAction == null) _throwNotAvailable();

    _browserAction.callMethod('enable', [tabId]);
  }

  /**
   * Disables the browser action for a tab.
   * 
   * [tabId] The id of the tab for which you want to modify the browser action.
   */
  void disable([int tabId]) {
    if (_browserAction == null) _throwNotAvailable();

    _browserAction.callMethod('disable', [tabId]);
  }

  /**
   * Opens the extension popup window in the active window but does not grant
   * tab permissions.
   * 
   * Returns:
   * JavaScript 'window' object for the popup window if it was succesfully
   * opened.
   */
  Future<Map<String, dynamic>> openPopup() {
    if (_browserAction == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Map<String, dynamic>>.oneArg(mapify);
    _browserAction.callMethod('openPopup', [completer.callback]);
    return completer.future;
  }

  /**
   * Fired when a browser action icon is clicked.  This event will not fire if
   * the browser action has a popup.
   */
  Stream<Tab> get onClicked => _onClicked.stream;

  final ChromeStreamController<Tab> _onClicked =
      new ChromeStreamController<Tab>.oneArg(_browserAction, 'onClicked', _createTab);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.browserAction' is not available");
  }
}

class ColorArray extends ChromeObject {
  ColorArray();
  ColorArray.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

/**
 * Pixel data for an image. Must be an ImageData object (for example, from a
 * `canvas` element).
 */
class ImageDataType extends ChromeObject {
  ImageDataType();
  ImageDataType.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

class BrowserActionSetTitleParams extends ChromeObject {
  BrowserActionSetTitleParams({String title, int tabId}) {
    if (title != null) this.title = title;
    if (tabId != null) this.tabId = tabId;
  }
  BrowserActionSetTitleParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The string the browser action should display when moused over.
   */
  String get title => jsProxy['title'];
  set title(String value) => jsProxy['title'] = value;

  /**
   * Limits the change to when a particular tab is selected. Automatically
   * resets when the tab is closed.
   */
  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;
}

class BrowserActionGetTitleParams extends ChromeObject {
  BrowserActionGetTitleParams({int tabId}) {
    if (tabId != null) this.tabId = tabId;
  }
  BrowserActionGetTitleParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Specify the tab to get the title from. If no tab is specified, the
   * non-tab-specific title is returned.
   */
  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;
}

class BrowserActionSetIconParams extends ChromeObject {
  BrowserActionSetIconParams({var imageData, var path, int tabId}) {
    if (imageData != null) this.imageData = imageData;
    if (path != null) this.path = path;
    if (tabId != null) this.tabId = tabId;
  }
  BrowserActionSetIconParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Either an ImageData object or a dictionary {size -> ImageData} representing
   * icon to be set. If the icon is specified as a dictionary, the actual image
   * to be used is chosen depending on screen's pixel density. If the number of
   * image pixels that fit into one screen space unit equals `scale`, then image
   * with size `scale` * 19 will be selected. Initially only scales 1 and 2 will
   * be supported. At least one image must be specified. Note that
   * 'details.imageData = foo' is equivalent to 'details.imageData = {'19':
   * foo}'
   */
  dynamic get imageData => jsProxy['imageData'];
  set imageData(var value) => jsProxy['imageData'] = jsify(value);

  /**
   * Either a relative image path or a dictionary {size -> relative image path}
   * pointing to icon to be set. If the icon is specified as a dictionary, the
   * actual image to be used is chosen depending on screen's pixel density. If
   * the number of image pixels that fit into one screen space unit equals
   * `scale`, then image with size `scale` * 19 will be selected. Initially only
   * scales 1 and 2 will be supported. At least one image must be specified.
   * Note that 'details.path = foo' is equivalent to 'details.imageData = {'19':
   * foo}'
   */
  dynamic get path => jsProxy['path'];
  set path(var value) => jsProxy['path'] = jsify(value);

  /**
   * Limits the change to when a particular tab is selected. Automatically
   * resets when the tab is closed.
   */
  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;
}

class BrowserActionSetPopupParams extends ChromeObject {
  BrowserActionSetPopupParams({int tabId, String popup}) {
    if (tabId != null) this.tabId = tabId;
    if (popup != null) this.popup = popup;
  }
  BrowserActionSetPopupParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Limits the change to when a particular tab is selected. Automatically
   * resets when the tab is closed.
   */
  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;

  /**
   * The html file to show in a popup.  If set to the empty string (''), no
   * popup is shown.
   */
  String get popup => jsProxy['popup'];
  set popup(String value) => jsProxy['popup'] = value;
}

class BrowserActionGetPopupParams extends ChromeObject {
  BrowserActionGetPopupParams({int tabId}) {
    if (tabId != null) this.tabId = tabId;
  }
  BrowserActionGetPopupParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Specify the tab to get the popup from. If no tab is specified, the
   * non-tab-specific popup is returned.
   */
  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;
}

class BrowserActionSetBadgeTextParams extends ChromeObject {
  BrowserActionSetBadgeTextParams({String text, int tabId}) {
    if (text != null) this.text = text;
    if (tabId != null) this.tabId = tabId;
  }
  BrowserActionSetBadgeTextParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Any number of characters can be passed, but only about four can fit in the
   * space.
   */
  String get text => jsProxy['text'];
  set text(String value) => jsProxy['text'] = value;

  /**
   * Limits the change to when a particular tab is selected. Automatically
   * resets when the tab is closed.
   */
  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;
}

class BrowserActionGetBadgeTextParams extends ChromeObject {
  BrowserActionGetBadgeTextParams({int tabId}) {
    if (tabId != null) this.tabId = tabId;
  }
  BrowserActionGetBadgeTextParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Specify the tab to get the badge text from. If no tab is specified, the
   * non-tab-specific badge text is returned.
   */
  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;
}

class BrowserActionSetBadgeBackgroundColorParams extends ChromeObject {
  BrowserActionSetBadgeBackgroundColorParams({var color, int tabId}) {
    if (color != null) this.color = color;
    if (tabId != null) this.tabId = tabId;
  }
  BrowserActionSetBadgeBackgroundColorParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * An array of four integers in the range [0,255] that make up the RGBA color
   * of the badge. For example, opaque red is `[255, 0, 0, 255]`. Can also be a
   * string with a CSS value, with opaque red being `#FF0000` or `#F00`.
   */
  dynamic get color => jsProxy['color'];
  set color(var value) => jsProxy['color'] = jsify(value);

  /**
   * Limits the change to when a particular tab is selected. Automatically
   * resets when the tab is closed.
   */
  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;
}

class BrowserActionGetBadgeBackgroundColorParams extends ChromeObject {
  BrowserActionGetBadgeBackgroundColorParams({int tabId}) {
    if (tabId != null) this.tabId = tabId;
  }
  BrowserActionGetBadgeBackgroundColorParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Specify the tab to get the badge background color from. If no tab is
   * specified, the non-tab-specific badge background color is returned.
   */
  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;
}

ColorArray _createColorArray(JsObject jsProxy) => jsProxy == null ? null : new ColorArray.fromProxy(jsProxy);
Tab _createTab(JsObject jsProxy) => jsProxy == null ? null : new Tab.fromProxy(jsProxy);
