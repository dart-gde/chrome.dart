/* This file has been generated from extension_types.json - do not edit */

/**
 * The `chrome.extensionTypes` API contains type declarations for Chrome
 * extensions.
 */
library chrome.extensionTypes;

import '../src/common.dart';

/**
 * Accessor for the `chrome.extensionTypes` namespace.
 */
final ChromeExtensionTypes extensionTypes = new ChromeExtensionTypes._();

class ChromeExtensionTypes extends ChromeApi {
  JsObject get _extensionTypes => chrome['extensionTypes'];

  ChromeExtensionTypes._();

  bool get available => _extensionTypes != null;
}

/**
 * The format of an image.
 * enum of `jpeg`, `png`
 */
class ImageFormat extends ChromeObject {
  ImageFormat();
  ImageFormat.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

/**
 * Details about the format and quality of an image.
 */
class ImageDetails extends ChromeObject {
  ImageDetails({ImageFormat format, int quality}) {
    if (format != null) this.format = format;
    if (quality != null) this.quality = quality;
  }
  ImageDetails.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The format of the resulting image.  Default is `"jpeg"`.
   */
  ImageFormat get format => _createImageFormat(jsProxy['format']);
  set format(ImageFormat value) => jsProxy['format'] = jsify(value);

  /**
   * When format is `"jpeg"`, controls the quality of the resulting image.  This
   * value is ignored for PNG images.  As quality is decreased, the resulting
   * image will have more visual artifacts, and the number of bytes needed to
   * store it will decrease.
   */
  int get quality => jsProxy['quality'];
  set quality(int value) => jsProxy['quality'] = value;
}

/**
 * The soonest that the JavaScript or CSS will be injected into the tab.
 * enum of `document_start`, `document_end`, `document_idle`
 */
class RunAt extends ChromeObject {
  RunAt();
  RunAt.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

/**
 * Details of the script or CSS to inject. Either the code or the file property
 * must be set, but both may not be set at the same time.
 */
class InjectDetails extends ChromeObject {
  InjectDetails({String code, String file, bool allFrames, bool matchAboutBlank, RunAt runAt}) {
    if (code != null) this.code = code;
    if (file != null) this.file = file;
    if (allFrames != null) this.allFrames = allFrames;
    if (matchAboutBlank != null) this.matchAboutBlank = matchAboutBlank;
    if (runAt != null) this.runAt = runAt;
  }
  InjectDetails.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * JavaScript or CSS code to inject.<br><br><b>Warning:</b><br>Be careful
   * using the `code` parameter. Incorrect use of it may open your extension to
   * [cross site scripting](https://en.wikipedia.org/wiki/Cross-site_scripting)
   * attacks.
   */
  String get code => jsProxy['code'];
  set code(String value) => jsProxy['code'] = value;

  /**
   * JavaScript or CSS file to inject.
   */
  String get file => jsProxy['file'];
  set file(String value) => jsProxy['file'] = value;

  /**
   * If allFrames is `true`, implies that the JavaScript or CSS should be
   * injected into all frames of current page. By default, it's `false` and is
   * only injected into the top frame.
   */
  bool get allFrames => jsProxy['allFrames'];
  set allFrames(bool value) => jsProxy['allFrames'] = value;

  /**
   * If matchAboutBlank is true, then the code is also injected in about:blank
   * and about:srcdoc frames if your extension has access to its parent
   * document. Code cannot be inserted in top-level about:-frames. By default it
   * is `false`.
   */
  bool get matchAboutBlank => jsProxy['matchAboutBlank'];
  set matchAboutBlank(bool value) => jsProxy['matchAboutBlank'] = value;

  /**
   * The soonest that the JavaScript or CSS will be injected into the tab.
   * Defaults to "document_idle".
   */
  RunAt get runAt => _createRunAt(jsProxy['runAt']);
  set runAt(RunAt value) => jsProxy['runAt'] = jsify(value);
}

ImageFormat _createImageFormat(JsObject jsProxy) => jsProxy == null ? null : new ImageFormat.fromProxy(jsProxy);
RunAt _createRunAt(JsObject jsProxy) => jsProxy == null ? null : new RunAt.fromProxy(jsProxy);
