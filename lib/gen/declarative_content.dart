/* This file has been generated from declarative_content.json - do not edit */

/**
 * Use the `chrome.declarativeContent` API to take actions depending on the
 * content of a page, without requiring permission to read the page's content.
 */
library chrome.declarativeContent;

import 'events.dart';
import '../src/common.dart';

/**
 * Accessor for the `chrome.declarativeContent` namespace.
 */
final ChromeDeclarativeContent declarativeContent = new ChromeDeclarativeContent._();

class ChromeDeclarativeContent extends ChromeApi {
  JsObject get _declarativeContent => chrome['declarativeContent'];

  Stream get onPageChanged => _onPageChanged.stream;
  ChromeStreamController _onPageChanged;

  ChromeDeclarativeContent._() {
    var getApi = () => _declarativeContent;
    _onPageChanged = new ChromeStreamController.noArgs(getApi, 'onPageChanged');
  }

  bool get available => _declarativeContent != null;
}

/**
 * See <a
 * href="https://developer.mozilla.org/en-US/docs/Web/API/ImageData">https://developer.mozilla.org/en-US/docs/Web/API/ImageData</a>.
 */
class DeclarativeContentImageDataType extends ChromeObject {
  DeclarativeContentImageDataType();
  DeclarativeContentImageDataType.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

/**
 * Matches the state of a web page by various criteria.
 */
class PageStateMatcher extends ChromeObject {
  PageStateMatcher({UrlFilter pageUrl, List<String> css}) {
    if (pageUrl != null) this.pageUrl = pageUrl;
    if (css != null) this.css = css;
  }
  PageStateMatcher.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Matches if the condition of the UrlFilter are fulfilled for the top-level
   * URL of the page.
   */
  UrlFilter get pageUrl => _createUrlFilter(jsProxy['pageUrl']);
  set pageUrl(UrlFilter value) => jsProxy['pageUrl'] = jsify(value);

  /**
   * Matches if all of the CSS selectors in the array match displayed elements
   * in a frame with the same origin as the page's main frame.  All selectors in
   * this array must be [compound
   * selectors](http://www.w3.org/TR/selectors4/#compound) to speed up matching.
   * Note that listing hundreds of CSS selectors or CSS selectors that match
   * hundreds of times per page can still slow down web sites.
   */
  List<String> get css => listify(jsProxy['css']);
  set css(List<String> value) => jsProxy['css'] = jsify(value);
}

/**
 * Declarative event action that shows the extension's $(ref:pageAction page
 * action) while the corresponding conditions are met.  This action can be used
 * without [host permissions](declare_permissions#host-permissions), but the
 * extension must have a page action.  If the extension takes the
 * [activeTab](activeTab.html) permission, a click on the page action will grant
 * access to the active tab.
 */
class ShowPageAction extends ChromeObject {
  ShowPageAction();
  ShowPageAction.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

/**
 * Declarative event action that sets the 19-<abbr title="device-independent
 * pixel">dip</abbr> square icon for the extension's $(ref:pageAction page
 * action) or $(ref:browserAction browser action) while the corresponding
 * conditions are met.  This action can be used without [host
 * permissions](declare_permissions.html#host-permissions), but the extension
 * must have  page or browser action.Exactly one of `imageData` or `path` must
 * be specified.  Both are dictionaries mapping a number of pixels to an image
 * representation. The image representation in `imageData` is
 * an[ImageData](https://developer.mozilla.org/en-US/docs/Web/API/ImageData)
 * object, for example from a `<canvas>` element, while the image representation
 * in `path` is the path to an image file relative to he extension's manifest.
 * If `scale` screen pixels fit into a device-independent pixel, the `scale *
 * 19` icon will be used.  If that scale is missing, the other image will be
 * resized to the needed size.
 */
class SetIcon extends ChromeObject {
  SetIcon({var imageData}) {
    if (imageData != null) this.imageData = imageData;
  }
  SetIcon.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

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
}

/**
 * Declarative event action that injects a content script. <b>WARNING:</b> This
 * action is still experimental and is not supported on stable builds of Chrome.
 */
class RequestContentScript extends ChromeObject {
  RequestContentScript({List<String> css, List<String> js, bool allFrames, bool matchAboutBlank}) {
    if (css != null) this.css = css;
    if (js != null) this.js = js;
    if (allFrames != null) this.allFrames = allFrames;
    if (matchAboutBlank != null) this.matchAboutBlank = matchAboutBlank;
  }
  RequestContentScript.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Names of CSS files to be injected as a part of the content script.
   */
  List<String> get css => listify(jsProxy['css']);
  set css(List<String> value) => jsProxy['css'] = jsify(value);

  /**
   * Names of Javascript files to be injected as a part of the content script.
   */
  List<String> get js => listify(jsProxy['js']);
  set js(List<String> value) => jsProxy['js'] = jsify(value);

  /**
   * Whether the content script runs in all frames of the matching page, or only
   * the top frame. Default is false.
   */
  bool get allFrames => jsProxy['allFrames'];
  set allFrames(bool value) => jsProxy['allFrames'] = value;

  /**
   * Whether to insert the content script on about:blank and about:srcdoc.
   * Default is false.
   */
  bool get matchAboutBlank => jsProxy['matchAboutBlank'];
  set matchAboutBlank(bool value) => jsProxy['matchAboutBlank'] = value;
}

UrlFilter _createUrlFilter(JsObject jsProxy) => jsProxy == null ? null : new UrlFilter.fromProxy(jsProxy);
