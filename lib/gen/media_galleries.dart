/* This file has been generated from media_galleries.idl - do not edit */

/**
 * Use the `chrome.mediaGalleries` API to access media files (images, video,
 * audio) from the user's local disks (with the user's consent).
 */
library chrome.mediaGalleries;

import '../src/files.dart';
import '../src/common.dart';

/**
 * Accessor for the `chrome.mediaGalleries` namespace.
 */
final ChromeMediaGalleries mediaGalleries = new ChromeMediaGalleries._();

class ChromeMediaGalleries extends ChromeApi {
  static final JsObject _mediaGalleries = chrome['mediaGalleries'];

  ChromeMediaGalleries._();

  bool get available => _mediaGalleries != null;

  /**
   * Get the media galleries configured in this user agent. If none are
   * configured or available, the callback will receive an empty array.
   */
  Future<List<FileSystem>> getMediaFileSystems([MediaFileSystemsDetails details]) {
    if (_mediaGalleries == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<FileSystem>>.oneArg((e) => listify(e, _createDOMFileSystem));
    _mediaGalleries.callMethod('getMediaFileSystems', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Get metadata about a specific media file system.
   */
  MediaFileSystemMetadata getMediaFileSystemMetadata(FileSystem mediaFileSystem) {
    if (_mediaGalleries == null) _throwNotAvailable();

    return _createMediaFileSystemMetadata(_mediaGalleries.callMethod('getMediaFileSystemMetadata', [jsify(mediaFileSystem)]));
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.mediaGalleries' is not available");
  }
}

class GetMediaFileSystemsInteractivity extends ChromeEnum {
  static const GetMediaFileSystemsInteractivity NO = const GetMediaFileSystemsInteractivity._('no');
  static const GetMediaFileSystemsInteractivity YES = const GetMediaFileSystemsInteractivity._('yes');
  static const GetMediaFileSystemsInteractivity IF_NEEDED = const GetMediaFileSystemsInteractivity._('if_needed');

  static const List<GetMediaFileSystemsInteractivity> VALUES = const[NO, YES, IF_NEEDED];

  const GetMediaFileSystemsInteractivity._(String str): super(str);
}

class MediaFileSystemsDetails extends ChromeObject {
  MediaFileSystemsDetails({GetMediaFileSystemsInteractivity interactive}) {
    if (interactive != null) this.interactive = interactive;
  }
  MediaFileSystemsDetails.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  GetMediaFileSystemsInteractivity get interactive => _createGetMediaFileSystemsInteractivity(jsProxy['interactive']);
  set interactive(GetMediaFileSystemsInteractivity value) => jsProxy['interactive'] = jsify(value);
}

class MediaFileSystemMetadata extends ChromeObject {
  MediaFileSystemMetadata({String name, String galleryId, String deviceId, bool isRemovable, bool isMediaDevice}) {
    if (name != null) this.name = name;
    if (galleryId != null) this.galleryId = galleryId;
    if (deviceId != null) this.deviceId = deviceId;
    if (isRemovable != null) this.isRemovable = isRemovable;
    if (isMediaDevice != null) this.isMediaDevice = isMediaDevice;
  }
  MediaFileSystemMetadata.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  String get galleryId => jsProxy['galleryId'];
  set galleryId(String value) => jsProxy['galleryId'] = value;

  String get deviceId => jsProxy['deviceId'];
  set deviceId(String value) => jsProxy['deviceId'] = value;

  bool get isRemovable => jsProxy['isRemovable'];
  set isRemovable(bool value) => jsProxy['isRemovable'] = value;

  bool get isMediaDevice => jsProxy['isMediaDevice'];
  set isMediaDevice(bool value) => jsProxy['isMediaDevice'] = value;
}

FileSystem _createDOMFileSystem(JsObject jsProxy) => jsProxy == null ? null : new CrFileSystem.fromProxy(jsProxy);
MediaFileSystemMetadata _createMediaFileSystemMetadata(JsObject jsProxy) => jsProxy == null ? null : new MediaFileSystemMetadata.fromProxy(jsProxy);
GetMediaFileSystemsInteractivity _createGetMediaFileSystemsInteractivity(String value) => GetMediaFileSystemsInteractivity.VALUES.singleWhere((ChromeEnum e) => e.value == value);
