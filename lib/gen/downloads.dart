/* This file has been generated from downloads.idl - do not edit */

/**
 * Use the `chrome.downloads` API to programmatically initiate, monitor,
 * manipulate, and search for downloads.
 */
library chrome.downloads;

import '../src/common.dart';

/**
 * Accessor for the `chrome.downloads` namespace.
 */
final ChromeDownloads downloads = new ChromeDownloads._();

class ChromeDownloads extends ChromeApi {
  static final JsObject _downloads = chrome['downloads'];

  ChromeDownloads._();

  bool get available => _downloads != null;

  /**
   * Download a URL. If the URL uses the HTTP[S] protocol, then the request will
   * include all cookies currently set for its hostname. If both `filename` and
   * `saveAs` are specified, then the Save As dialog will be displayed,
   * pre-populated with the specified `filename`. If the download started
   * successfully, `callback` will be called with the new [DownloadItem]'s
   * `downloadId`. If there was an error starting the download, then `callback`
   * will be called with `downloadId=undefined` and [runtime.lastError] will
   * contain a descriptive string. The error strings are not guaranteed to
   * remain backwards compatible between releases. Extensions must not parse it.
   * [options]: What to download and how.
   * [callback]: Called with the id of the new [DownloadItem].
   */
  Future<int> download(DownloadOptions options) {
    if (_downloads == null) _throwNotAvailable();

    var completer = new ChromeCompleter<int>.oneArg();
    _downloads.callMethod('download', [jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Find [DownloadItem]. Set `query` to the empty object to get all
   * [DownloadItem]. To get a specific [DownloadItem], set only the `id` field.
   * To page through a large number of items, set `orderBy: ['-startTime']`, set
   * `limit` to the number of items per page, and set `startedAfter` to the
   * `startTime` of the last item from the last page.
   */
  Future<List<DownloadItem>> search(DownloadQuery query) {
    if (_downloads == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<DownloadItem>>.oneArg((e) => listify(e, _createDownloadItem));
    _downloads.callMethod('search', [jsify(query), completer.callback]);
    return completer.future;
  }

  /**
   * Pause the download. If the request was successful the download is in a
   * paused state. Otherwise [runtime.lastError] contains an error message. The
   * request will fail if the download is not active.
   * [downloadId]: The id of the download to pause.
   * [callback]: Called when the pause request is completed.
   */
  Future pause(int downloadId) {
    if (_downloads == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _downloads.callMethod('pause', [downloadId, completer.callback]);
    return completer.future;
  }

  /**
   * Resume a paused download. If the request was successful the download is in
   * progress and unpaused. Otherwise [runtime.lastError] contains an error
   * message. The request will fail if the download is not active.
   * [downloadId]: The id of the download to resume.
   * [callback]: Called when the resume request is completed.
   */
  Future resume(int downloadId) {
    if (_downloads == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _downloads.callMethod('resume', [downloadId, completer.callback]);
    return completer.future;
  }

  /**
   * Cancel a download. When `callback` is run, the download is cancelled,
   * completed, interrupted or doesn't exist anymore.
   * [downloadId]: The id of the download to cancel.
   * [callback]: Called when the cancel request is completed.
   */
  Future cancel(int downloadId) {
    if (_downloads == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _downloads.callMethod('cancel', [downloadId, completer.callback]);
    return completer.future;
  }

  /**
   * Retrieve an icon for the specified download. For new downloads, file icons
   * are available after the [onCreated] event has been received. The image
   * returned by this function while a download is in progress may be different
   * from the image returned after the download is complete. Icon retrieval is
   * done by querying the underlying operating system or toolkit depending on
   * the platform. The icon that is returned will therefore depend on a number
   * of factors including state of the download, platform, registered file types
   * and visual theme. If a file icon cannot be determined, [runtime.lastError]
   * will contain an error message.
   * [downloadId]: The identifier for the download.
   * [callback]: A URL to an image that represents the download.
   */
  Future<String> getFileIcon(int downloadId, [GetFileIconOptions options]) {
    if (_downloads == null) _throwNotAvailable();

    var completer = new ChromeCompleter<String>.oneArg();
    _downloads.callMethod('getFileIcon', [downloadId, jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Open the downloaded file now if the [DownloadItem] is complete; otherwise
   * returns an error through [runtime.lastError]. Requires the
   * `"downloads.open"` permission in addition to the `"downloads"` permission.
   * An [onChanged] event will fire when the item is opened for the first time.
   * [downloadId]: The identifier for the downloaded file.
   */
  void open(int downloadId) {
    if (_downloads == null) _throwNotAvailable();

    _downloads.callMethod('open', [downloadId]);
  }

  /**
   * Show the downloaded file in its folder in a file manager.
   * [downloadId]: The identifier for the downloaded file.
   */
  void show(int downloadId) {
    if (_downloads == null) _throwNotAvailable();

    _downloads.callMethod('show', [downloadId]);
  }

  /**
   * Show the default Downloads folder in a file manager.
   */
  void showDefaultFolder() {
    if (_downloads == null) _throwNotAvailable();

    _downloads.callMethod('showDefaultFolder');
  }

  /**
   * Erase matching [DownloadItem] from history without deleting the downloaded
   * file. An [onErased] event will fire for each [DownloadItem] that matches
   * `query`, then `callback` will be called.
   */
  Future<List<int>> erase(DownloadQuery query) {
    if (_downloads == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<int>>.oneArg(listify);
    _downloads.callMethod('erase', [jsify(query), completer.callback]);
    return completer.future;
  }

  /**
   * Remove the downloaded file if it exists and the [DownloadItem] is complete;
   * otherwise return an error through [runtime.lastError].
   */
  Future removeFile(int downloadId) {
    if (_downloads == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _downloads.callMethod('removeFile', [downloadId, completer.callback]);
    return completer.future;
  }

  /**
   * Prompt the user to accept a dangerous download. Does not automatically
   * accept dangerous downloads. If the download is accepted, then an
   * [onChanged] event will fire, otherwise nothing will happen. When all the
   * data is fetched into a temporary file and either the download is not
   * dangerous or the danger has been accepted, then the temporary file is
   * renamed to the target filename, the [state] changes to 'complete', and
   * [onChanged] fires.
   * [downloadId]: The identifier for the [DownloadItem].
   * [callback]: Called when the danger prompt dialog closes.
   */
  Future acceptDanger(int downloadId) {
    if (_downloads == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _downloads.callMethod('acceptDanger', [downloadId, completer.callback]);
    return completer.future;
  }

  /**
   * Initiate dragging the downloaded file to another application. Call in a
   * javascript `ondragstart` handler.
   */
  void drag(int downloadId) {
    if (_downloads == null) _throwNotAvailable();

    _downloads.callMethod('drag', [downloadId]);
  }

  /**
   * Enable or disable the gray shelf at the bottom of every window associated
   * with the current browser profile. The shelf will be disabled as long as at
   * least one extension has disabled it. Enabling the shelf while at least one
   * other extension has disabled it will return an error through
   * [runtime.lastError]. Requires the `"downloads.shelf"` permission in
   * addition to the `"downloads"` permission.
   */
  void setShelfEnabled(bool enabled) {
    if (_downloads == null) _throwNotAvailable();

    _downloads.callMethod('setShelfEnabled', [enabled]);
  }

  Stream<DownloadItem> get onCreated => _onCreated.stream;

  final ChromeStreamController<DownloadItem> _onCreated =
      new ChromeStreamController<DownloadItem>.oneArg(_downloads, 'onCreated', _createDownloadItem);

  Stream<int> get onErased => _onErased.stream;

  final ChromeStreamController<int> _onErased =
      new ChromeStreamController<int>.oneArg(_downloads, 'onErased', selfConverter);

  Stream<DownloadDelta> get onChanged => _onChanged.stream;

  final ChromeStreamController<DownloadDelta> _onChanged =
      new ChromeStreamController<DownloadDelta>.oneArg(_downloads, 'onChanged', _createDownloadDelta);

  Stream<OnDeterminingFilenameEvent> get onDeterminingFilename => _onDeterminingFilename.stream;

  final ChromeStreamController<OnDeterminingFilenameEvent> _onDeterminingFilename =
      new ChromeStreamController<OnDeterminingFilenameEvent>.twoArgs(_downloads, 'onDeterminingFilename', _createOnDeterminingFilenameEvent);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.downloads' is not available");
  }
}

class OnDeterminingFilenameEvent {
  final DownloadItem downloadItem;

  final SuggestFilenameCallback suggest;

  OnDeterminingFilenameEvent(this.downloadItem, this.suggest);
}

/**
 * <dl><dt>uniquify</dt> <dd>To avoid duplication, the `filename` is changed to
 * include a counter before the filename extension.</dd> <dt>overwrite</dt>
 * <dd>The existing file will be overwritten with the new file.</dd>
 * <dt>prompt</dt> <dd>The user will be prompted with a file chooser
 * dialog.</dd> </dl>
 */
class FilenameConflictAction extends ChromeEnum {
  static const FilenameConflictAction UNIQUIFY = const FilenameConflictAction._('uniquify');
  static const FilenameConflictAction OVERWRITE = const FilenameConflictAction._('overwrite');
  static const FilenameConflictAction PROMPT = const FilenameConflictAction._('prompt');

  static const List<FilenameConflictAction> VALUES = const[UNIQUIFY, OVERWRITE, PROMPT];

  const FilenameConflictAction._(String str): super(str);
}

class HttpMethod extends ChromeEnum {
  static const HttpMethod GET = const HttpMethod._('GET');
  static const HttpMethod POST = const HttpMethod._('POST');

  static const List<HttpMethod> VALUES = const[GET, POST];

  const HttpMethod._(String str): super(str);
}

class InterruptReason extends ChromeEnum {
  static const InterruptReason FILE_FAILED = const InterruptReason._('FILE_FAILED');
  static const InterruptReason FILE_ACCESS_DENIED = const InterruptReason._('FILE_ACCESS_DENIED');
  static const InterruptReason FILE_NO_SPACE = const InterruptReason._('FILE_NO_SPACE');
  static const InterruptReason FILE_NAME_TOO_LONG = const InterruptReason._('FILE_NAME_TOO_LONG');
  static const InterruptReason FILE_TOO_LARGE = const InterruptReason._('FILE_TOO_LARGE');
  static const InterruptReason FILE_VIRUS_INFECTED = const InterruptReason._('FILE_VIRUS_INFECTED');
  static const InterruptReason FILE_TRANSIENT_ERROR = const InterruptReason._('FILE_TRANSIENT_ERROR');
  static const InterruptReason FILE_BLOCKED = const InterruptReason._('FILE_BLOCKED');
  static const InterruptReason FILE_SECURITY_CHECK_FAILED = const InterruptReason._('FILE_SECURITY_CHECK_FAILED');
  static const InterruptReason FILE_TOO_SHORT = const InterruptReason._('FILE_TOO_SHORT');
  static const InterruptReason NETWORK_FAILED = const InterruptReason._('NETWORK_FAILED');
  static const InterruptReason NETWORK_TIMEOUT = const InterruptReason._('NETWORK_TIMEOUT');
  static const InterruptReason NETWORK_DISCONNECTED = const InterruptReason._('NETWORK_DISCONNECTED');
  static const InterruptReason NETWORK_SERVER_DOWN = const InterruptReason._('NETWORK_SERVER_DOWN');
  static const InterruptReason SERVER_FAILED = const InterruptReason._('SERVER_FAILED');
  static const InterruptReason SERVER_NO_RANGE = const InterruptReason._('SERVER_NO_RANGE');
  static const InterruptReason SERVER_PRECONDITION = const InterruptReason._('SERVER_PRECONDITION');
  static const InterruptReason SERVER_BAD_CONTENT = const InterruptReason._('SERVER_BAD_CONTENT');
  static const InterruptReason USER_CANCELED = const InterruptReason._('USER_CANCELED');
  static const InterruptReason USER_SHUTDOWN = const InterruptReason._('USER_SHUTDOWN');
  static const InterruptReason CRASH = const InterruptReason._('CRASH');

  static const List<InterruptReason> VALUES = const[FILE_FAILED, FILE_ACCESS_DENIED, FILE_NO_SPACE, FILE_NAME_TOO_LONG, FILE_TOO_LARGE, FILE_VIRUS_INFECTED, FILE_TRANSIENT_ERROR, FILE_BLOCKED, FILE_SECURITY_CHECK_FAILED, FILE_TOO_SHORT, NETWORK_FAILED, NETWORK_TIMEOUT, NETWORK_DISCONNECTED, NETWORK_SERVER_DOWN, SERVER_FAILED, SERVER_NO_RANGE, SERVER_PRECONDITION, SERVER_BAD_CONTENT, USER_CANCELED, USER_SHUTDOWN, CRASH];

  const InterruptReason._(String str): super(str);
}

/**
 * <dl><dt>file</dt> <dd>The download's filename is suspicious.</dd>
 * <dt>url</dt> <dd>The download's URL is known to be malicious.</dd>
 * <dt>content</dt> <dd>The downloaded file is known to be malicious.</dd>
 * <dt>uncommon</dt> <dd>The download's URL is not commonly downloaded and could
 * be dangerous.</dd> <dt>host</dt> <dd>The download came from a host known to
 * distribute malicious binaries and is likely dangerous.</dd> <dt>unwanted</dt>
 * <dd>The download is potentially unwanted or unsafe. E.g. it could make
 * changes to browser or computer settings.</dd> <dt>safe</dt> <dd>The download
 * presents no known danger to the user's computer.</dd> <dt>accepted</dt>
 * <dd>The user has accepted the dangerous download.</dd> </dl>
 */
class DangerType extends ChromeEnum {
  static const DangerType FILE = const DangerType._('file');
  static const DangerType URL = const DangerType._('url');
  static const DangerType CONTENT = const DangerType._('content');
  static const DangerType UNCOMMON = const DangerType._('uncommon');
  static const DangerType HOST = const DangerType._('host');
  static const DangerType UNWANTED = const DangerType._('unwanted');
  static const DangerType SAFE = const DangerType._('safe');
  static const DangerType ACCEPTED = const DangerType._('accepted');

  static const List<DangerType> VALUES = const[FILE, URL, CONTENT, UNCOMMON, HOST, UNWANTED, SAFE, ACCEPTED];

  const DangerType._(String str): super(str);
}

/**
 * <dl><dt>in_progress</dt> <dd>The download is currently receiving data from
 * the server.</dd> <dt>interrupted</dt> <dd>An error broke the connection with
 * the file host.</dd> <dt>complete</dt> <dd>The download completed
 * successfully.</dd> </dl>
 */
class State extends ChromeEnum {
  static const State IN_PROGRESS = const State._('in_progress');
  static const State INTERRUPTED = const State._('interrupted');
  static const State COMPLETE = const State._('complete');

  static const List<State> VALUES = const[IN_PROGRESS, INTERRUPTED, COMPLETE];

  const State._(String str): super(str);
}

class HeaderNameValuePair extends ChromeObject {
  HeaderNameValuePair({String name, String value}) {
    if (name != null) this.name = name;
    if (value != null) this.value = value;
  }
  HeaderNameValuePair.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  String get value => jsProxy['value'];
  set value(String value) => jsProxy['value'] = value;
}

class FilenameSuggestion extends ChromeObject {
  FilenameSuggestion({String filename, FilenameConflictAction conflictAction}) {
    if (filename != null) this.filename = filename;
    if (conflictAction != null) this.conflictAction = conflictAction;
  }
  FilenameSuggestion.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get filename => jsProxy['filename'];
  set filename(String value) => jsProxy['filename'] = value;

  FilenameConflictAction get conflictAction => _createFilenameConflictAction(jsProxy['conflictAction']);
  set conflictAction(FilenameConflictAction value) => jsProxy['conflictAction'] = jsify(value);
}

class DownloadOptions extends ChromeObject {
  DownloadOptions({String url, String filename, FilenameConflictAction conflictAction, bool saveAs, HttpMethod method, List<HeaderNameValuePair> headers, String body}) {
    if (url != null) this.url = url;
    if (filename != null) this.filename = filename;
    if (conflictAction != null) this.conflictAction = conflictAction;
    if (saveAs != null) this.saveAs = saveAs;
    if (method != null) this.method = method;
    if (headers != null) this.headers = headers;
    if (body != null) this.body = body;
  }
  DownloadOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;

  String get filename => jsProxy['filename'];
  set filename(String value) => jsProxy['filename'] = value;

  FilenameConflictAction get conflictAction => _createFilenameConflictAction(jsProxy['conflictAction']);
  set conflictAction(FilenameConflictAction value) => jsProxy['conflictAction'] = jsify(value);

  bool get saveAs => jsProxy['saveAs'];
  set saveAs(bool value) => jsProxy['saveAs'] = value;

  HttpMethod get method => _createHttpMethod(jsProxy['method']);
  set method(HttpMethod value) => jsProxy['method'] = jsify(value);

  List<HeaderNameValuePair> get headers => listify(jsProxy['headers'], _createHeaderNameValuePair);
  set headers(List<HeaderNameValuePair> value) => jsProxy['headers'] = jsify(value);

  String get body => jsProxy['body'];
  set body(String value) => jsProxy['body'] = value;
}

/**
 * The state of the process of downloading a file.
 */
class DownloadItem extends ChromeObject {
  DownloadItem({int id, String url, String referrer, String filename, bool incognito, DangerType danger, String mime, String startTime, String endTime, String estimatedEndTime, State state, bool paused, bool canResume, InterruptReason error, int bytesReceived, int totalBytes, int fileSize, bool exists, String byExtensionId, String byExtensionName}) {
    if (id != null) this.id = id;
    if (url != null) this.url = url;
    if (referrer != null) this.referrer = referrer;
    if (filename != null) this.filename = filename;
    if (incognito != null) this.incognito = incognito;
    if (danger != null) this.danger = danger;
    if (mime != null) this.mime = mime;
    if (startTime != null) this.startTime = startTime;
    if (endTime != null) this.endTime = endTime;
    if (estimatedEndTime != null) this.estimatedEndTime = estimatedEndTime;
    if (state != null) this.state = state;
    if (paused != null) this.paused = paused;
    if (canResume != null) this.canResume = canResume;
    if (error != null) this.error = error;
    if (bytesReceived != null) this.bytesReceived = bytesReceived;
    if (totalBytes != null) this.totalBytes = totalBytes;
    if (fileSize != null) this.fileSize = fileSize;
    if (exists != null) this.exists = exists;
    if (byExtensionId != null) this.byExtensionId = byExtensionId;
    if (byExtensionName != null) this.byExtensionName = byExtensionName;
  }
  DownloadItem.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get id => jsProxy['id'];
  set id(int value) => jsProxy['id'] = value;

  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;

  String get referrer => jsProxy['referrer'];
  set referrer(String value) => jsProxy['referrer'] = value;

  String get filename => jsProxy['filename'];
  set filename(String value) => jsProxy['filename'] = value;

  bool get incognito => jsProxy['incognito'];
  set incognito(bool value) => jsProxy['incognito'] = value;

  DangerType get danger => _createDangerType(jsProxy['danger']);
  set danger(DangerType value) => jsProxy['danger'] = jsify(value);

  String get mime => jsProxy['mime'];
  set mime(String value) => jsProxy['mime'] = value;

  String get startTime => jsProxy['startTime'];
  set startTime(String value) => jsProxy['startTime'] = value;

  String get endTime => jsProxy['endTime'];
  set endTime(String value) => jsProxy['endTime'] = value;

  String get estimatedEndTime => jsProxy['estimatedEndTime'];
  set estimatedEndTime(String value) => jsProxy['estimatedEndTime'] = value;

  State get state => _createState(jsProxy['state']);
  set state(State value) => jsProxy['state'] = jsify(value);

  bool get paused => jsProxy['paused'];
  set paused(bool value) => jsProxy['paused'] = value;

  bool get canResume => jsProxy['canResume'];
  set canResume(bool value) => jsProxy['canResume'] = value;

  InterruptReason get error => _createInterruptReason(jsProxy['error']);
  set error(InterruptReason value) => jsProxy['error'] = jsify(value);

  int get bytesReceived => jsProxy['bytesReceived'];
  set bytesReceived(int value) => jsProxy['bytesReceived'] = value;

  int get totalBytes => jsProxy['totalBytes'];
  set totalBytes(int value) => jsProxy['totalBytes'] = value;

  int get fileSize => jsProxy['fileSize'];
  set fileSize(int value) => jsProxy['fileSize'] = value;

  bool get exists => jsProxy['exists'];
  set exists(bool value) => jsProxy['exists'] = value;

  String get byExtensionId => jsProxy['byExtensionId'];
  set byExtensionId(String value) => jsProxy['byExtensionId'] = value;

  String get byExtensionName => jsProxy['byExtensionName'];
  set byExtensionName(String value) => jsProxy['byExtensionName'] = value;
}

class DownloadQuery extends ChromeObject {
  DownloadQuery({List<String> query, String startedBefore, String startedAfter, String endedBefore, String endedAfter, int totalBytesGreater, int totalBytesLess, String filenameRegex, String urlRegex, int limit, List<String> orderBy, int id, String url, String filename, DangerType danger, String mime, String startTime, String endTime, State state, bool paused, InterruptReason error, int bytesReceived, int totalBytes, int fileSize, bool exists}) {
    if (query != null) this.query = query;
    if (startedBefore != null) this.startedBefore = startedBefore;
    if (startedAfter != null) this.startedAfter = startedAfter;
    if (endedBefore != null) this.endedBefore = endedBefore;
    if (endedAfter != null) this.endedAfter = endedAfter;
    if (totalBytesGreater != null) this.totalBytesGreater = totalBytesGreater;
    if (totalBytesLess != null) this.totalBytesLess = totalBytesLess;
    if (filenameRegex != null) this.filenameRegex = filenameRegex;
    if (urlRegex != null) this.urlRegex = urlRegex;
    if (limit != null) this.limit = limit;
    if (orderBy != null) this.orderBy = orderBy;
    if (id != null) this.id = id;
    if (url != null) this.url = url;
    if (filename != null) this.filename = filename;
    if (danger != null) this.danger = danger;
    if (mime != null) this.mime = mime;
    if (startTime != null) this.startTime = startTime;
    if (endTime != null) this.endTime = endTime;
    if (state != null) this.state = state;
    if (paused != null) this.paused = paused;
    if (error != null) this.error = error;
    if (bytesReceived != null) this.bytesReceived = bytesReceived;
    if (totalBytes != null) this.totalBytes = totalBytes;
    if (fileSize != null) this.fileSize = fileSize;
    if (exists != null) this.exists = exists;
  }
  DownloadQuery.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  List<String> get query => listify(jsProxy['query']);
  set query(List<String> value) => jsProxy['query'] = jsify(value);

  String get startedBefore => jsProxy['startedBefore'];
  set startedBefore(String value) => jsProxy['startedBefore'] = value;

  String get startedAfter => jsProxy['startedAfter'];
  set startedAfter(String value) => jsProxy['startedAfter'] = value;

  String get endedBefore => jsProxy['endedBefore'];
  set endedBefore(String value) => jsProxy['endedBefore'] = value;

  String get endedAfter => jsProxy['endedAfter'];
  set endedAfter(String value) => jsProxy['endedAfter'] = value;

  int get totalBytesGreater => jsProxy['totalBytesGreater'];
  set totalBytesGreater(int value) => jsProxy['totalBytesGreater'] = value;

  int get totalBytesLess => jsProxy['totalBytesLess'];
  set totalBytesLess(int value) => jsProxy['totalBytesLess'] = value;

  String get filenameRegex => jsProxy['filenameRegex'];
  set filenameRegex(String value) => jsProxy['filenameRegex'] = value;

  String get urlRegex => jsProxy['urlRegex'];
  set urlRegex(String value) => jsProxy['urlRegex'] = value;

  int get limit => jsProxy['limit'];
  set limit(int value) => jsProxy['limit'] = value;

  List<String> get orderBy => listify(jsProxy['orderBy']);
  set orderBy(List<String> value) => jsProxy['orderBy'] = jsify(value);

  int get id => jsProxy['id'];
  set id(int value) => jsProxy['id'] = value;

  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;

  String get filename => jsProxy['filename'];
  set filename(String value) => jsProxy['filename'] = value;

  DangerType get danger => _createDangerType(jsProxy['danger']);
  set danger(DangerType value) => jsProxy['danger'] = jsify(value);

  String get mime => jsProxy['mime'];
  set mime(String value) => jsProxy['mime'] = value;

  String get startTime => jsProxy['startTime'];
  set startTime(String value) => jsProxy['startTime'] = value;

  String get endTime => jsProxy['endTime'];
  set endTime(String value) => jsProxy['endTime'] = value;

  State get state => _createState(jsProxy['state']);
  set state(State value) => jsProxy['state'] = jsify(value);

  bool get paused => jsProxy['paused'];
  set paused(bool value) => jsProxy['paused'] = value;

  InterruptReason get error => _createInterruptReason(jsProxy['error']);
  set error(InterruptReason value) => jsProxy['error'] = jsify(value);

  int get bytesReceived => jsProxy['bytesReceived'];
  set bytesReceived(int value) => jsProxy['bytesReceived'] = value;

  int get totalBytes => jsProxy['totalBytes'];
  set totalBytes(int value) => jsProxy['totalBytes'] = value;

  int get fileSize => jsProxy['fileSize'];
  set fileSize(int value) => jsProxy['fileSize'] = value;

  bool get exists => jsProxy['exists'];
  set exists(bool value) => jsProxy['exists'] = value;
}

class StringDelta extends ChromeObject {
  StringDelta({String previous, String current}) {
    if (previous != null) this.previous = previous;
    if (current != null) this.current = current;
  }
  StringDelta.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get previous => jsProxy['previous'];
  set previous(String value) => jsProxy['previous'] = value;

  String get current => jsProxy['current'];
  set current(String value) => jsProxy['current'] = value;
}

class LongDelta extends ChromeObject {
  LongDelta({int previous, int current}) {
    if (previous != null) this.previous = previous;
    if (current != null) this.current = current;
  }
  LongDelta.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get previous => jsProxy['previous'];
  set previous(int value) => jsProxy['previous'] = value;

  int get current => jsProxy['current'];
  set current(int value) => jsProxy['current'] = value;
}

class BooleanDelta extends ChromeObject {
  BooleanDelta({bool previous, bool current}) {
    if (previous != null) this.previous = previous;
    if (current != null) this.current = current;
  }
  BooleanDelta.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  bool get previous => jsProxy['previous'];
  set previous(bool value) => jsProxy['previous'] = value;

  bool get current => jsProxy['current'];
  set current(bool value) => jsProxy['current'] = value;
}

/**
 * Encapsulates a change in a DownloadItem.
 */
class DownloadDelta extends ChromeObject {
  DownloadDelta({int id, StringDelta url, StringDelta filename, StringDelta danger, StringDelta mime, StringDelta startTime, StringDelta endTime, StringDelta state, BooleanDelta canResume, BooleanDelta paused, StringDelta error, LongDelta totalBytes, LongDelta fileSize, BooleanDelta exists}) {
    if (id != null) this.id = id;
    if (url != null) this.url = url;
    if (filename != null) this.filename = filename;
    if (danger != null) this.danger = danger;
    if (mime != null) this.mime = mime;
    if (startTime != null) this.startTime = startTime;
    if (endTime != null) this.endTime = endTime;
    if (state != null) this.state = state;
    if (canResume != null) this.canResume = canResume;
    if (paused != null) this.paused = paused;
    if (error != null) this.error = error;
    if (totalBytes != null) this.totalBytes = totalBytes;
    if (fileSize != null) this.fileSize = fileSize;
    if (exists != null) this.exists = exists;
  }
  DownloadDelta.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get id => jsProxy['id'];
  set id(int value) => jsProxy['id'] = value;

  StringDelta get url => _createStringDelta(jsProxy['url']);
  set url(StringDelta value) => jsProxy['url'] = jsify(value);

  StringDelta get filename => _createStringDelta(jsProxy['filename']);
  set filename(StringDelta value) => jsProxy['filename'] = jsify(value);

  StringDelta get danger => _createStringDelta(jsProxy['danger']);
  set danger(StringDelta value) => jsProxy['danger'] = jsify(value);

  StringDelta get mime => _createStringDelta(jsProxy['mime']);
  set mime(StringDelta value) => jsProxy['mime'] = jsify(value);

  StringDelta get startTime => _createStringDelta(jsProxy['startTime']);
  set startTime(StringDelta value) => jsProxy['startTime'] = jsify(value);

  StringDelta get endTime => _createStringDelta(jsProxy['endTime']);
  set endTime(StringDelta value) => jsProxy['endTime'] = jsify(value);

  StringDelta get state => _createStringDelta(jsProxy['state']);
  set state(StringDelta value) => jsProxy['state'] = jsify(value);

  BooleanDelta get canResume => _createBooleanDelta(jsProxy['canResume']);
  set canResume(BooleanDelta value) => jsProxy['canResume'] = jsify(value);

  BooleanDelta get paused => _createBooleanDelta(jsProxy['paused']);
  set paused(BooleanDelta value) => jsProxy['paused'] = jsify(value);

  StringDelta get error => _createStringDelta(jsProxy['error']);
  set error(StringDelta value) => jsProxy['error'] = jsify(value);

  LongDelta get totalBytes => _createLongDelta(jsProxy['totalBytes']);
  set totalBytes(LongDelta value) => jsProxy['totalBytes'] = jsify(value);

  LongDelta get fileSize => _createLongDelta(jsProxy['fileSize']);
  set fileSize(LongDelta value) => jsProxy['fileSize'] = jsify(value);

  BooleanDelta get exists => _createBooleanDelta(jsProxy['exists']);
  set exists(BooleanDelta value) => jsProxy['exists'] = jsify(value);
}

class GetFileIconOptions extends ChromeObject {
  GetFileIconOptions({int size}) {
    if (size != null) this.size = size;
  }
  GetFileIconOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get size => jsProxy['size'];
  set size(int value) => jsProxy['size'] = value;
}

DownloadItem _createDownloadItem(JsObject jsProxy) => jsProxy == null ? null : new DownloadItem.fromProxy(jsProxy);
DownloadDelta _createDownloadDelta(JsObject jsProxy) => jsProxy == null ? null : new DownloadDelta.fromProxy(jsProxy);
OnDeterminingFilenameEvent _createOnDeterminingFilenameEvent(JsObject downloadItem, JsObject suggest) =>
    new OnDeterminingFilenameEvent(_createDownloadItem(downloadItem), _createSuggestFilenameCallback(suggest));
FilenameConflictAction _createFilenameConflictAction(String value) => FilenameConflictAction.VALUES.singleWhere((ChromeEnum e) => e.value == value);
HttpMethod _createHttpMethod(String value) => HttpMethod.VALUES.singleWhere((ChromeEnum e) => e.value == value);
HeaderNameValuePair _createHeaderNameValuePair(JsObject jsProxy) => jsProxy == null ? null : new HeaderNameValuePair.fromProxy(jsProxy);
DangerType _createDangerType(String value) => DangerType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
State _createState(String value) => State.VALUES.singleWhere((ChromeEnum e) => e.value == value);
InterruptReason _createInterruptReason(String value) => InterruptReason.VALUES.singleWhere((ChromeEnum e) => e.value == value);
StringDelta _createStringDelta(JsObject jsProxy) => jsProxy == null ? null : new StringDelta.fromProxy(jsProxy);
BooleanDelta _createBooleanDelta(JsObject jsProxy) => jsProxy == null ? null : new BooleanDelta.fromProxy(jsProxy);
LongDelta _createLongDelta(JsObject jsProxy) => jsProxy == null ? null : new LongDelta.fromProxy(jsProxy);
SuggestFilenameCallback _createSuggestFilenameCallback(JsObject jsProxy) => jsProxy == null ? null : new SuggestFilenameCallback.fromProxy(jsProxy);
