library chrome.file_system;

import 'dart:async';

import 'package:js/js.dart' as js;

import 'common.dart';
import 'files.dart';

/// Accessor for the `chrome.fileSystem` namespace.
///
/// Additional documentation is available here:
///   http://developer.chrome.com/apps/fileSystem.html.
final ChromeFileSystem fileSystem  = new ChromeFileSystem._();

/**
 * Use the chrome.fileSystem API to create, read, navigate, and write to a
 * sandboxed section of the user's local file system. With this API, packaged
 * apps can read and write to a user-selected location. For example, a text
 * editor app can use the API to read and write local documents.
 */
class ChromeFileSystem {

  ChromeFileSystem._();

  /**
   * Get the display path of an Entry object. The display path is based on the
   * full path of the file or directory on the local file system, but may be
   * made more readable for display purposes.
   */
  Future<String> getDisplayPath(Entry entry) {
    ChromeCompleter<String> completer = new ChromeCompleter.oneArg();
    chromeProxy.fileSystem.getDisplayPath(entry.proxy, completer.callback);
    return completer.future;
  }

  /**
   * Get a writable Entry from another Entry. This call will fail if the
   * application does not have the 'write' permission under 'fileSystem'. If
   * entry is a DirectoryEntry, this call will fail if the application does not
   * have the 'directory' permission under 'fileSystem'.
   *
   * Note that this will soon be deprecated.
   */
  @deprecated
  Future<Entry> getWritableEntry(Entry entry) {
    ChromeCompleter<Entry> completer = new ChromeCompleter.oneArg(Entry.createFrom);
    chromeProxy.fileSystem.getWritableEntry(entry.proxy, completer.callback);
    return completer.future;
  }

  /**
   * Gets whether this Entry is writable or not.
   *
   * Note that this will soon be deprecated.
   */
  @deprecated
  Future<bool> isWritableEntry(Entry entry) {
    ChromeCompleter<bool> completer = new ChromeCompleter.oneArg();
    chromeProxy.fileSystem.isWritableEntry(entry.proxy, completer.callback);
    return completer.future;
  }

  /**
   * Ask the user to choose a file.
   *
   * [type] is one of 'openFile', 'openWritableFile', 'saveFile'. Note that
   * 'openWritableFile' will soon be deprecated.
   *
   * This will return a dom FileEntry. js.retain() has been called on it; it is
   * the caller's responsibility to call js.release();
   */
  Future<FileEntry> chooseEntry({
    String type: 'openFile',
    String suggestedName,
    List<ChooseEntryAccepts> accepts,
    bool acceptsAllTypes: true}) {

    Map<String, dynamic> options = {};
    if (type != null) options['type'] = type;
    if (suggestedName != null) options['suggestedName'] = suggestedName;
    if (accepts != null) options['accepts'] = js.array(accepts);
    if (acceptsAllTypes != null) options['acceptsAllTypes'] = acceptsAllTypes;

    ChromeCompleter<FileEntry> completer = new ChromeCompleter.twoArgs(
        (fileEntry, fileEntries) => new FileEntry.retain(fileEntry));
    chromeProxy.fileSystem.chooseEntry(js.map(options), completer.callback);
    return completer.future;
  }

  /**
   * Ask the user to choose (open) a directory. This is sugar for the
   * chrome.fileSystem.chooseEntry call.
   *
   * This will return a dom DirectoryEntry. js.retain() has been called on it;
   * it is the caller's responsibility to call js.release();
   */
  Future<DirectoryEntry> chooseEntryDirectory({
    String suggestedName,
    List<ChooseEntryAccepts> accepts,
    bool acceptsAllTypes: true}) {

    Map<String, dynamic> options = {};
    options['type'] = 'openDirectory';
    if (suggestedName != null) options['suggestedName'] = suggestedName;
    if (accepts != null) options['accepts'] = js.array(accepts);
    if (acceptsAllTypes != null) options['acceptsAllTypes'] = acceptsAllTypes;

    ChromeCompleter<DirectoryEntry> completer = new ChromeCompleter.twoArgs(
        (fileEntry, fileEntries) => new DirectoryEntry.retain(fileEntry));
    chromeProxy.fileSystem.chooseEntry(js.map(options), completer.callback);
    return completer.future;
  }

