library chrome.sync_file_system;

import 'dart:async';

import 'package:js/js.dart' as js;

import 'common.dart';
import 'files.dart';

/// Accessor for the `chrome.syncFileSystem` namespace.
///
/// Additional documentation is available here:
///   http://developer.chrome.com/apps/syncFileSystem.html
final SyncFileSystem syncFileSystem  = new SyncFileSystem._();

/**
 * Use the chrome.syncFileSystem API to save and synchronize data on Google
 * Drive. This API is NOT for accessing arbitrary user docs stored in Google
 * Drive. It provides app-specific syncable storage for offline and caching
 * usage so that the same data can be available across different clients.
 *
 * The 'syncFileSystem' permission is required.
 *
 * Valid values for FileStatus are: 'synced', 'pending', and 'conflicting'.
 * Valid values for ConflictResolutionPolicy are: 'last_write_win' and 'manual'.
 */
class SyncFileSystem {
  SyncFileSystem._();

  /**
   * Returns a syncable filesystem backed by Google Drive. The returned
   * DOMFileSystem instance can be operated on in the same way as the Temporary
   * and Persistant file systems (see http://www.w3.org/TR/file-system-api/).
   * Calling this multiple times from the same app will return the same handle
   * to the same file system.
   *
   * see [chrome.FileSystem]
   */
  Future<FileSystem> requestFileSystem() {
    ChromeCompleter<FileSystem> completer = new ChromeCompleter.oneArg(FileSystem.createFrom);
    chromeProxy.syncFileSystem.requestFileSystem(completer.callback);
    return completer.future;
  }

  /**
   * Sets the default conflict resolution policy for the 'syncable' file storage
   * for the app. By default it is set to 'last_write_win'. When conflict
   * resolution policy is set to 'last_write_win' conflicts for existing files
   * are automatically resolved next time the file is updated. |callback| can be
   * optionally given to know if the request has succeeded or not.
   */
  void setConflictResolutionPolicy(String policy) {
    // TODO: support the optional success callback
    // the callback indicated has no parameters - how to tell whether a call
    // means success or failure?
    chromeProxy.syncFileSystem.setConflictResolutionPolicy(policy);
  }

  /**
   * Gets the current conflict resolution policy.
   */
  Future<String> getConflictResolutionPolicy() {
    ChromeCompleter<String> completer = new ChromeCompleter.oneArg();
    chromeProxy.syncFileSystem.getConflictResolutionPolicy(completer.callback);
    return completer.future;
  }

  /**
   * Returns the current usage and quota in bytes for the 'syncable' file
   * storage for the app.
   */
  Future<UsageAndQuota> getUsageAndQuota(FileSystem fileSystem) {
    ChromeCompleter<UsageAndQuota> completer = new ChromeCompleter.oneArg((var quota) {
      return new UsageAndQuota._(quota);
    });
    chromeProxy.syncFileSystem.getUsageAndQuota(fileSystem.proxy, completer.callback);
    return completer.future;
  }

  /**
   * Returns the FileStatus for the given fileEntry. The status value can be
   * 'synced', 'pending' or 'conflicting'. Note that 'conflicting' state only
   * happens when the service's conflict resolution policy is set to 'manual'.
   */
  Future<String> getFileStatus(FileEntry fileEntry) {
    ChromeCompleter<String> completer = new ChromeCompleter.oneArg();
    chromeProxy.syncFileSystem.getFileStatus(fileEntry.proxy, completer.callback);
    return completer.future;
  }

  /**
   * Returns each FileStatus for the given fileEntry array. Typically called
   * with the result from dirReader.readEntries().
   */
  Future<List<FileEntryStatus>> getFileStatuses(List<FileEntry> fileEntries) {
    ChromeCompleter<List<FileEntryStatus>> completer =
        new ChromeCompleter.oneArg((var proxy) {
          Iterable<FileEntryStatus> iter = listify(proxy).map(
              (proxy) => new FileEntryStatus._(proxy));
          return iter.toList();
        });
    List proxies = fileEntries.map((entry) => entry.proxy);
    chromeProxy.syncFileSystem.getFileStatuses(proxies, completer.callback);
    return completer.future;
  }

