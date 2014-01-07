/* This file has been generated from sync_file_system.idl - do not edit */

/**
 * Use the `chrome.syncFileSystem` API to save and synchronize data on Google
 * Drive. This API is NOT for accessing arbitrary user docs stored in Google
 * Drive. It provides app-specific syncable storage for offline and caching
 * usage so that the same data can be available across different clients. Read
 * <a href="app_storage.html">Manage Data</a> for more on using this API.
 */
library chrome.syncFileSystem;

import '../src/files.dart';
import '../src/common.dart';

/**
 * Accessor for the `chrome.syncFileSystem` namespace.
 */
final ChromeSyncFileSystem syncFileSystem = new ChromeSyncFileSystem._();

class ChromeSyncFileSystem extends ChromeApi {
  static final JsObject _syncFileSystem = chrome['syncFileSystem'];

  ChromeSyncFileSystem._();

  bool get available => _syncFileSystem != null;

  /**
   * Returns a syncable filesystem backed by Google Drive. The returned
   * `FileSystem` instance can be operated on in the same way as the
   * Temporary and Persistant file systems (see <a
   * href="http://www.w3.org/TR/file-system-api/">http://www.w3.org/TR/file-system-api/</a>).
   * Calling this multiple times from the same app will return the same handle
   * to the same file system.
   * 
   * Returns:
   * A callback type for requestFileSystem.
   */
  Future<FileSystem> requestFileSystem() {
    if (_syncFileSystem == null) _throwNotAvailable();

    var completer = new ChromeCompleter<FileSystem>.oneArg(_createDOMFileSystem);
    _syncFileSystem.callMethod('requestFileSystem', [completer.callback]);
    return completer.future;
  }

  /**
   * Sets the default conflict resolution policy for the `'syncable'` file
   * storage for the app. By default it is set to `'last_write_win'`. When
   * conflict resolution policy is set to `'last_write_win'` conflicts for
   * existing files are automatically resolved next time the file is updated.
   * [callback] can be optionally given to know if the request has succeeded or
   * not.
   */
  Future setConflictResolutionPolicy(ConflictResolutionPolicy policy) {
    if (_syncFileSystem == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _syncFileSystem.callMethod('setConflictResolutionPolicy', [jsify(policy), completer.callback]);
    return completer.future;
  }

  /**
   * Gets the current conflict resolution policy.
   * 
   * Returns:
   * A callback type for getConflictResolutionPolicy.
   */
  Future<ConflictResolutionPolicy> getConflictResolutionPolicy() {
    if (_syncFileSystem == null) _throwNotAvailable();

    var completer = new ChromeCompleter<ConflictResolutionPolicy>.oneArg(_createConflictResolutionPolicy);
    _syncFileSystem.callMethod('getConflictResolutionPolicy', [completer.callback]);
    return completer.future;
  }

  /**
   * Returns the current usage and quota in bytes for the `'syncable'` file
   * storage for the app.
   * 
   * Returns:
   * A callback type for getUsageAndQuota.
   */
  Future<StorageInfo> getUsageAndQuota(FileSystem fileSystem) {
    if (_syncFileSystem == null) _throwNotAvailable();

    var completer = new ChromeCompleter<StorageInfo>.oneArg(_createStorageInfo);
    _syncFileSystem.callMethod('getUsageAndQuota', [jsify(fileSystem), completer.callback]);
    return completer.future;
  }

  /**
   * Returns the [FileStatus] for the given `fileEntry`. The status value can be
   * `'synced'`, `'pending'` or `'conflicting'`. Note that `'conflicting'` state
   * only happens when the service's conflict resolution policy is set to
   * `'manual'`.
   * 
   * Returns:
   * A callback type for getFileStatus.
   */
  Future<FileStatus> getFileStatus(Entry fileEntry) {
    if (_syncFileSystem == null) _throwNotAvailable();

    var completer = new ChromeCompleter<FileStatus>.oneArg(_createFileStatus);
    _syncFileSystem.callMethod('getFileStatus', [jsify(fileEntry), completer.callback]);
    return completer.future;
  }

  /**
   * Returns each [FileStatus] for the given `fileEntry` array. Typically called
   * with the result from dirReader.readEntries().
   * 
   * Returns:
   * A callback type for getFileStatuses.
   */
  Future<List<FileStatusInfo>> getFileStatuses(List<dynamic> fileEntries) {
    if (_syncFileSystem == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<FileStatusInfo>>.oneArg((e) => listify(e, _createFileStatusInfo));
    _syncFileSystem.callMethod('getFileStatuses', [jsify(fileEntries), completer.callback]);
    return completer.future;
  }

  /**
   * Returns the current sync backend status.
   * 
   * Returns:
   * A callback type for getServiceStatus.
   */
  Future<ServiceStatus> getServiceStatus() {
    if (_syncFileSystem == null) _throwNotAvailable();

    var completer = new ChromeCompleter<ServiceStatus>.oneArg(_createServiceStatus);
    _syncFileSystem.callMethod('getServiceStatus', [completer.callback]);
    return completer.future;
  }

  Stream<ServiceInfo> get onServiceStatusChanged => _onServiceStatusChanged.stream;

  final ChromeStreamController<ServiceInfo> _onServiceStatusChanged =
      new ChromeStreamController<ServiceInfo>.oneArg(_syncFileSystem, 'onServiceStatusChanged', _createServiceInfo);

  Stream<FileInfo> get onFileStatusChanged => _onFileStatusChanged.stream;

  final ChromeStreamController<FileInfo> _onFileStatusChanged =
      new ChromeStreamController<FileInfo>.oneArg(_syncFileSystem, 'onFileStatusChanged', _createFileInfo);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.syncFileSystem' is not available");
  }
}

class SyncAction extends ChromeEnum {
  static const SyncAction ADDED = const SyncAction._('added');
  static const SyncAction UPDATED = const SyncAction._('updated');
  static const SyncAction DELETED = const SyncAction._('deleted');

