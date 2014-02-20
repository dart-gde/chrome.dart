/* This file has been generated from wallpaper.json - do not edit */

/**
 * none
 */
library chrome.wallpaper;

import '../src/common.dart';

/**
 * Accessor for the `chrome.wallpaper` namespace.
 */
final ChromeWallpaper wallpaper = new ChromeWallpaper._();

class ChromeWallpaper extends ChromeApi {
  static final JsObject _wallpaper = chrome['wallpaper'];

  ChromeWallpaper._();

  bool get available => _wallpaper != null;

  /**
   * Sets wallpaper to the image from url with specified layout
   */
  Future<dynamic> setWallpaper(WallpaperSetWallpaperParams details) {
    if (_wallpaper == null) _throwNotAvailable();

    var completer = new ChromeCompleter<dynamic>.oneArg();
    _wallpaper.callMethod('setWallpaper', [jsify(details), completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.wallpaper' is not available");
  }
}

class WallpaperSetWallpaperParams extends ChromeObject {
  WallpaperSetWallpaperParams({var wallpaperData, String url, String layout, String name, bool thumbnail}) {
    if (wallpaperData != null) this.wallpaperData = wallpaperData;
    if (url != null) this.url = url;
    if (layout != null) this.layout = layout;
    if (name != null) this.name = name;
    if (thumbnail != null) this.thumbnail = thumbnail;
  }
  WallpaperSetWallpaperParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The jpeg or png encoded wallpaper image.
   */
  dynamic get wallpaperData => jsProxy['wallpaperData'];
  set wallpaperData(var value) => jsProxy['wallpaperData'] = jsify(value);

  /**
   * The url of online wallpaper.
   */
  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;

  /**
   * The supported wallpaper layouts.
   * enum of `STRETCH`, `CENTER`, `CENTER_CROPPED`
   */
  String get layout => jsProxy['layout'];
  set layout(String value) => jsProxy['layout'] = value;

  /**
   * The file name of saved wallpaper.
   */
  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  /**
   * True if a 128x60 thumbnail should be generated.
   */
  bool get thumbnail => jsProxy['thumbnail'];
  set thumbnail(bool value) => jsProxy['thumbnail'] = value;
}
