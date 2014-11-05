/* This file has been generated from media_galleries.idl - do not edit */

/**
 * Use the `chrome.mediaGalleries` API to access media files (audio, images,
 * video) from the user's local disks (with the user's consent).
 */
library chrome.mediaGalleries;

import '../src/files.dart';
import '../src/common.dart';

/**
 * Accessor for the `chrome.mediaGalleries` namespace.
 */
final ChromeMediaGalleries mediaGalleries = new ChromeMediaGalleries._();

class ChromeMediaGalleries extends ChromeApi {
  JsObject get _mediaGalleries => chrome['mediaGalleries'];

  Stream<GalleryChangeDetails> get onGalleryChanged => _onGalleryChanged.stream;
  ChromeStreamController<GalleryChangeDetails> _onGalleryChanged;

  Stream<ScanProgressDetails> get onScanProgress => _onScanProgress.stream;
  ChromeStreamController<ScanProgressDetails> _onScanProgress;

  ChromeMediaGalleries._() {
    var getApi = () => _mediaGalleries;
    _onGalleryChanged = new ChromeStreamController<GalleryChangeDetails>.oneArg(getApi, 'onGalleryChanged', _createGalleryChangeDetails);
    _onScanProgress = new ChromeStreamController<ScanProgressDetails>.oneArg(getApi, 'onScanProgress', _createScanProgressDetails);
  }

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
   * Present a directory picker to the user and add the selected directory as a
   * gallery. If the user cancels the picker, selectedFileSystemName will be
   * empty. A user gesture is required for the dialog to display. Without a user
   * gesture, the callback will run as though the user canceled.
   * 
   * Returns:
   * [mediaFileSystems] null
   * [selectedFileSystemName] null
   */
  Future<AddUserSelectedFolderResult> addUserSelectedFolder() {
    if (_mediaGalleries == null) _throwNotAvailable();

    var completer = new ChromeCompleter<AddUserSelectedFolderResult>.twoArgs(AddUserSelectedFolderResult._create);
    _mediaGalleries.callMethod('addUserSelectedFolder', [completer.callback]);
    return completer.future;
  }