  static const List<SyncAction> VALUES = const[ADDED, UPDATED, DELETED];

  const SyncAction._(String str): super(str);
}

class ServiceStatus extends ChromeEnum {
  static const ServiceStatus INITIALIZING = const ServiceStatus._('initializing');
  static const ServiceStatus RUNNING = const ServiceStatus._('running');
  static const ServiceStatus AUTHENTICATION_REQUIRED = const ServiceStatus._('authentication_required');
  static const ServiceStatus TEMPORARY_UNAVAILABLE = const ServiceStatus._('temporary_unavailable');
  static const ServiceStatus DISABLED = const ServiceStatus._('disabled');

  static const List<ServiceStatus> VALUES = const[INITIALIZING, RUNNING, AUTHENTICATION_REQUIRED, TEMPORARY_UNAVAILABLE, DISABLED];

  const ServiceStatus._(String str): super(str);
}

class FileStatus extends ChromeEnum {
  static const FileStatus SYNCED = const FileStatus._('synced');
  static const FileStatus PENDING = const FileStatus._('pending');
  static const FileStatus CONFLICTING = const FileStatus._('conflicting');

  static const List<FileStatus> VALUES = const[SYNCED, PENDING, CONFLICTING];

  const FileStatus._(String str): super(str);
}

class SyncDirection extends ChromeEnum {
  static const SyncDirection LOCAL_TO_REMOTE = const SyncDirection._('local_to_remote');
  static const SyncDirection REMOTE_TO_LOCAL = const SyncDirection._('remote_to_local');

  static const List<SyncDirection> VALUES = const[LOCAL_TO_REMOTE, REMOTE_TO_LOCAL];

  const SyncDirection._(String str): super(str);
}

class ConflictResolutionPolicy extends ChromeEnum {
  static const ConflictResolutionPolicy LAST_WRITE_WIN = const ConflictResolutionPolicy._('last_write_win');
  static const ConflictResolutionPolicy MANUAL = const ConflictResolutionPolicy._('manual');

  static const List<ConflictResolutionPolicy> VALUES = const[LAST_WRITE_WIN, MANUAL];

