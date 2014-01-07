/* This file has been generated from page_action.json - do not edit */

/**
 * Use the `chrome.pageAction` API to put icons inside the address bar. Page
 * actions represent actions that can be taken on the current page, but that
 * aren't applicable to all pages.
 */
library chrome.pageAction;

import 'tabs.dart';
import '../src/common.dart';

/**
 * Accessor for the `chrome.pageAction` namespace.
 */
final ChromePageAction pageAction = new ChromePageAction._();

class ChromePageAction extends ChromeApi {
  static final JsObject _pageAction = chrome['pageAction'];

  ChromePageAction._();

  bool get available => _pageAction != null;

  /**
   * Shows the page action. The page action is shown whenever the tab is
   * selected.
   * 
   * [tabId] The id of the tab for which you want to modify the page action.
   */
  void show(int tabId) {
    if (_pageAction == null) _throwNotAvailable();

    _pageAction.callMethod('show', [tabId]);
  }

  /**
   * Hides the page action.
   * 
   * [tabId] The id of the tab for which you want to modify the page action.
   */
  void hide(int tabId) {
    if (_pageAction == null) _throwNotAvailable();

    _pageAction.callMethod('hide', [tabId]);
  }

  /**
   * Sets the title of the page action. This is displayed in a tooltip over the
   * page action.
   */
  void setTitle(PageActionSetTitleParams details) {
    if (_pageAction == null) _throwNotAvailable();

    _pageAction.callMethod('setTitle', [jsify(details)]);
  }

  /**
   * Gets the title of the page action.
   */
  Future<String> getTitle(PageActionGetTitleParams details) {
    if (_pageAction == null) _throwNotAvailable();

    var completer = new ChromeCompleter<String>.oneArg();
    _pageAction.callMethod('getTitle', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Sets the icon for the page action. The icon can be specified either as the
   * path to an image file or as the pixel data from a canvas element, or as
   * dictionary of either one of those. Either the <b>path</b> or the
   * <b>imageData</b> property must be specified.
   */
  Future setIcon(PageActionSetIconParams details) {
    if (_pageAction == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _pageAction.callMethod('setIcon', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Sets the html document to be opened as a popup when the user clicks on the
   * page action's icon.
   */
  void setPopup(PageActionSetPopupParams details) {
    if (_pageAction == null) _throwNotAvailable();

    _pageAction.callMethod('setPopup', [jsify(details)]);
  }

  /**
   * Gets the html document set as the popup for this page action.
   */
  Future<String> getPopup(PageActionGetPopupParams details) {
    if (_pageAction == null) _throwNotAvailable();

    var completer = new ChromeCompleter<String>.oneArg();
    _pageAction.callMethod('getPopup', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Fired when a page action icon is clicked.  This event will not fire if the
   * page action has a popup.
   */
  Stream<Tab> get onClicked => _onClicked.stream;

  final ChromeStreamController<Tab> _onClicked =
      new ChromeStreamController<Tab>.oneArg(_pageAction, 'onClicked', _createTab);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.pageAction' is not available");
  }
}

class PageActionSetTitleParams extends ChromeObject {
  PageActionSetTitleParams({int tabId, String title}) {
    if (tabId != null) this.tabId = tabId;
    if (title != null) this.title = title;
  }
  PageActionSetTitleParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The id of the tab for which you want to modify the page action.
   */
  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;

  /**
   * The tooltip string.
   */
  String get title => jsProxy['title'];
  set title(String value) => jsProxy['title'] = value;
}

class PageActionGetTitleParams extends ChromeObject {
  PageActionGetTitleParams({int tabId}) {
    if (tabId != null) this.tabId = tabId;
  }
  PageActionGetTitleParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Specify the tab to get the title from.
   */
  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;
}

class PageActionSetIconParams extends ChromeObject {
  PageActionSetIconParams({int tabId, var imageData, var path, int iconIndex}) {
    if (tabId != null) this.tabId = tabId;
    if (imageData != null) this.imageData = imageData;
    if (path != null) this.path = path;
    if (iconIndex != null) this.iconIndex = iconIndex;
  }
  PageActionSetIconParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The id of the tab for which you want to modify the page action.
   */
  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;

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
   * <b>Deprecated.</b> This argument is ignored.
   */
  int get iconIndex => jsProxy['iconIndex'];
  set iconIndex(int value) => jsProxy['iconIndex'] = value;
}

class PageActionSetPopupParams extends ChromeObject {
  PageActionSetPopupParams({int tabId, String popup}) {
    if (tabId != null) this.tabId = tabId;
    if (popup != null) this.popup = popup;
  }
  PageActionSetPopupParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The id of the tab for which you want to modify the page action.
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

class PageActionGetPopupParams extends ChromeObject {
  PageActionGetPopupParams({int tabId}) {
    if (tabId != null) this.tabId = tabId;
  }
  PageActionGetPopupParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Specify the tab to get the popup from.
   */
  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;
}

Tab _createTab(JsObject jsProxy) => jsProxy == null ? null : new Tab.fromProxy(jsProxy);