  /**
   * Give up access to a given media gallery.
   */
  Future dropPermissionForMediaFileSystem(String galleryId) {
    if (_mediaGalleries == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _mediaGalleries.callMethod('dropPermissionForMediaFileSystem', [galleryId, completer.callback]);
    return completer.future;
  }

  /**
   * Start a scan of the user's hard disks for directories containing media. The
   * scan may take a long time so progress and completion is communicated by
   * events. No permission is granted as a result of the scan, see
   * addScanResults.
   */
  void startMediaScan() {
    if (_mediaGalleries == null) _throwNotAvailable();

    _mediaGalleries.callMethod('startMediaScan');
  }

  /**
   * Cancel any pending media scan. Well behaved apps should provide a way for
   * the user to cancel scans they start.
   */
  void cancelMediaScan() {
    if (_mediaGalleries == null) _throwNotAvailable();

    _mediaGalleries.callMethod('cancelMediaScan');
  }

  /**
   * Show the user the scan results and let them add any or all of them as
   * galleries. This should be used after the 'finish' onScanProgress() event
   * has happened. All galleries the app has access to are returned, not just
   * the newly added galleries.
   */
  Future<List<FileSystem>> addScanResults() {
    if (_mediaGalleries == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<FileSystem>>.oneArg((e) => listify(e, _createDOMFileSystem));
    _mediaGalleries.callMethod('addScanResults', [completer.callback]);
    return completer.future;
  }

  /**
   * Get metadata about a specific media file system.
   */
  MediaFileSystemMetadata getMediaFileSystemMetadata(FileSystem mediaFileSystem) {
    if (_mediaGalleries == null) _throwNotAvailable();

    return _createMediaFileSystemMetadata(_mediaGalleries.callMethod('getMediaFileSystemMetadata', [jsify(mediaFileSystem)]));
  }

  /**
   * Get metadata for all available media galleries.
   */
  Future<List<MediaFileSystemMetadata>> getAllMediaFileSystemMetadata() {
    if (_mediaGalleries == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<MediaFileSystemMetadata>>.oneArg((e) => listify(e, _createMediaFileSystemMetadata));
    _mediaGalleries.callMethod('getAllMediaFileSystemMetadata', [completer.callback]);
    return completer.future;
  }

  /**
   * Gets the media-specific metadata for a media file. This should work for
   * files in media galleries as well as other DOM filesystems.
   */
  Future<MediaMetadata> getMetadata(Blob mediaFile, [MediaMetadataOptions options]) {
    if (_mediaGalleries == null) _throwNotAvailable();

    var completer = new ChromeCompleter<MediaMetadata>.oneArg(_createMediaMetadata);
    _mediaGalleries.callMethod('getMetadata', [jsify(mediaFile), jsify(options), completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.mediaGalleries' is not available");
  }
}

class GalleryChangeType extends ChromeEnum {
  static const GalleryChangeType CONTENTS_CHANGED = const GalleryChangeType._('contents_changed');
  static const GalleryChangeType WATCH_DROPPED = const GalleryChangeType._('watch_dropped');

  static const List<GalleryChangeType> VALUES = const[CONTENTS_CHANGED, WATCH_DROPPED];

  const GalleryChangeType._(String str): super(str);
}

class GetMediaFileSystemsInteractivity extends ChromeEnum {
  static const GetMediaFileSystemsInteractivity NO = const GetMediaFileSystemsInteractivity._('no');
  static const GetMediaFileSystemsInteractivity YES = const GetMediaFileSystemsInteractivity._('yes');
  static const GetMediaFileSystemsInteractivity IF_NEEDED = const GetMediaFileSystemsInteractivity._('if_needed');

  static const List<GetMediaFileSystemsInteractivity> VALUES = const[NO, YES, IF_NEEDED];

  const GetMediaFileSystemsInteractivity._(String str): super(str);
}

class GetMetadataType extends ChromeEnum {
  static const GetMetadataType ALL = const GetMetadataType._('all');
  static const GetMetadataType MIME_TYPE_AND_TAGS = const GetMetadataType._('mimeTypeAndTags');
  static const GetMetadataType MIME_TYPE_ONLY = const GetMetadataType._('mimeTypeOnly');

  static const List<GetMetadataType> VALUES = const[ALL, MIME_TYPE_AND_TAGS, MIME_TYPE_ONLY];

  const GetMetadataType._(String str): super(str);
}

class ScanProgressType extends ChromeEnum {
  static const ScanProgressType START = const ScanProgressType._('start');
  static const ScanProgressType CANCEL = const ScanProgressType._('cancel');
  static const ScanProgressType FINISH = const ScanProgressType._('finish');
  static const ScanProgressType ERROR = const ScanProgressType._('error');

  static const List<ScanProgressType> VALUES = const[START, CANCEL, FINISH, ERROR];

  const ScanProgressType._(String str): super(str);
}

class GalleryChangeDetails extends ChromeObject {
  GalleryChangeDetails({GalleryChangeType type, String galleryId}) {
    if (type != null) this.type = type;
    if (galleryId != null) this.galleryId = galleryId;
  }
  GalleryChangeDetails.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  GalleryChangeType get type => _createGalleryChangeType(jsProxy['type']);
  set type(GalleryChangeType value) => jsProxy['type'] = jsify(value);

  String get galleryId => jsProxy['galleryId'];
  set galleryId(String value) => jsProxy['galleryId'] = value;
}

class MediaFileSystemsDetails extends ChromeObject {
  MediaFileSystemsDetails({GetMediaFileSystemsInteractivity interactive}) {
    if (interactive != null) this.interactive = interactive;
  }
  MediaFileSystemsDetails.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  GetMediaFileSystemsInteractivity get interactive => _createGetMediaFileSystemsInteractivity(jsProxy['interactive']);
  set interactive(GetMediaFileSystemsInteractivity value) => jsProxy['interactive'] = jsify(value);
}

class MediaMetadataOptions extends ChromeObject {
  MediaMetadataOptions({GetMetadataType metadataType}) {
    if (metadataType != null) this.metadataType = metadataType;
  }
  MediaMetadataOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  GetMetadataType get metadataType => _createGetMetadataType(jsProxy['metadataType']);
  set metadataType(GetMetadataType value) => jsProxy['metadataType'] = jsify(value);
}

class MediaFileSystemMetadata extends ChromeObject {
  MediaFileSystemMetadata({String name, String galleryId, String deviceId, bool isRemovable, bool isMediaDevice, bool isAvailable}) {
    if (name != null) this.name = name;
    if (galleryId != null) this.galleryId = galleryId;
    if (deviceId != null) this.deviceId = deviceId;
    if (isRemovable != null) this.isRemovable = isRemovable;
    if (isMediaDevice != null) this.isMediaDevice = isMediaDevice;
    if (isAvailable != null) this.isAvailable = isAvailable;
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

  bool get isAvailable => jsProxy['isAvailable'];
  set isAvailable(bool value) => jsProxy['isAvailable'] = value;
}

class ScanProgressDetails extends ChromeObject {
  ScanProgressDetails({ScanProgressType type, int galleryCount, int audioCount, int imageCount, int videoCount}) {
    if (type != null) this.type = type;
    if (galleryCount != null) this.galleryCount = galleryCount;
    if (audioCount != null) this.audioCount = audioCount;
    if (imageCount != null) this.imageCount = imageCount;
    if (videoCount != null) this.videoCount = videoCount;
  }
  ScanProgressDetails.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  ScanProgressType get type => _createScanProgressType(jsProxy['type']);
  set type(ScanProgressType value) => jsProxy['type'] = jsify(value);

  int get galleryCount => jsProxy['galleryCount'];
  set galleryCount(int value) => jsProxy['galleryCount'] = value;

  int get audioCount => jsProxy['audioCount'];
  set audioCount(int value) => jsProxy['audioCount'] = value;

  int get imageCount => jsProxy['imageCount'];
  set imageCount(int value) => jsProxy['imageCount'] = value;

  int get videoCount => jsProxy['videoCount'];
  set videoCount(int value) => jsProxy['videoCount'] = value;
}

class StreamInfo extends ChromeObject {
  StreamInfo({String type, var tags}) {
    if (type != null) this.type = type;
    if (tags != null) this.tags = tags;
  }
  StreamInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get type => jsProxy['type'];
  set type(String value) => jsProxy['type'] = value;

  dynamic get tags => jsProxy['tags'];
  set tags(var value) => jsProxy['tags'] = jsify(value);
}

class MediaMetadata extends ChromeObject {
  MediaMetadata({String mimeType, int height, int width, num xResolution, num yResolution, num duration, int rotation, String cameraMake, String cameraModel, num exposureTimeSeconds, bool flashFired, num fNumber, num focalLengthMm, num isoEquivalent, String album, String artist, String comment, String copyright, int disc, String genre, String language, String title, int track, List<StreamInfo> rawTags, List<dynamic> attachedImages}) {
    if (mimeType != null) this.mimeType = mimeType;
    if (height != null) this.height = height;
    if (width != null) this.width = width;
    if (xResolution != null) this.xResolution = xResolution;
    if (yResolution != null) this.yResolution = yResolution;
    if (duration != null) this.duration = duration;
    if (rotation != null) this.rotation = rotation;
    if (cameraMake != null) this.cameraMake = cameraMake;
    if (cameraModel != null) this.cameraModel = cameraModel;
    if (exposureTimeSeconds != null) this.exposureTimeSeconds = exposureTimeSeconds;
    if (flashFired != null) this.flashFired = flashFired;
    if (fNumber != null) this.fNumber = fNumber;
    if (focalLengthMm != null) this.focalLengthMm = focalLengthMm;
    if (isoEquivalent != null) this.isoEquivalent = isoEquivalent;
    if (album != null) this.album = album;
    if (artist != null) this.artist = artist;
    if (comment != null) this.comment = comment;
    if (copyright != null) this.copyright = copyright;
    if (disc != null) this.disc = disc;
    if (genre != null) this.genre = genre;
    if (language != null) this.language = language;
    if (title != null) this.title = title;
    if (track != null) this.track = track;
    if (rawTags != null) this.rawTags = rawTags;
    if (attachedImages != null) this.attachedImages = attachedImages;
  }
  MediaMetadata.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get mimeType => jsProxy['mimeType'];
  set mimeType(String value) => jsProxy['mimeType'] = value;

  int get height => jsProxy['height'];
  set height(int value) => jsProxy['height'] = value;

  int get width => jsProxy['width'];
  set width(int value) => jsProxy['width'] = value;

  num get xResolution => jsProxy['xResolution'];
  set xResolution(num value) => jsProxy['xResolution'] = jsify(value);

  num get yResolution => jsProxy['yResolution'];
  set yResolution(num value) => jsProxy['yResolution'] = jsify(value);

  num get duration => jsProxy['duration'];
  set duration(num value) => jsProxy['duration'] = jsify(value);

  int get rotation => jsProxy['rotation'];
  set rotation(int value) => jsProxy['rotation'] = value;

  String get cameraMake => jsProxy['cameraMake'];
  set cameraMake(String value) => jsProxy['cameraMake'] = value;

  String get cameraModel => jsProxy['cameraModel'];
  set cameraModel(String value) => jsProxy['cameraModel'] = value;

  num get exposureTimeSeconds => jsProxy['exposureTimeSeconds'];
  set exposureTimeSeconds(num value) => jsProxy['exposureTimeSeconds'] = jsify(value);

  bool get flashFired => jsProxy['flashFired'];
  set flashFired(bool value) => jsProxy['flashFired'] = value;

  num get fNumber => jsProxy['fNumber'];
  set fNumber(num value) => jsProxy['fNumber'] = jsify(value);

  num get focalLengthMm => jsProxy['focalLengthMm'];
  set focalLengthMm(num value) => jsProxy['focalLengthMm'] = jsify(value);

  num get isoEquivalent => jsProxy['isoEquivalent'];
  set isoEquivalent(num value) => jsProxy['isoEquivalent'] = jsify(value);

  String get album => jsProxy['album'];
  set album(String value) => jsProxy['album'] = value;

  String get artist => jsProxy['artist'];
  set artist(String value) => jsProxy['artist'] = value;

  String get comment => jsProxy['comment'];
  set comment(String value) => jsProxy['comment'] = value;

  String get copyright => jsProxy['copyright'];
  set copyright(String value) => jsProxy['copyright'] = value;

  int get disc => jsProxy['disc'];
  set disc(int value) => jsProxy['disc'] = value;

  String get genre => jsProxy['genre'];
  set genre(String value) => jsProxy['genre'] = value;

  String get language => jsProxy['language'];
  set language(String value) => jsProxy['language'] = value;

  String get title => jsProxy['title'];
  set title(String value) => jsProxy['title'] = value;

  int get track => jsProxy['track'];
  set track(int value) => jsProxy['track'] = value;

  List<StreamInfo> get rawTags => listify(jsProxy['rawTags'], _createStreamInfo);
  set rawTags(List<StreamInfo> value) => jsProxy['rawTags'] = jsify(value);

  List<dynamic> get attachedImages => listify(jsProxy['attachedImages']);
  set attachedImages(List<dynamic> value) => jsProxy['attachedImages'] = jsify(value);
}

/**
 * The return type for [addUserSelectedFolder].
 */
class AddUserSelectedFolderResult {
  static AddUserSelectedFolderResult _create(mediaFileSystems, selectedFileSystemName) {
    return new AddUserSelectedFolderResult._(listify(mediaFileSystems, _createDOMFileSystem), selectedFileSystemName);
  }

  List<FileSystem> mediaFileSystems;
  String selectedFileSystemName;

  AddUserSelectedFolderResult._(this.mediaFileSystems, this.selectedFileSystemName);
}

GalleryChangeDetails _createGalleryChangeDetails(JsObject jsProxy) => jsProxy == null ? null : new GalleryChangeDetails.fromProxy(jsProxy);
ScanProgressDetails _createScanProgressDetails(JsObject jsProxy) => jsProxy == null ? null : new ScanProgressDetails.fromProxy(jsProxy);
FileSystem _createDOMFileSystem(JsObject jsProxy) => jsProxy == null ? null : new CrFileSystem.fromProxy(jsProxy);
MediaFileSystemMetadata _createMediaFileSystemMetadata(JsObject jsProxy) => jsProxy == null ? null : new MediaFileSystemMetadata.fromProxy(jsProxy);
MediaMetadata _createMediaMetadata(JsObject jsProxy) => jsProxy == null ? null : new MediaMetadata.fromProxy(jsProxy);
GalleryChangeType _createGalleryChangeType(String value) => GalleryChangeType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
GetMediaFileSystemsInteractivity _createGetMediaFileSystemsInteractivity(String value) => GetMediaFileSystemsInteractivity.VALUES.singleWhere((ChromeEnum e) => e.value == value);
GetMetadataType _createGetMetadataType(String value) => GetMetadataType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
ScanProgressType _createScanProgressType(String value) => ScanProgressType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
StreamInfo _createStreamInfo(JsObject jsProxy) => jsProxy == null ? null : new StreamInfo.fromProxy(jsProxy);
