library chrome.file_system;

import 'dart:async';
import 'dart:html';
import 'dart:typed_data';

import 'package:js/js.dart' as js;
import 'package:meta/meta.dart';

import 'common.dart';

/// Accessor for the `chrome.fileSystem` namespace.
final ChromeFileSystem fileSystem  = new ChromeFileSystem._();

/**
 * Use the chrome.fileSystem API to create, read, navigate, and write to a
 * sandboxed section of the user's local file system. With this API, packaged
 * apps can read and write to a user-selected location. For example, a text
 * editor app can use the API to read and write local documents.
 */
class ChromeFileSystem {

  ChromeFileSystem._();

  dynamic get _fileSystem => (js.context as dynamic).chrome.fileSystem;

  /**
   * Get the display path of a FileEntry object. The display path is based on
   * the full path of the file on the local file system, but may be made more
   * readable for display purposes.
   */
  Future<String> getDisplayPath(FileEntry fileEntry) {
    ChromeCompleter<String> completer = new ChromeCompleter.oneArg();
    _fileSystem.getDisplayPath(fileEntry, completer.callback);
    return completer.future;
  }

  /**
   * Get a writable FileEntry from another FileEntry. This call will fail if the
   * application does not have the 'write' permission under 'fileSystem'.
   *
   * Note that this will soon be deprecated.
   */
  @deprecated
  Future<FileEntry> getWritableEntry(FileEntry fileEntry) {
    ChromeCompleter<FileEntry> completer = new ChromeCompleter.oneArg();
    _fileSystem.getWritableEntry(fileEntry, completer.callback);
    return completer.future;
  }

  /**
   * Gets whether this FileEntry is writable or not.
   *
   * Note that this will soon be deprecated.
   */
  @deprecated
  Future<bool> isWritableEntry(FileEntry fileEntry) {
    ChromeCompleter<bool> completer = new ChromeCompleter.oneArg();
    _fileSystem.isWritableEntry(fileEntry, completer.callback);
    return completer.future;
  }

  /**
   * Ask the user to choose a file.
   *
   * [type] is one of 'openFile', 'openWritableFile', 'saveFile'. Note that
   * 'openWritableFile' will soon be deprecated.
   */
  Future<FileEntry> chooseEntry({
    String type: 'openFile',
    String suggestedName,
    List<ChooseEntryAccepts> accepts,
    bool acceptsAllTypes: true}) {

    Map<String, dynamic> options = {};
    if (type != null) options['type'] = type;
    if (suggestedName != null) options['suggestedName'] = suggestedName;
    if (accepts != null) options['openFile'] = js.array(accepts);
    if (acceptsAllTypes != null) options['acceptsAllTypes'] = acceptsAllTypes;

    ChromeCompleter<FileEntry> completer = new ChromeCompleter.twoArgs(
        (fileEntry, fileEntries) => fileEntry);
    _fileSystem.chooseEntry(js.map(options), completer.callback);
    return completer.future;
  }

  /**
   * Ask the user to choose (open) a directory. This is sugar for the
   * chrome.fileSystem.chooseEntry call.
   */
  Future<DirectoryEntry> chooseEntryDirectory({
    String suggestedName,
    List<ChooseEntryAccepts> accepts,
    bool acceptsAllTypes: true}) {

    Map<String, dynamic> options = {};
    options['type'] = 'openDirectory';
    if (suggestedName != null) options['suggestedName'] = suggestedName;
    if (accepts != null) options['openFile'] = js.array(accepts);
    if (acceptsAllTypes != null) options['acceptsAllTypes'] = acceptsAllTypes;

    ChromeCompleter<DirectoryEntry> completer = new ChromeCompleter.twoArgs(
        (fileEntry, fileEntries) => fileEntry);
    _fileSystem.chooseEntry(js.map(options), completer.callback);
    return completer.future;
  }

  /**
   * Ask the user to choose one or more files. This is sugar for the
   * chrome.fileSystem.chooseEntry call.
   *
   * [type] is one of "openFile", "openWritableFile", or "saveFile"
   */
  Future<List<FileEntry>> chooseEntries({
    String type: 'openFile',
    String suggestedName,
    List<ChooseEntryAccepts> accepts,
    bool acceptsAllTypes: true}) {

    Map<String, dynamic> options = {};
    if (type != null) options['type'] = type;
    if (suggestedName != null) options['suggestedName'] = suggestedName;
    if (accepts != null) options['openFile'] = js.array(accepts);
    if (acceptsAllTypes != null) options['acceptsAllTypes'] = acceptsAllTypes;
    options['acceptsMultiple'] = true;

    ChromeCompleter<List<FileEntry>> completer = new ChromeCompleter.twoArgs((fileEntry, fileEntries) {
      if (fileEntries != null) {
        return fileEntries;
      } else if (fileEntry != null) {
        return [fileEntry];
      } else {
        return null;
      }
    });
    _fileSystem.chooseEntry(js.map(options), completer.callback);
    return completer.future;
  }