  final ChromeStreamController<ServiceStatusEvent> _onServiceStatusChanged =
      new ChromeStreamController<ServiceStatusEvent>.oneArg(
          () => chromeProxy.syncFileSystem.onServiceStatusChanged,
          (event) => new ServiceStatusEvent._(event));

  /**
   * Fired when an error or other status change has happened in the sync backend
   * (for example, when the sync is temporarily disabled due to network or
   * authentication error).
   */
  Stream<ServiceStatusEvent> get onServiceStatusChanged => _onServiceStatusChanged.stream;

  final ChromeStreamController<FileStatusEvent> _onFileStatusChanged =
      new ChromeStreamController<FileStatusEvent>.oneArg(
          () => chromeProxy.syncFileSystem.onFileStatusChanged,
          (event) => new FileStatusEvent._(event));

  /**
   * Fired when a file has been updated by the background sync service.
   */
  Stream<FileStatusEvent> get onFileStatusChanged => _onFileStatusChanged.stream;
}

class UsageAndQuota {
  int usageBytes;
  int quotaBytes;

  UsageAndQuota._(var proxy) {
    usageBytes = proxy.usageBytes;
    quotaBytes = proxy.quotaBytes;
  }
}

class FileEntryStatus {
  /**
   * One of the Entry's originally given to getFileStatuses.
   */
  FileEntry fileEntry;

  /**
   * The status value can be 'synced', 'pending' or 'conflicting'.
   */
  String status;

  /**
   * Optional error that is only returned if there was a problem retrieving the
   * FileStatus for the given file.
   */
  String error;

  FileEntryStatus._(var proxy) {
    fileEntry = Entry.createFrom(proxy.fileEntry);
    status = proxy.status;
    try { error = proxy.error; } catch (e) { }
  }

  void dispose() => fileEntry.release();

  String toString() => "file status: ${fileEntry.name}, ${status}";
}

/**
 * An event for the onServiceStatusChanged event.
 */
class ServiceStatusEvent {
  /**
   * One of 'initializing', 'running', 'authentication_required',
   * 'temporary_unavailable', or 'disabled'.
   */
  String state;

  String description;

  ServiceStatusEvent._(var proxy) {
    state = proxy.state;
    description = proxy.description;
  }

  String toString() => "service status: ${state}, ${description}";
}

/**
 * An event for the onFileStatusChanged event.
 */
class FileStatusEvent {
  /**
   * fileEntry for the target file whose status has changed. Contains name and
   * path information of synchronized file. On file deletion, fileEntry
   * information will still be available but file will no longer exist.
   */
  FileEntry fileEntry;

  /**
   * Resulting file status after onFileStatusChanged event. The status value can
   * be 'synced', 'pending' or 'conflicting'.
   */
  String status;

  /**
   * Sync action taken to fire onFileStatusChanged event. The action value can
   * be 'added', 'updated' or 'deleted'. Only applies if status is 'synced'.
   */
  String action;

  /**
   * Sync direction for the onFileStatusChanged event. Sync direction value can
   * be 'local_to_remote' or 'remote_to_local'. Only applies if status is 'synced'.
   */
  String direction;

  FileStatusEvent._(var proxy) {
    // TODO: I am a tad worried about these leaking. Perhaps we should dispose
    // of the event after the stream controller has notified all listeners?
    fileEntry = Entry.createFrom(proxy.fileEntry);
    status = proxy.status;
    try { action = proxy.action; } catch (e) { }
    try { direction = proxy.direction; } catch (e) { }
  }

  void dispose() => fileEntry.release();

  String toString() => "file status: ${fileEntry.name}, ${status}"
    ", ${action}, ${direction}";
}