  const ConflictResolutionPolicy._(String str): super(str);
}

class FileInfo extends ChromeObject {
  FileInfo({Entry fileEntry, FileStatus status, SyncAction action, SyncDirection direction}) {
    if (fileEntry != null) this.fileEntry = fileEntry;
    if (status != null) this.status = status;
    if (action != null) this.action = action;
    if (direction != null) this.direction = direction;
  }
  FileInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  Entry get fileEntry => _createEntry(jsProxy['fileEntry']);
  set fileEntry(Entry value) => jsProxy['fileEntry'] = jsify(value);

  FileStatus get status => _createFileStatus(jsProxy['status']);
  set status(FileStatus value) => jsProxy['status'] = jsify(value);

  SyncAction get action => _createSyncAction(jsProxy['action']);
  set action(SyncAction value) => jsProxy['action'] = jsify(value);

  SyncDirection get direction => _createSyncDirection(jsProxy['direction']);
  set direction(SyncDirection value) => jsProxy['direction'] = jsify(value);
}

class FileStatusInfo extends ChromeObject {
  FileStatusInfo({Entry fileEntry, FileStatus status, String error}) {
    if (fileEntry != null) this.fileEntry = fileEntry;
    if (status != null) this.status = status;
    if (error != null) this.error = error;
  }
  FileStatusInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  Entry get fileEntry => _createEntry(jsProxy['fileEntry']);
  set fileEntry(Entry value) => jsProxy['fileEntry'] = jsify(value);

  FileStatus get status => _createFileStatus(jsProxy['status']);
  set status(FileStatus value) => jsProxy['status'] = jsify(value);

  String get error => jsProxy['error'];
  set error(String value) => jsProxy['error'] = value;
}

class StorageInfo extends ChromeObject {
  StorageInfo({int usageBytes, int quotaBytes}) {
    if (usageBytes != null) this.usageBytes = usageBytes;
    if (quotaBytes != null) this.quotaBytes = quotaBytes;
  }
  StorageInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get usageBytes => jsProxy['usageBytes'];
  set usageBytes(int value) => jsProxy['usageBytes'] = value;

  int get quotaBytes => jsProxy['quotaBytes'];
  set quotaBytes(int value) => jsProxy['quotaBytes'] = value;
}

class ServiceInfo extends ChromeObject {
  ServiceInfo({ServiceStatus state, String description}) {
    if (state != null) this.state = state;
    if (description != null) this.description = description;
  }
  ServiceInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  ServiceStatus get state => _createServiceStatus(jsProxy['state']);
  set state(ServiceStatus value) => jsProxy['state'] = jsify(value);

  String get description => jsProxy['description'];
  set description(String value) => jsProxy['description'] = value;
}

FileSystem _createDOMFileSystem(JsObject jsProxy) => jsProxy == null ? null : new CrFileSystem.fromProxy(jsProxy);
ConflictResolutionPolicy _createConflictResolutionPolicy(String value) => ConflictResolutionPolicy.VALUES.singleWhere((ChromeEnum e) => e.value == value);
StorageInfo _createStorageInfo(JsObject jsProxy) => jsProxy == null ? null : new StorageInfo.fromProxy(jsProxy);
FileStatus _createFileStatus(String value) => FileStatus.VALUES.singleWhere((ChromeEnum e) => e.value == value);
FileStatusInfo _createFileStatusInfo(JsObject jsProxy) => jsProxy == null ? null : new FileStatusInfo.fromProxy(jsProxy);
ServiceStatus _createServiceStatus(String value) => ServiceStatus.VALUES.singleWhere((ChromeEnum e) => e.value == value);
ServiceInfo _createServiceInfo(JsObject jsProxy) => jsProxy == null ? null : new ServiceInfo.fromProxy(jsProxy);
FileInfo _createFileInfo(JsObject jsProxy) => jsProxy == null ? null : new FileInfo.fromProxy(jsProxy);
Entry _createEntry(JsObject jsProxy) => jsProxy == null ? null : new CrEntry.fromProxy(jsProxy);
SyncAction _createSyncAction(String value) => SyncAction.VALUES.singleWhere((ChromeEnum e) => e.value == value);
SyncDirection _createSyncDirection(String value) => SyncDirection.VALUES.singleWhere((ChromeEnum e) => e.value == value);