  /**
   * Returns the file entry with the given id if it can be restored. This call
   * will fail otherwise. This method is new in Chrome 30.
   */
  Future<FileEntry> restoreEntry(String id) {
    ChromeCompleter<FileEntry> completer = new ChromeCompleter.oneArg();
    _fileSystem.restoreEntry(id, completer.callback);
    return completer.future;
  }

  /**
   * Returns whether a file entry for the given id can be restored, i.e. whether
   * restoreEntry would succeed with this id now. This method is new in Chrome
   * 30.
   */
  Future<bool> isRestorable(String id) {
    ChromeCompleter<bool> completer = new ChromeCompleter.oneArg();
    _fileSystem.isRestorable(id, completer.callback);
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
  String retainEntry(FileEntry fileEntry) {
    return _fileSystem.retainEntry(fileEntry);
  }
}

// FileEntry interface definition:
//   http://www.w3.org/TR/file-system-api/#the-fileentry-interface
//   http://dev.w3.org/2006/webapi/FileAPI/

//interface Entry {
//    readonly attribute boolean    isFile;
//    readonly attribute boolean    isDirectory;
//    void      getMetadata (MetadataCallback successCallback, optional ErrorCallback errorCallback);
//    readonly attribute DOMString  name;
//    readonly attribute DOMString  fullPath;
//    readonly attribute FileSystem filesystem;
//    void      moveTo (DirectoryEntry parent, optional DOMString newName, optional EntryCallback successCallback, optional ErrorCallback errorCallback);
//    void      copyTo (DirectoryEntry parent, optional DOMString newName, optional EntryCallback successCallback, optional ErrorCallback errorCallback);
//    DOMString toURL ();
//    void      remove (VoidCallback successCallback, optional ErrorCallback errorCallback);
//    void      getParent (EntryCallback successCallback, optional ErrorCallback errorCallback);
//};

/*
 * Utility methods for dealing with FileEntries (not strictly part of the chrome
 * app API).
 */

/**
 * A conveinence method to read data from a dom [FileEntry]. The file contents
 * are returned as text.
 *
 * Errors will come back through the Future as [FileError].
 */
Future<String> fileEntryRead(FileEntry fileEntry, [String encoding]) {
  return fileEntry.file().then((File file) {
    Completer<String> completer = new Completer();
    FileReader reader = new FileReader();
    reader.onLoadEnd.listen((_) => completer.complete(reader.result));
    reader.onError.listen((_) => completer.completeError(reader.error));
    if (encoding == null) {
      reader.readAsText(file);
    } else {
      reader.readAsText(file, encoding);
    }
    return completer.future;
  });
}

/**
 * A conveinence method to read data from a dom [FileEntry]. The file contents
 * are returned as binary (a list of ints).
 *
 * Errors will come back through the Future as [FileError].
 */
Future<List<int>> fileEntryReadBinary(FileEntry fileEntry) {
  return fileEntry.file().then((File file) {
    Completer<List<int>> completer = new Completer();
    FileReader reader = new FileReader();
    reader.onLoadEnd.listen((_) => completer.complete(new Uint8List.view(reader.result)));
    reader.onError.listen((_) => completer.completeError(reader.error));
    reader.readAsArrayBuffer(file);
    return completer.future;
  });
}

/**
 * A conveinence method to write text to a dom [FileEntry]. On success, the same
 * [FileEntry] is returned from the Future.
 *
 * Errors will come back through the Future as [FileError].
 */
Future<FileEntry> fileEntryWrite(FileEntry fileEntry, String text) {
  return fileEntry.createWriter().then((FileWriter writer) {
    Completer<FileEntry> completer = new Completer();
    writer.onWriteEnd.listen((_) => completer.complete(fileEntry));
    writer.onError.listen((_) => completer.completeError(writer.error));
    writer.write(new Blob([text]));
    return completer.future;
  });
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
