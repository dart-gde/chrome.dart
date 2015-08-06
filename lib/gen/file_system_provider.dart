/* This file has been generated from file_system_provider.idl - do not edit */

/**
 * Use the `chrome.fileSystemProvider` API to create file systems, that can be
 * accessible from the file manager on Chrome OS.
 * [implemented_in="chrome/browser/chromeos/extensions/file_system_provider/file_system_provider_api.h"]
 */
library chrome.fileSystemProvider;

import '../src/common.dart';

/**
 * Accessor for the `chrome.fileSystemProvider` namespace.
 */
final ChromeFileSystemProvider fileSystemProvider = new ChromeFileSystemProvider._();

class ChromeFileSystemProvider extends ChromeApi {
  JsObject get _fileSystemProvider => chrome['fileSystemProvider'];

  Stream<OnUnmountRequestedEvent> get onUnmountRequested => _onUnmountRequested.stream;
  ChromeStreamController<OnUnmountRequestedEvent> _onUnmountRequested;

  Stream<OnGetMetadataRequestedEvent> get onGetMetadataRequested => _onGetMetadataRequested.stream;
  ChromeStreamController<OnGetMetadataRequestedEvent> _onGetMetadataRequested;

  Stream<OnReadDirectoryRequestedEvent> get onReadDirectoryRequested => _onReadDirectoryRequested.stream;
  ChromeStreamController<OnReadDirectoryRequestedEvent> _onReadDirectoryRequested;

  Stream<OnOpenFileRequestedEvent> get onOpenFileRequested => _onOpenFileRequested.stream;
  ChromeStreamController<OnOpenFileRequestedEvent> _onOpenFileRequested;

  Stream<OnCloseFileRequestedEvent> get onCloseFileRequested => _onCloseFileRequested.stream;
  ChromeStreamController<OnCloseFileRequestedEvent> _onCloseFileRequested;

  Stream<OnReadFileRequestedEvent> get onReadFileRequested => _onReadFileRequested.stream;
  ChromeStreamController<OnReadFileRequestedEvent> _onReadFileRequested;

  Stream<OnCreateDirectoryRequestedEvent> get onCreateDirectoryRequested => _onCreateDirectoryRequested.stream;
  ChromeStreamController<OnCreateDirectoryRequestedEvent> _onCreateDirectoryRequested;

  Stream<OnDeleteEntryRequestedEvent> get onDeleteEntryRequested => _onDeleteEntryRequested.stream;
  ChromeStreamController<OnDeleteEntryRequestedEvent> _onDeleteEntryRequested;

  Stream<OnCreateFileRequestedEvent> get onCreateFileRequested => _onCreateFileRequested.stream;
  ChromeStreamController<OnCreateFileRequestedEvent> _onCreateFileRequested;

  Stream<OnCopyEntryRequestedEvent> get onCopyEntryRequested => _onCopyEntryRequested.stream;
  ChromeStreamController<OnCopyEntryRequestedEvent> _onCopyEntryRequested;

  Stream<OnMoveEntryRequestedEvent> get onMoveEntryRequested => _onMoveEntryRequested.stream;
  ChromeStreamController<OnMoveEntryRequestedEvent> _onMoveEntryRequested;

  Stream<OnTruncateRequestedEvent> get onTruncateRequested => _onTruncateRequested.stream;
  ChromeStreamController<OnTruncateRequestedEvent> _onTruncateRequested;

  Stream<OnWriteFileRequestedEvent> get onWriteFileRequested => _onWriteFileRequested.stream;
  ChromeStreamController<OnWriteFileRequestedEvent> _onWriteFileRequested;

  Stream<OnAbortRequestedEvent> get onAbortRequested => _onAbortRequested.stream;
  ChromeStreamController<OnAbortRequestedEvent> _onAbortRequested;

  Stream<OnConfigureRequestedEvent> get onConfigureRequested => _onConfigureRequested.stream;
  ChromeStreamController<OnConfigureRequestedEvent> _onConfigureRequested;

  Stream<OnMountRequestedEvent> get onMountRequested => _onMountRequested.stream;
  ChromeStreamController<OnMountRequestedEvent> _onMountRequested;

  Stream<OnAddWatcherRequestedEvent> get onAddWatcherRequested => _onAddWatcherRequested.stream;
  ChromeStreamController<OnAddWatcherRequestedEvent> _onAddWatcherRequested;

  Stream<OnRemoveWatcherRequestedEvent> get onRemoveWatcherRequested => _onRemoveWatcherRequested.stream;
  ChromeStreamController<OnRemoveWatcherRequestedEvent> _onRemoveWatcherRequested;

  ChromeFileSystemProvider._() {
    var getApi = () => _fileSystemProvider;
    _onUnmountRequested = new ChromeStreamController<OnUnmountRequestedEvent>.threeArgs(getApi, 'onUnmountRequested', _createOnUnmountRequestedEvent);
    _onGetMetadataRequested = new ChromeStreamController<OnGetMetadataRequestedEvent>.threeArgs(getApi, 'onGetMetadataRequested', _createOnGetMetadataRequestedEvent);
    _onReadDirectoryRequested = new ChromeStreamController<OnReadDirectoryRequestedEvent>.threeArgs(getApi, 'onReadDirectoryRequested', _createOnReadDirectoryRequestedEvent);
    _onOpenFileRequested = new ChromeStreamController<OnOpenFileRequestedEvent>.threeArgs(getApi, 'onOpenFileRequested', _createOnOpenFileRequestedEvent);
    _onCloseFileRequested = new ChromeStreamController<OnCloseFileRequestedEvent>.threeArgs(getApi, 'onCloseFileRequested', _createOnCloseFileRequestedEvent);
    _onReadFileRequested = new ChromeStreamController<OnReadFileRequestedEvent>.threeArgs(getApi, 'onReadFileRequested', _createOnReadFileRequestedEvent);
    _onCreateDirectoryRequested = new ChromeStreamController<OnCreateDirectoryRequestedEvent>.threeArgs(getApi, 'onCreateDirectoryRequested', _createOnCreateDirectoryRequestedEvent);
    _onDeleteEntryRequested = new ChromeStreamController<OnDeleteEntryRequestedEvent>.threeArgs(getApi, 'onDeleteEntryRequested', _createOnDeleteEntryRequestedEvent);
    _onCreateFileRequested = new ChromeStreamController<OnCreateFileRequestedEvent>.threeArgs(getApi, 'onCreateFileRequested', _createOnCreateFileRequestedEvent);
    _onCopyEntryRequested = new ChromeStreamController<OnCopyEntryRequestedEvent>.threeArgs(getApi, 'onCopyEntryRequested', _createOnCopyEntryRequestedEvent);
    _onMoveEntryRequested = new ChromeStreamController<OnMoveEntryRequestedEvent>.threeArgs(getApi, 'onMoveEntryRequested', _createOnMoveEntryRequestedEvent);
    _onTruncateRequested = new ChromeStreamController<OnTruncateRequestedEvent>.threeArgs(getApi, 'onTruncateRequested', _createOnTruncateRequestedEvent);
    _onWriteFileRequested = new ChromeStreamController<OnWriteFileRequestedEvent>.threeArgs(getApi, 'onWriteFileRequested', _createOnWriteFileRequestedEvent);
    _onAbortRequested = new ChromeStreamController<OnAbortRequestedEvent>.threeArgs(getApi, 'onAbortRequested', _createOnAbortRequestedEvent);
    _onConfigureRequested = new ChromeStreamController<OnConfigureRequestedEvent>.threeArgs(getApi, 'onConfigureRequested', _createOnConfigureRequestedEvent);
    _onMountRequested = new ChromeStreamController<OnMountRequestedEvent>.twoArgs(getApi, 'onMountRequested', _createOnMountRequestedEvent);
    _onAddWatcherRequested = new ChromeStreamController<OnAddWatcherRequestedEvent>.threeArgs(getApi, 'onAddWatcherRequested', _createOnAddWatcherRequestedEvent);
    _onRemoveWatcherRequested = new ChromeStreamController<OnRemoveWatcherRequestedEvent>.threeArgs(getApi, 'onRemoveWatcherRequested', _createOnRemoveWatcherRequestedEvent);
  }