  /**
   * Ask the user to choose one or more files. This is sugar for the
   * chrome.fileSystem.chooseEntry call.
   *
   * [type] is one of "openFile", "openWritableFile", or "saveFile"
   *
   * This will return a list of dom FileEntry objects.
   */
  Future<List<FileEntry>> chooseEntries({
    String type: 'openFile',
    String suggestedName,
    List<ChooseEntryAccepts> accepts,
    bool acceptsAllTypes: true}) {

    Map<String, dynamic> options = {};
    if (type != null) options['type'] = type;
    if (suggestedName != null) options['suggestedName'] = suggestedName;
    if (accepts != null) options['accepts'] = js.array(accepts);
    if (acceptsAllTypes != null) options['acceptsAllTypes'] = acceptsAllTypes;
    options['acceptsMultiple'] = true;

    ChromeCompleter<List<FileEntry>> completer = new ChromeCompleter.twoArgs((fileEntry, fileEntries) {
      if (fileEntries != null) {
        return listify(fileEntries).map((entry) => Entry.createFrom(entry));
      } else if (fileEntry != null) {
        return [Entry.createFrom(fileEntry)];
      } else {
        return null;
      }
    });
    chromeProxy.fileSystem.chooseEntry(js.map(options), completer.callback);
    return completer.future;
  }

  /**
   * Returns the file entry with the given id if it can be restored. This call
   * will fail otherwise. This method is new in Chrome 30.
   *
   * This will return a dom FileEntry. js.retain() has been called on it; it is
   * the caller's responsibility to call js.release();
   */
  Future<Entry> restoreEntry(String id) {
    ChromeCompleter<FileEntry> completer = new ChromeCompleter.oneArg(Entry.createFrom);
    chromeProxy.fileSystem.restoreEntry(id, completer.callback);
    return completer.future;
  }

  /**
   * Returns whether a file entry for the given id can be restored, i.e. whether
   * restoreEntry would succeed with this id now. This method is new in Chrome
   * 30.
   */
  Future<bool> isRestorable(String id) {
    ChromeCompleter<bool> completer = new ChromeCompleter.oneArg();
    chromeProxy.fileSystem.isRestorable(id, completer.callback);
    return completer.future;
  }

  /**
   * Returns an id that can be passed to restoreEntry to regain access to a
   * given file entry. Only the 500 most recently used entries are retained,
   * where calls to retainEntry and restoreEntry count as use. If the app has
   * the 'retainEntries' permission under 'fileSystem' (currently restricted to
   * dev channel), entries are retained indefinitely. Otherwise, entries are
   * retained only while the app is running and across restarts. This method is
   * new in Chrome 30.
   */
  String retainEntry(Entry entry) {
    return chromeProxy.fileSystem.retainEntry(entry.proxy);
  }
}

/**
 * For use in the [ChromeFileSystem.chooseEntry] and
 * [ChromeFileSystem.chooseEntry] methods.
 */
class ChooseEntryAccepts implements js.Serializable {
  /**
   * This is the optional text description for this option. If not present, a
   * description will be automatically generated; typically containing an
   * expanded list of valid extensions (e.g. "text/html" may expand to "*.html,
   * *.htm").
   */
  String description;

  /**
   * Mime-types to accept, e.g. "image/jpeg" or "audio/ *". One of mimeTypes or
   * extensions must contain at least one valid element.
   */
  List<String> mimeTypes;

  /**
   * Extensions to accept, e.g. "jpg", "gif", "crx".
   */
  List<String> extensions;

  ChooseEntryAccepts({this.description, this.mimeTypes, this.extensions});

  dynamic toJs() {
    Map m = {};

    if (description != null) m['description'] = description;
    if (mimeTypes != null) m['mimeTypes'] = mimeTypes;
    if (extensions != null) m['extensions'] = extensions;

    return js.map(m);
  }
}