  bool get available => _fileSystemProvider != null;

  /**
   * Mounts a file system with the given `fileSystemId` and `displayName`.
   * `displayName` will be shown in the left panel of Files.app. `displayName`
   * can contain any characters including '/', but cannot be an empty string.
   * `displayName` must be descriptive but doesn't have to be unique. The
   * `fileSystemId` must not be an empty string.
   * 
   * Depending on the type of the file system being mounted, the `source` option
   * must be set appropriately.
   * 
   * In case of an error, [runtime.lastError] will be set with a corresponding
   * error code.
   */
  Future mount(MountOptions options) {
    if (_fileSystemProvider == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _fileSystemProvider.callMethod('mount', [jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Unmounts a file system with the given `fileSystemId`. It must be called
   * after [onUnmountRequested] is invoked. Also, the providing extension can
   * decide to perform unmounting if not requested (eg. in case of lost
   * connection, or a file error).
   * 
   * In case of an error, [runtime.lastError] will be set with a corresponding
   * error code.
   */
  Future unmount(UnmountOptions options) {
    if (_fileSystemProvider == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _fileSystemProvider.callMethod('unmount', [jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Returns all file systems mounted by the extension.
   * 
   * Returns:
   * Callback to receive the result of [getAll] function.
   */
  Future<List<FileSystemInfo>> getAll() {
    if (_fileSystemProvider == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<FileSystemInfo>>.oneArg((e) => listify(e, _createFileSystemInfo));
    _fileSystemProvider.callMethod('getAll', [completer.callback]);
    return completer.future;
  }

  /**
   * Returns information about a file system with the passed `fileSystemId`.
   * 
   * Returns:
   * Callback to receive the result of [get] function.
   */
  Future<FileSystemInfo> get(String fileSystemId) {
    if (_fileSystemProvider == null) _throwNotAvailable();

    var completer = new ChromeCompleter<FileSystemInfo>.oneArg(_createFileSystemInfo);
    _fileSystemProvider.callMethod('get', [fileSystemId, completer.callback]);
    return completer.future;
  }

  /**
   * Notifies about changes in the watched directory at `observedPath` in
   * `recursive` mode. If the file system is mounted with `supportsNofityTag`,
   * then `tag` must be provided, and all changes since the last notification
   * always reported, even if the system was shutdown. The last tag can be
   * obtained with [getAll]. Note, that `tag` is required in order to enable the
   * internal cache.
   * 
   * Value of `tag` can be any string which is unique per call, so it's possible
   * to identify the last registered notification. Eg. if the providing
   * extension starts after a reboot, and the last registered notification's tag
   * is equal to "123", then it should call [notify] for all changes which
   * happened since the change tagged as "123". It cannot be an empty string.
   * 
   * Not all providers are able to provide a tag, but if the file system has a
   * changelog, then the tag can be eg. a change number, or a revision number.
   * 
   * Note that if a parent directory is removed, then all descendant entries are
   * also removed, and if they are watched, then the API must be notified about
   * the fact. Also, if a directory is renamed, then all descendant entries are
   * in fact removed, as there is no entry under their original paths anymore.
   * 
   * In case of an error, [chrome.runtime.lastError] will be set will a
   * corresponding error code.
   */
  Future notify(NotifyOptions options) {
    if (_fileSystemProvider == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _fileSystemProvider.callMethod('notify', [jsify(options), completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.fileSystemProvider' is not available");
  }
}

class OnUnmountRequestedEvent {
  final UnmountRequestedOptions options;

  final ProviderSuccessCallback successCallback;

  final ProviderErrorCallback errorCallback;

  OnUnmountRequestedEvent(this.options, this.successCallback, this.errorCallback);
}

class OnGetMetadataRequestedEvent {
  final GetMetadataRequestedOptions options;

  final MetadataCallback successCallback;

  final ProviderErrorCallback errorCallback;

  OnGetMetadataRequestedEvent(this.options, this.successCallback, this.errorCallback);
}

class OnReadDirectoryRequestedEvent {
  final ReadDirectoryRequestedOptions options;

  final EntriesCallback successCallback;

  final ProviderErrorCallback errorCallback;

  OnReadDirectoryRequestedEvent(this.options, this.successCallback, this.errorCallback);
}

class OnOpenFileRequestedEvent {
  final OpenFileRequestedOptions options;

  final ProviderSuccessCallback successCallback;

  final ProviderErrorCallback errorCallback;

  OnOpenFileRequestedEvent(this.options, this.successCallback, this.errorCallback);
}

class OnCloseFileRequestedEvent {
  final CloseFileRequestedOptions options;

  final ProviderSuccessCallback successCallback;

  final ProviderErrorCallback errorCallback;

  OnCloseFileRequestedEvent(this.options, this.successCallback, this.errorCallback);
}

class OnReadFileRequestedEvent {
  final ReadFileRequestedOptions options;

  final FileDataCallback successCallback;

  final ProviderErrorCallback errorCallback;

  OnReadFileRequestedEvent(this.options, this.successCallback, this.errorCallback);
}

class OnCreateDirectoryRequestedEvent {
  final CreateDirectoryRequestedOptions options;

  final ProviderSuccessCallback successCallback;

  final ProviderErrorCallback errorCallback;

  OnCreateDirectoryRequestedEvent(this.options, this.successCallback, this.errorCallback);
}

class OnDeleteEntryRequestedEvent {
  final DeleteEntryRequestedOptions options;

  final ProviderSuccessCallback successCallback;

  final ProviderErrorCallback errorCallback;

  OnDeleteEntryRequestedEvent(this.options, this.successCallback, this.errorCallback);
}

class OnCreateFileRequestedEvent {
  final CreateFileRequestedOptions options;

  final ProviderSuccessCallback successCallback;

  final ProviderErrorCallback errorCallback;

  OnCreateFileRequestedEvent(this.options, this.successCallback, this.errorCallback);
}

class OnCopyEntryRequestedEvent {
  final CopyEntryRequestedOptions options;

  final ProviderSuccessCallback successCallback;

  final ProviderErrorCallback errorCallback;

  OnCopyEntryRequestedEvent(this.options, this.successCallback, this.errorCallback);
}

class OnMoveEntryRequestedEvent {
  final MoveEntryRequestedOptions options;

  final ProviderSuccessCallback successCallback;

  final ProviderErrorCallback errorCallback;

  OnMoveEntryRequestedEvent(this.options, this.successCallback, this.errorCallback);
}

class OnTruncateRequestedEvent {
  final TruncateRequestedOptions options;

  final ProviderSuccessCallback successCallback;

  final ProviderErrorCallback errorCallback;

  OnTruncateRequestedEvent(this.options, this.successCallback, this.errorCallback);
}

class OnWriteFileRequestedEvent {
  final WriteFileRequestedOptions options;

  final ProviderSuccessCallback successCallback;

  final ProviderErrorCallback errorCallback;

  OnWriteFileRequestedEvent(this.options, this.successCallback, this.errorCallback);
}

class OnAbortRequestedEvent {
  final AbortRequestedOptions options;

  final ProviderSuccessCallback successCallback;

  final ProviderErrorCallback errorCallback;

  OnAbortRequestedEvent(this.options, this.successCallback, this.errorCallback);
}

class OnConfigureRequestedEvent {
  final ConfigureRequestedOptions options;

  final ProviderSuccessCallback successCallback;

  final ProviderErrorCallback errorCallback;

  OnConfigureRequestedEvent(this.options, this.successCallback, this.errorCallback);
}

class OnMountRequestedEvent {
  final ProviderSuccessCallback successCallback;

  final ProviderErrorCallback errorCallback;

  OnMountRequestedEvent(this.successCallback, this.errorCallback);
}

class OnAddWatcherRequestedEvent {
  final AddWatcherRequestedOptions options;

  final ProviderSuccessCallback successCallback;

  final ProviderErrorCallback errorCallback;

  OnAddWatcherRequestedEvent(this.options, this.successCallback, this.errorCallback);
}

class OnRemoveWatcherRequestedEvent {
  final RemoveWatcherRequestedOptions options;

  final ProviderSuccessCallback successCallback;

  final ProviderErrorCallback errorCallback;

  OnRemoveWatcherRequestedEvent(this.options, this.successCallback, this.errorCallback);
}

/**
 * Error codes used by providing extensions in response to requests as well as
 * in case of errors when calling methods of the API. For success, `OK` must be
 * used.
 */
class ProviderError extends ChromeEnum {
  static const ProviderError OK = const ProviderError._('OK');
  static const ProviderError FAILED = const ProviderError._('FAILED');
  static const ProviderError IN_USE = const ProviderError._('IN_USE');
  static const ProviderError EXISTS = const ProviderError._('EXISTS');
  static const ProviderError NOT_FOUND = const ProviderError._('NOT_FOUND');
  static const ProviderError ACCESS_DENIED = const ProviderError._('ACCESS_DENIED');
  static const ProviderError TOO_MANY_OPENED = const ProviderError._('TOO_MANY_OPENED');
  static const ProviderError NO_MEMORY = const ProviderError._('NO_MEMORY');
  static const ProviderError NO_SPACE = const ProviderError._('NO_SPACE');
  static const ProviderError NOT_A_DIRECTORY = const ProviderError._('NOT_A_DIRECTORY');
  static const ProviderError INVALID_OPERATION = const ProviderError._('INVALID_OPERATION');
  static const ProviderError SECURITY = const ProviderError._('SECURITY');
  static const ProviderError ABORT = const ProviderError._('ABORT');
  static const ProviderError NOT_A_FILE = const ProviderError._('NOT_A_FILE');
  static const ProviderError NOT_EMPTY = const ProviderError._('NOT_EMPTY');
  static const ProviderError INVALID_URL = const ProviderError._('INVALID_URL');
  static const ProviderError IO = const ProviderError._('IO');

  static const List<ProviderError> VALUES = const[OK, FAILED, IN_USE, EXISTS, NOT_FOUND, ACCESS_DENIED, TOO_MANY_OPENED, NO_MEMORY, NO_SPACE, NOT_A_DIRECTORY, INVALID_OPERATION, SECURITY, ABORT, NOT_A_FILE, NOT_EMPTY, INVALID_URL, IO];

  const ProviderError._(String str): super(str);
}

/**
 * Mode of opening a file. Used by [onOpenFileRequested].
 */
class OpenFileMode extends ChromeEnum {
  static const OpenFileMode READ = const OpenFileMode._('READ');
  static const OpenFileMode WRITE = const OpenFileMode._('WRITE');

  static const List<OpenFileMode> VALUES = const[READ, WRITE];

  const OpenFileMode._(String str): super(str);
}

/**
 * Type of a change detected on the observed directory.
 */
class ChangeType extends ChromeEnum {
  static const ChangeType CHANGED = const ChangeType._('CHANGED');
  static const ChangeType DELETED = const ChangeType._('DELETED');

  static const List<ChangeType> VALUES = const[CHANGED, DELETED];

  const ChangeType._(String str): super(str);
}

/**
 * Represents metadata of a file or a directory.
 */
class EntryMetadata extends ChromeObject {
  EntryMetadata({bool isDirectory, String name, num size, Date modificationTime, String mimeType, String thumbnail}) {
    if (isDirectory != null) this.isDirectory = isDirectory;
    if (name != null) this.name = name;
    if (size != null) this.size = size;
    if (modificationTime != null) this.modificationTime = modificationTime;
    if (mimeType != null) this.mimeType = mimeType;
    if (thumbnail != null) this.thumbnail = thumbnail;
  }
  EntryMetadata.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  bool get isDirectory => jsProxy['isDirectory'];
  set isDirectory(bool value) => jsProxy['isDirectory'] = value;

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  num get size => jsProxy['size'];
  set size(num value) => jsProxy['size'] = jsify(value);

  Date get modificationTime => _createDate(jsProxy['modificationTime']);
  set modificationTime(Date value) => jsProxy['modificationTime'] = jsify(value);

  String get mimeType => jsProxy['mimeType'];
  set mimeType(String value) => jsProxy['mimeType'] = value;

  String get thumbnail => jsProxy['thumbnail'];
  set thumbnail(String value) => jsProxy['thumbnail'] = value;
}

/**
 * Represents a watcher.
 */
class Watcher extends ChromeObject {
  Watcher({String entryPath, bool recursive, String lastTag}) {
    if (entryPath != null) this.entryPath = entryPath;
    if (recursive != null) this.recursive = recursive;
    if (lastTag != null) this.lastTag = lastTag;
  }
  Watcher.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get entryPath => jsProxy['entryPath'];
  set entryPath(String value) => jsProxy['entryPath'] = value;

  bool get recursive => jsProxy['recursive'];
  set recursive(bool value) => jsProxy['recursive'] = value;

  String get lastTag => jsProxy['lastTag'];
  set lastTag(String value) => jsProxy['lastTag'] = value;
}

/**
 * Represents an opened file.
 */
class OpenedFile extends ChromeObject {
  OpenedFile({int openRequestId, String filePath, OpenFileMode mode}) {
    if (openRequestId != null) this.openRequestId = openRequestId;
    if (filePath != null) this.filePath = filePath;
    if (mode != null) this.mode = mode;
  }
  OpenedFile.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get openRequestId => jsProxy['openRequestId'];
  set openRequestId(int value) => jsProxy['openRequestId'] = value;

  String get filePath => jsProxy['filePath'];
  set filePath(String value) => jsProxy['filePath'] = value;

  OpenFileMode get mode => _createOpenFileMode(jsProxy['mode']);
  set mode(OpenFileMode value) => jsProxy['mode'] = jsify(value);
}

/**
 * Represents a mounted file system.
 */
class FileSystemInfo extends ChromeObject {
  FileSystemInfo({String fileSystemId, String displayName, bool writable, int openedFilesLimit, List<OpenedFile> openedFiles, bool supportsNotifyTag, List<Watcher> watchers}) {
    if (fileSystemId != null) this.fileSystemId = fileSystemId;
    if (displayName != null) this.displayName = displayName;
    if (writable != null) this.writable = writable;
    if (openedFilesLimit != null) this.openedFilesLimit = openedFilesLimit;
    if (openedFiles != null) this.openedFiles = openedFiles;
    if (supportsNotifyTag != null) this.supportsNotifyTag = supportsNotifyTag;
    if (watchers != null) this.watchers = watchers;
  }
  FileSystemInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get fileSystemId => jsProxy['fileSystemId'];
  set fileSystemId(String value) => jsProxy['fileSystemId'] = value;

  String get displayName => jsProxy['displayName'];
  set displayName(String value) => jsProxy['displayName'] = value;

  bool get writable => jsProxy['writable'];
  set writable(bool value) => jsProxy['writable'] = value;

  int get openedFilesLimit => jsProxy['openedFilesLimit'];
  set openedFilesLimit(int value) => jsProxy['openedFilesLimit'] = value;

  List<OpenedFile> get openedFiles => listify(jsProxy['openedFiles'], _createOpenedFile);
  set openedFiles(List<OpenedFile> value) => jsProxy['openedFiles'] = jsify(value);

  bool get supportsNotifyTag => jsProxy['supportsNotifyTag'];
  set supportsNotifyTag(bool value) => jsProxy['supportsNotifyTag'] = value;

  List<Watcher> get watchers => listify(jsProxy['watchers'], _createWatcher);
  set watchers(List<Watcher> value) => jsProxy['watchers'] = jsify(value);
}

/**
 * Options for the [mount] method.
 */
class MountOptions extends ChromeObject {
  MountOptions({String fileSystemId, String displayName, bool writable, int openedFilesLimit, bool supportsNotifyTag}) {
    if (fileSystemId != null) this.fileSystemId = fileSystemId;
    if (displayName != null) this.displayName = displayName;
    if (writable != null) this.writable = writable;
    if (openedFilesLimit != null) this.openedFilesLimit = openedFilesLimit;
    if (supportsNotifyTag != null) this.supportsNotifyTag = supportsNotifyTag;
  }
  MountOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get fileSystemId => jsProxy['fileSystemId'];
  set fileSystemId(String value) => jsProxy['fileSystemId'] = value;

  String get displayName => jsProxy['displayName'];
  set displayName(String value) => jsProxy['displayName'] = value;

  bool get writable => jsProxy['writable'];
  set writable(bool value) => jsProxy['writable'] = value;

  int get openedFilesLimit => jsProxy['openedFilesLimit'];
  set openedFilesLimit(int value) => jsProxy['openedFilesLimit'] = value;

  bool get supportsNotifyTag => jsProxy['supportsNotifyTag'];
  set supportsNotifyTag(bool value) => jsProxy['supportsNotifyTag'] = value;
}

/**
 * Options for the [unmount] method.
 */
class UnmountOptions extends ChromeObject {
  UnmountOptions({String fileSystemId}) {
    if (fileSystemId != null) this.fileSystemId = fileSystemId;
  }
  UnmountOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get fileSystemId => jsProxy['fileSystemId'];
  set fileSystemId(String value) => jsProxy['fileSystemId'] = value;
}

/**
 * Options for the [onUnmountRequested] event.
 */
class UnmountRequestedOptions extends ChromeObject {
  UnmountRequestedOptions({String fileSystemId, int requestId}) {
    if (fileSystemId != null) this.fileSystemId = fileSystemId;
    if (requestId != null) this.requestId = requestId;
  }
  UnmountRequestedOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get fileSystemId => jsProxy['fileSystemId'];
  set fileSystemId(String value) => jsProxy['fileSystemId'] = value;

  int get requestId => jsProxy['requestId'];
  set requestId(int value) => jsProxy['requestId'] = value;
}

/**
 * Options for the [onGetMetadataRequested] event.
 */
class GetMetadataRequestedOptions extends ChromeObject {
  GetMetadataRequestedOptions({String fileSystemId, int requestId, String entryPath, bool thumbnail}) {
    if (fileSystemId != null) this.fileSystemId = fileSystemId;
    if (requestId != null) this.requestId = requestId;
    if (entryPath != null) this.entryPath = entryPath;
    if (thumbnail != null) this.thumbnail = thumbnail;
  }
  GetMetadataRequestedOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get fileSystemId => jsProxy['fileSystemId'];
  set fileSystemId(String value) => jsProxy['fileSystemId'] = value;

  int get requestId => jsProxy['requestId'];
  set requestId(int value) => jsProxy['requestId'] = value;

  String get entryPath => jsProxy['entryPath'];
  set entryPath(String value) => jsProxy['entryPath'] = value;

  bool get thumbnail => jsProxy['thumbnail'];
  set thumbnail(bool value) => jsProxy['thumbnail'] = value;
}

/**
 * Options for the [onReadDirectoryRequested] event.
 */
class ReadDirectoryRequestedOptions extends ChromeObject {
  ReadDirectoryRequestedOptions({String fileSystemId, int requestId, String directoryPath}) {
    if (fileSystemId != null) this.fileSystemId = fileSystemId;
    if (requestId != null) this.requestId = requestId;
    if (directoryPath != null) this.directoryPath = directoryPath;
  }
  ReadDirectoryRequestedOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get fileSystemId => jsProxy['fileSystemId'];
  set fileSystemId(String value) => jsProxy['fileSystemId'] = value;

  int get requestId => jsProxy['requestId'];
  set requestId(int value) => jsProxy['requestId'] = value;

  String get directoryPath => jsProxy['directoryPath'];
  set directoryPath(String value) => jsProxy['directoryPath'] = value;
}

/**
 * Options for the [onOpenFileRequested] event.
 */
class OpenFileRequestedOptions extends ChromeObject {
  OpenFileRequestedOptions({String fileSystemId, int requestId, String filePath, OpenFileMode mode}) {
    if (fileSystemId != null) this.fileSystemId = fileSystemId;
    if (requestId != null) this.requestId = requestId;
    if (filePath != null) this.filePath = filePath;
    if (mode != null) this.mode = mode;
  }
  OpenFileRequestedOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get fileSystemId => jsProxy['fileSystemId'];
  set fileSystemId(String value) => jsProxy['fileSystemId'] = value;

  int get requestId => jsProxy['requestId'];
  set requestId(int value) => jsProxy['requestId'] = value;

  String get filePath => jsProxy['filePath'];
  set filePath(String value) => jsProxy['filePath'] = value;

  OpenFileMode get mode => _createOpenFileMode(jsProxy['mode']);
  set mode(OpenFileMode value) => jsProxy['mode'] = jsify(value);
}

/**
 * Options for the [onCloseFileRequested] event.
 */
class CloseFileRequestedOptions extends ChromeObject {
  CloseFileRequestedOptions({String fileSystemId, int requestId, int openRequestId}) {
    if (fileSystemId != null) this.fileSystemId = fileSystemId;
    if (requestId != null) this.requestId = requestId;
    if (openRequestId != null) this.openRequestId = openRequestId;
  }
  CloseFileRequestedOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get fileSystemId => jsProxy['fileSystemId'];
  set fileSystemId(String value) => jsProxy['fileSystemId'] = value;

  int get requestId => jsProxy['requestId'];
  set requestId(int value) => jsProxy['requestId'] = value;

  int get openRequestId => jsProxy['openRequestId'];
  set openRequestId(int value) => jsProxy['openRequestId'] = value;
}

/**
 * Options for the [onReadFileRequested] event.
 */
class ReadFileRequestedOptions extends ChromeObject {
  ReadFileRequestedOptions({String fileSystemId, int requestId, int openRequestId, num offset, num length}) {
    if (fileSystemId != null) this.fileSystemId = fileSystemId;
    if (requestId != null) this.requestId = requestId;
    if (openRequestId != null) this.openRequestId = openRequestId;
    if (offset != null) this.offset = offset;
    if (length != null) this.length = length;
  }
  ReadFileRequestedOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get fileSystemId => jsProxy['fileSystemId'];
  set fileSystemId(String value) => jsProxy['fileSystemId'] = value;

  int get requestId => jsProxy['requestId'];
  set requestId(int value) => jsProxy['requestId'] = value;

  int get openRequestId => jsProxy['openRequestId'];
  set openRequestId(int value) => jsProxy['openRequestId'] = value;

  num get offset => jsProxy['offset'];
  set offset(num value) => jsProxy['offset'] = jsify(value);

  num get length => jsProxy['length'];
  set length(num value) => jsProxy['length'] = jsify(value);
}

/**
 * Options for the [onCreateDirectoryRequested] event.
 */
class CreateDirectoryRequestedOptions extends ChromeObject {
  CreateDirectoryRequestedOptions({String fileSystemId, int requestId, String directoryPath, bool recursive}) {
    if (fileSystemId != null) this.fileSystemId = fileSystemId;
    if (requestId != null) this.requestId = requestId;
    if (directoryPath != null) this.directoryPath = directoryPath;
    if (recursive != null) this.recursive = recursive;
  }
  CreateDirectoryRequestedOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get fileSystemId => jsProxy['fileSystemId'];
  set fileSystemId(String value) => jsProxy['fileSystemId'] = value;

  int get requestId => jsProxy['requestId'];
  set requestId(int value) => jsProxy['requestId'] = value;

  String get directoryPath => jsProxy['directoryPath'];
  set directoryPath(String value) => jsProxy['directoryPath'] = value;

  bool get recursive => jsProxy['recursive'];
  set recursive(bool value) => jsProxy['recursive'] = value;
}

/**
 * Options for the [onDeleteEntryRequested] event.
 */
class DeleteEntryRequestedOptions extends ChromeObject {
  DeleteEntryRequestedOptions({String fileSystemId, int requestId, String entryPath, bool recursive}) {
    if (fileSystemId != null) this.fileSystemId = fileSystemId;
    if (requestId != null) this.requestId = requestId;
    if (entryPath != null) this.entryPath = entryPath;
    if (recursive != null) this.recursive = recursive;
  }
  DeleteEntryRequestedOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get fileSystemId => jsProxy['fileSystemId'];
  set fileSystemId(String value) => jsProxy['fileSystemId'] = value;

  int get requestId => jsProxy['requestId'];
  set requestId(int value) => jsProxy['requestId'] = value;

  String get entryPath => jsProxy['entryPath'];
  set entryPath(String value) => jsProxy['entryPath'] = value;

  bool get recursive => jsProxy['recursive'];
  set recursive(bool value) => jsProxy['recursive'] = value;
}

/**
 * Options for the [onCreateFileRequested] event.
 */
class CreateFileRequestedOptions extends ChromeObject {
  CreateFileRequestedOptions({String fileSystemId, int requestId, String filePath}) {
    if (fileSystemId != null) this.fileSystemId = fileSystemId;
    if (requestId != null) this.requestId = requestId;
    if (filePath != null) this.filePath = filePath;
  }
  CreateFileRequestedOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get fileSystemId => jsProxy['fileSystemId'];
  set fileSystemId(String value) => jsProxy['fileSystemId'] = value;

  int get requestId => jsProxy['requestId'];
  set requestId(int value) => jsProxy['requestId'] = value;

  String get filePath => jsProxy['filePath'];
  set filePath(String value) => jsProxy['filePath'] = value;
}

/**
 * Options for the [onCopyEntryRequested] event.
 */
class CopyEntryRequestedOptions extends ChromeObject {
  CopyEntryRequestedOptions({String fileSystemId, int requestId, String sourcePath, String targetPath}) {
    if (fileSystemId != null) this.fileSystemId = fileSystemId;
    if (requestId != null) this.requestId = requestId;
    if (sourcePath != null) this.sourcePath = sourcePath;
    if (targetPath != null) this.targetPath = targetPath;
  }
  CopyEntryRequestedOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get fileSystemId => jsProxy['fileSystemId'];
  set fileSystemId(String value) => jsProxy['fileSystemId'] = value;

  int get requestId => jsProxy['requestId'];
  set requestId(int value) => jsProxy['requestId'] = value;

  String get sourcePath => jsProxy['sourcePath'];
  set sourcePath(String value) => jsProxy['sourcePath'] = value;

  String get targetPath => jsProxy['targetPath'];
  set targetPath(String value) => jsProxy['targetPath'] = value;
}

/**
 * Options for the [onMoveEntryRequested] event.
 */
class MoveEntryRequestedOptions extends ChromeObject {
  MoveEntryRequestedOptions({String fileSystemId, int requestId, String sourcePath, String targetPath}) {
    if (fileSystemId != null) this.fileSystemId = fileSystemId;
    if (requestId != null) this.requestId = requestId;
    if (sourcePath != null) this.sourcePath = sourcePath;
    if (targetPath != null) this.targetPath = targetPath;
  }
  MoveEntryRequestedOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get fileSystemId => jsProxy['fileSystemId'];
  set fileSystemId(String value) => jsProxy['fileSystemId'] = value;

  int get requestId => jsProxy['requestId'];
  set requestId(int value) => jsProxy['requestId'] = value;

  String get sourcePath => jsProxy['sourcePath'];
  set sourcePath(String value) => jsProxy['sourcePath'] = value;

  String get targetPath => jsProxy['targetPath'];
  set targetPath(String value) => jsProxy['targetPath'] = value;
}

/**
 * Options for the [onTruncateRequested] event.
 */
class TruncateRequestedOptions extends ChromeObject {
  TruncateRequestedOptions({String fileSystemId, int requestId, String filePath, num length}) {
    if (fileSystemId != null) this.fileSystemId = fileSystemId;
    if (requestId != null) this.requestId = requestId;
    if (filePath != null) this.filePath = filePath;
    if (length != null) this.length = length;
  }
  TruncateRequestedOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get fileSystemId => jsProxy['fileSystemId'];
  set fileSystemId(String value) => jsProxy['fileSystemId'] = value;

  int get requestId => jsProxy['requestId'];
  set requestId(int value) => jsProxy['requestId'] = value;

  String get filePath => jsProxy['filePath'];
  set filePath(String value) => jsProxy['filePath'] = value;

  num get length => jsProxy['length'];
  set length(num value) => jsProxy['length'] = jsify(value);
}

/**
 * Options for the [onWriteFileRequested] event.
 */
class WriteFileRequestedOptions extends ChromeObject {
  WriteFileRequestedOptions({String fileSystemId, int requestId, int openRequestId, num offset, ArrayBuffer data}) {
    if (fileSystemId != null) this.fileSystemId = fileSystemId;
    if (requestId != null) this.requestId = requestId;
    if (openRequestId != null) this.openRequestId = openRequestId;
    if (offset != null) this.offset = offset;
    if (data != null) this.data = data;
  }
  WriteFileRequestedOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get fileSystemId => jsProxy['fileSystemId'];
  set fileSystemId(String value) => jsProxy['fileSystemId'] = value;

  int get requestId => jsProxy['requestId'];
  set requestId(int value) => jsProxy['requestId'] = value;

  int get openRequestId => jsProxy['openRequestId'];
  set openRequestId(int value) => jsProxy['openRequestId'] = value;

  num get offset => jsProxy['offset'];
  set offset(num value) => jsProxy['offset'] = jsify(value);

  ArrayBuffer get data => _createArrayBuffer(jsProxy['data']);
  set data(ArrayBuffer value) => jsProxy['data'] = jsify(value);
}

/**
 * Options for the [onAbortRequested] event.
 */
class AbortRequestedOptions extends ChromeObject {
  AbortRequestedOptions({String fileSystemId, int requestId, int operationRequestId}) {
    if (fileSystemId != null) this.fileSystemId = fileSystemId;
    if (requestId != null) this.requestId = requestId;
    if (operationRequestId != null) this.operationRequestId = operationRequestId;
  }
  AbortRequestedOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get fileSystemId => jsProxy['fileSystemId'];
  set fileSystemId(String value) => jsProxy['fileSystemId'] = value;

  int get requestId => jsProxy['requestId'];
  set requestId(int value) => jsProxy['requestId'] = value;

  int get operationRequestId => jsProxy['operationRequestId'];
  set operationRequestId(int value) => jsProxy['operationRequestId'] = value;
}

/**
 * Options for the [onAddWatcherRequested] event.
 */
class AddWatcherRequestedOptions extends ChromeObject {
  AddWatcherRequestedOptions({String fileSystemId, int requestId, String entryPath, bool recursive}) {
    if (fileSystemId != null) this.fileSystemId = fileSystemId;
    if (requestId != null) this.requestId = requestId;
    if (entryPath != null) this.entryPath = entryPath;
    if (recursive != null) this.recursive = recursive;
  }
  AddWatcherRequestedOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get fileSystemId => jsProxy['fileSystemId'];
  set fileSystemId(String value) => jsProxy['fileSystemId'] = value;

  int get requestId => jsProxy['requestId'];
  set requestId(int value) => jsProxy['requestId'] = value;

  String get entryPath => jsProxy['entryPath'];
  set entryPath(String value) => jsProxy['entryPath'] = value;

  bool get recursive => jsProxy['recursive'];
  set recursive(bool value) => jsProxy['recursive'] = value;
}

/**
 * Options for the [onRemoveWatcherRequested] event.
 */
class RemoveWatcherRequestedOptions extends ChromeObject {
  RemoveWatcherRequestedOptions({String fileSystemId, int requestId, String entryPath, bool recursive}) {
    if (fileSystemId != null) this.fileSystemId = fileSystemId;
    if (requestId != null) this.requestId = requestId;
    if (entryPath != null) this.entryPath = entryPath;
    if (recursive != null) this.recursive = recursive;
  }
  RemoveWatcherRequestedOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get fileSystemId => jsProxy['fileSystemId'];
  set fileSystemId(String value) => jsProxy['fileSystemId'] = value;

  int get requestId => jsProxy['requestId'];
  set requestId(int value) => jsProxy['requestId'] = value;

  String get entryPath => jsProxy['entryPath'];
  set entryPath(String value) => jsProxy['entryPath'] = value;

  bool get recursive => jsProxy['recursive'];
  set recursive(bool value) => jsProxy['recursive'] = value;
}

/**
 * Information about a change happened to an entry within the observed directory
 * (including the entry itself).
 */
class Change extends ChromeObject {
  Change({String entryPath, ChangeType changeType}) {
    if (entryPath != null) this.entryPath = entryPath;
    if (changeType != null) this.changeType = changeType;
  }
  Change.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get entryPath => jsProxy['entryPath'];
  set entryPath(String value) => jsProxy['entryPath'] = value;

  ChangeType get changeType => _createChangeType(jsProxy['changeType']);
  set changeType(ChangeType value) => jsProxy['changeType'] = jsify(value);
}

/**
 * Options for the [notify] method.
 */
class NotifyOptions extends ChromeObject {
  NotifyOptions({String fileSystemId, String observedPath, bool recursive, ChangeType changeType, List<Change> changes, String tag}) {
    if (fileSystemId != null) this.fileSystemId = fileSystemId;
    if (observedPath != null) this.observedPath = observedPath;
    if (recursive != null) this.recursive = recursive;
    if (changeType != null) this.changeType = changeType;
    if (changes != null) this.changes = changes;
    if (tag != null) this.tag = tag;
  }
  NotifyOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get fileSystemId => jsProxy['fileSystemId'];
  set fileSystemId(String value) => jsProxy['fileSystemId'] = value;

  String get observedPath => jsProxy['observedPath'];
  set observedPath(String value) => jsProxy['observedPath'] = value;

  bool get recursive => jsProxy['recursive'];
  set recursive(bool value) => jsProxy['recursive'] = value;

  ChangeType get changeType => _createChangeType(jsProxy['changeType']);
  set changeType(ChangeType value) => jsProxy['changeType'] = jsify(value);

  List<Change> get changes => listify(jsProxy['changes'], _createChange);
  set changes(List<Change> value) => jsProxy['changes'] = jsify(value);

  String get tag => jsProxy['tag'];
  set tag(String value) => jsProxy['tag'] = value;
}

/**
 * Options for the [onConfigureRequested] event.
 */
class ConfigureRequestedOptions extends ChromeObject {
  ConfigureRequestedOptions({String fileSystemId, int requestId}) {
    if (fileSystemId != null) this.fileSystemId = fileSystemId;
    if (requestId != null) this.requestId = requestId;
  }
  ConfigureRequestedOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get fileSystemId => jsProxy['fileSystemId'];
  set fileSystemId(String value) => jsProxy['fileSystemId'] = value;

  int get requestId => jsProxy['requestId'];
  set requestId(int value) => jsProxy['requestId'] = value;
}

OnUnmountRequestedEvent _createOnUnmountRequestedEvent(JsObject options, JsObject successCallback, JsObject errorCallback) =>
    new OnUnmountRequestedEvent(_createUnmountRequestedOptions(options), _createProviderSuccessCallback(successCallback), _createProviderErrorCallback(errorCallback));
OnGetMetadataRequestedEvent _createOnGetMetadataRequestedEvent(JsObject options, JsObject successCallback, JsObject errorCallback) =>
    new OnGetMetadataRequestedEvent(_createGetMetadataRequestedOptions(options), _createMetadataCallback(successCallback), _createProviderErrorCallback(errorCallback));
OnReadDirectoryRequestedEvent _createOnReadDirectoryRequestedEvent(JsObject options, JsObject successCallback, JsObject errorCallback) =>
    new OnReadDirectoryRequestedEvent(_createReadDirectoryRequestedOptions(options), _createEntriesCallback(successCallback), _createProviderErrorCallback(errorCallback));
OnOpenFileRequestedEvent _createOnOpenFileRequestedEvent(JsObject options, JsObject successCallback, JsObject errorCallback) =>
    new OnOpenFileRequestedEvent(_createOpenFileRequestedOptions(options), _createProviderSuccessCallback(successCallback), _createProviderErrorCallback(errorCallback));
OnCloseFileRequestedEvent _createOnCloseFileRequestedEvent(JsObject options, JsObject successCallback, JsObject errorCallback) =>
    new OnCloseFileRequestedEvent(_createCloseFileRequestedOptions(options), _createProviderSuccessCallback(successCallback), _createProviderErrorCallback(errorCallback));
OnReadFileRequestedEvent _createOnReadFileRequestedEvent(JsObject options, JsObject successCallback, JsObject errorCallback) =>
    new OnReadFileRequestedEvent(_createReadFileRequestedOptions(options), _createFileDataCallback(successCallback), _createProviderErrorCallback(errorCallback));
OnCreateDirectoryRequestedEvent _createOnCreateDirectoryRequestedEvent(JsObject options, JsObject successCallback, JsObject errorCallback) =>
    new OnCreateDirectoryRequestedEvent(_createCreateDirectoryRequestedOptions(options), _createProviderSuccessCallback(successCallback), _createProviderErrorCallback(errorCallback));
OnDeleteEntryRequestedEvent _createOnDeleteEntryRequestedEvent(JsObject options, JsObject successCallback, JsObject errorCallback) =>
    new OnDeleteEntryRequestedEvent(_createDeleteEntryRequestedOptions(options), _createProviderSuccessCallback(successCallback), _createProviderErrorCallback(errorCallback));
OnCreateFileRequestedEvent _createOnCreateFileRequestedEvent(JsObject options, JsObject successCallback, JsObject errorCallback) =>
    new OnCreateFileRequestedEvent(_createCreateFileRequestedOptions(options), _createProviderSuccessCallback(successCallback), _createProviderErrorCallback(errorCallback));
OnCopyEntryRequestedEvent _createOnCopyEntryRequestedEvent(JsObject options, JsObject successCallback, JsObject errorCallback) =>
    new OnCopyEntryRequestedEvent(_createCopyEntryRequestedOptions(options), _createProviderSuccessCallback(successCallback), _createProviderErrorCallback(errorCallback));
OnMoveEntryRequestedEvent _createOnMoveEntryRequestedEvent(JsObject options, JsObject successCallback, JsObject errorCallback) =>
    new OnMoveEntryRequestedEvent(_createMoveEntryRequestedOptions(options), _createProviderSuccessCallback(successCallback), _createProviderErrorCallback(errorCallback));
OnTruncateRequestedEvent _createOnTruncateRequestedEvent(JsObject options, JsObject successCallback, JsObject errorCallback) =>
    new OnTruncateRequestedEvent(_createTruncateRequestedOptions(options), _createProviderSuccessCallback(successCallback), _createProviderErrorCallback(errorCallback));
OnWriteFileRequestedEvent _createOnWriteFileRequestedEvent(JsObject options, JsObject successCallback, JsObject errorCallback) =>
    new OnWriteFileRequestedEvent(_createWriteFileRequestedOptions(options), _createProviderSuccessCallback(successCallback), _createProviderErrorCallback(errorCallback));
OnAbortRequestedEvent _createOnAbortRequestedEvent(JsObject options, JsObject successCallback, JsObject errorCallback) =>
    new OnAbortRequestedEvent(_createAbortRequestedOptions(options), _createProviderSuccessCallback(successCallback), _createProviderErrorCallback(errorCallback));
OnConfigureRequestedEvent _createOnConfigureRequestedEvent(JsObject options, JsObject successCallback, JsObject errorCallback) =>
    new OnConfigureRequestedEvent(_createConfigureRequestedOptions(options), _createProviderSuccessCallback(successCallback), _createProviderErrorCallback(errorCallback));
OnMountRequestedEvent _createOnMountRequestedEvent(JsObject successCallback, JsObject errorCallback) =>
    new OnMountRequestedEvent(_createProviderSuccessCallback(successCallback), _createProviderErrorCallback(errorCallback));
OnAddWatcherRequestedEvent _createOnAddWatcherRequestedEvent(JsObject options, JsObject successCallback, JsObject errorCallback) =>
    new OnAddWatcherRequestedEvent(_createAddWatcherRequestedOptions(options), _createProviderSuccessCallback(successCallback), _createProviderErrorCallback(errorCallback));
OnRemoveWatcherRequestedEvent _createOnRemoveWatcherRequestedEvent(JsObject options, JsObject successCallback, JsObject errorCallback) =>
    new OnRemoveWatcherRequestedEvent(_createRemoveWatcherRequestedOptions(options), _createProviderSuccessCallback(successCallback), _createProviderErrorCallback(errorCallback));
FileSystemInfo _createFileSystemInfo(JsObject jsProxy) => jsProxy == null ? null : new FileSystemInfo.fromProxy(jsProxy);
Date _createDate(JsObject jsProxy) => jsProxy == null ? null : new Date.fromProxy(jsProxy);
OpenFileMode _createOpenFileMode(String value) => OpenFileMode.VALUES.singleWhere((ChromeEnum e) => e.value == value);
OpenedFile _createOpenedFile(JsObject jsProxy) => jsProxy == null ? null : new OpenedFile.fromProxy(jsProxy);
Watcher _createWatcher(JsObject jsProxy) => jsProxy == null ? null : new Watcher.fromProxy(jsProxy);
ArrayBuffer _createArrayBuffer(/*JsObject*/ jsProxy) => jsProxy == null ? null : new ArrayBuffer.fromProxy(jsProxy);
ChangeType _createChangeType(String value) => ChangeType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
Change _createChange(JsObject jsProxy) => jsProxy == null ? null : new Change.fromProxy(jsProxy);
UnmountRequestedOptions _createUnmountRequestedOptions(JsObject jsProxy) => jsProxy == null ? null : new UnmountRequestedOptions.fromProxy(jsProxy);
ProviderSuccessCallback _createProviderSuccessCallback(JsObject jsProxy) => jsProxy == null ? null : new ProviderSuccessCallback.fromProxy(jsProxy);
ProviderErrorCallback _createProviderErrorCallback(JsObject jsProxy) => jsProxy == null ? null : new ProviderErrorCallback.fromProxy(jsProxy);
GetMetadataRequestedOptions _createGetMetadataRequestedOptions(JsObject jsProxy) => jsProxy == null ? null : new GetMetadataRequestedOptions.fromProxy(jsProxy);
MetadataCallback _createMetadataCallback(JsObject jsProxy) => jsProxy == null ? null : new MetadataCallback.fromProxy(jsProxy);
ReadDirectoryRequestedOptions _createReadDirectoryRequestedOptions(JsObject jsProxy) => jsProxy == null ? null : new ReadDirectoryRequestedOptions.fromProxy(jsProxy);
EntriesCallback _createEntriesCallback(JsObject jsProxy) => jsProxy == null ? null : new EntriesCallback.fromProxy(jsProxy);
OpenFileRequestedOptions _createOpenFileRequestedOptions(JsObject jsProxy) => jsProxy == null ? null : new OpenFileRequestedOptions.fromProxy(jsProxy);
CloseFileRequestedOptions _createCloseFileRequestedOptions(JsObject jsProxy) => jsProxy == null ? null : new CloseFileRequestedOptions.fromProxy(jsProxy);
ReadFileRequestedOptions _createReadFileRequestedOptions(JsObject jsProxy) => jsProxy == null ? null : new ReadFileRequestedOptions.fromProxy(jsProxy);
FileDataCallback _createFileDataCallback(JsObject jsProxy) => jsProxy == null ? null : new FileDataCallback.fromProxy(jsProxy);
CreateDirectoryRequestedOptions _createCreateDirectoryRequestedOptions(JsObject jsProxy) => jsProxy == null ? null : new CreateDirectoryRequestedOptions.fromProxy(jsProxy);
DeleteEntryRequestedOptions _createDeleteEntryRequestedOptions(JsObject jsProxy) => jsProxy == null ? null : new DeleteEntryRequestedOptions.fromProxy(jsProxy);
CreateFileRequestedOptions _createCreateFileRequestedOptions(JsObject jsProxy) => jsProxy == null ? null : new CreateFileRequestedOptions.fromProxy(jsProxy);
CopyEntryRequestedOptions _createCopyEntryRequestedOptions(JsObject jsProxy) => jsProxy == null ? null : new CopyEntryRequestedOptions.fromProxy(jsProxy);
MoveEntryRequestedOptions _createMoveEntryRequestedOptions(JsObject jsProxy) => jsProxy == null ? null : new MoveEntryRequestedOptions.fromProxy(jsProxy);
TruncateRequestedOptions _createTruncateRequestedOptions(JsObject jsProxy) => jsProxy == null ? null : new TruncateRequestedOptions.fromProxy(jsProxy);
WriteFileRequestedOptions _createWriteFileRequestedOptions(JsObject jsProxy) => jsProxy == null ? null : new WriteFileRequestedOptions.fromProxy(jsProxy);
AbortRequestedOptions _createAbortRequestedOptions(JsObject jsProxy) => jsProxy == null ? null : new AbortRequestedOptions.fromProxy(jsProxy);
ConfigureRequestedOptions _createConfigureRequestedOptions(JsObject jsProxy) => jsProxy == null ? null : new ConfigureRequestedOptions.fromProxy(jsProxy);
AddWatcherRequestedOptions _createAddWatcherRequestedOptions(JsObject jsProxy) => jsProxy == null ? null : new AddWatcherRequestedOptions.fromProxy(jsProxy);
RemoveWatcherRequestedOptions _createRemoveWatcherRequestedOptions(JsObject jsProxy) => jsProxy == null ? null : new RemoveWatcherRequestedOptions.fromProxy(jsProxy);
