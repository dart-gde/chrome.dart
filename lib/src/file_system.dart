library chrome.file_system;

import 'dart:async';

import 'package:js/js.dart' as js;
import 'package:meta/meta.dart';

import 'common.dart';

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
   * Get the display path of a FileEntry object. The display path is based on
   * the full path of the file on the local file system, but may be made more
   * readable for display purposes.
   *
   * [fileEntry] should be a dom FileEntry
   */
  Future<String> getDisplayPath(js.Proxy fileEntry) {
    ChromeCompleter<String> completer = new ChromeCompleter.oneArg();
    chromeProxy.fileSystem.getDisplayPath(fileEntry, completer.callback);
    return completer.future;
  }

  /**
   * Get a writable FileEntry from another FileEntry. This call will fail if the
   * application does not have the 'write' permission under 'fileSystem'.
   *
   * [fileEntry] should be a dom FileEntry
   *
   * Note that this will soon be deprecated.
   */
  @deprecated
  Future<js.Proxy> getWritableEntry(js.Proxy fileEntry) {
    ChromeCompleter<js.Proxy> completer = new ChromeCompleter.oneArg(js.retain);
    chromeProxy.fileSystem.getWritableEntry(fileEntry, completer.callback);
    return completer.future;
  }

  /**
   * Gets whether this FileEntry is writable or not.
   *
   * [fileEntry] should be a dom FileEntry
   *
   * Note that this will soon be deprecated.
   */
  @deprecated
  Future<bool> isWritableEntry(js.Proxy fileEntry) {
    ChromeCompleter<bool> completer = new ChromeCompleter.oneArg();
    chromeProxy.fileSystem.isWritableEntry(fileEntry, completer.callback);
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
  Future<js.Proxy> chooseEntry({
    String type: 'openFile',
    String suggestedName,
    List<ChooseEntryAccepts> accepts,
    bool acceptsAllTypes: true}) {

    Map<String, dynamic> options = {};
    if (type != null) options['type'] = type;
    if (suggestedName != null) options['suggestedName'] = suggestedName;
    if (accepts != null) options['accepts'] = js.array(accepts);
    if (acceptsAllTypes != null) options['acceptsAllTypes'] = acceptsAllTypes;

    ChromeCompleter<js.Proxy> completer = new ChromeCompleter.twoArgs(
        (fileEntry, fileEntries) => js.retain(fileEntry));
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
  Future<js.Proxy> chooseEntryDirectory({
    String suggestedName,
    List<ChooseEntryAccepts> accepts,
    bool acceptsAllTypes: true}) {

    Map<String, dynamic> options = {};
    options['type'] = 'openDirectory';
    if (suggestedName != null) options['suggestedName'] = suggestedName;
    if (accepts != null) options['accepts'] = js.array(accepts);
    if (acceptsAllTypes != null) options['acceptsAllTypes'] = acceptsAllTypes;

    ChromeCompleter<js.Proxy> completer = new ChromeCompleter.twoArgs(
        (fileEntry, fileEntries) => js.retain(fileEntry));
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
  Future<List<js.Proxy>> chooseEntries({
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

    ChromeCompleter<List<js.Proxy>> completer = new ChromeCompleter.twoArgs((fileEntry, fileEntries) {
      if (fileEntries != null) {
        return js.retain(fileEntries);
      } else if (fileEntry != null) {
        return [js.retain(fileEntry)];
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
  Future<js.Proxy> restoreEntry(String id) {
    ChromeCompleter<js.Proxy> completer = new ChromeCompleter.oneArg(js.retain);
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
   *
   * [fileEntry] should be a dom FileEntry
   */
  String retainEntry(js.Proxy fileEntry) {
    return chromeProxy.fileSystem.retainEntry(fileEntry);
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

/*
 * Utility methods for dealing with FileEntries (not strictly part of the chrome
 * app API).
 */

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

/**
 * The abstract parent of FileEntry and DirectoryEntry.
 */
abstract class Entry {
  var _proxy;

  Entry(this._proxy);

  Entry.retain(this._proxy) {
    js.retain(_proxy);
  }

  /**
   * The name of the entry, excluding the path leading to it.
   */
  String get name => _proxy.name;

  /**
   * The full absolute path from the root to the entry.
   */
  String get fullPath => _proxy.fullPath;

  /**
   * Entry is a directory.
   */
  bool get isDirectory => _proxy.isDirectory;

  /**
   * Entry is a file.
   */
  bool get isFile => _proxy.isFile;

  String toString() => name;

  /**
   * Call [js.release] on the retained proxy.
   */
  void release() {
    js.release(_proxy);
  }

  js.Proxy get proxy => _proxy;
}

/**
 * A class to make working with js.Proxy instances that represent a dom
 * FileEntry.
 *
 * see: http://www.w3.org/TR/file-system-api/
 * see: http://dev.w3.org/2006/webapi/FileAPI/
 */
class FileEntry extends Entry {

  /**
   * Create a new FileEntry instance, given a [js.Proxy] reference to a dom
   * FileEntry.
   */
  FileEntry(js.Proxy proxy): super(proxy);

  /**
   * Create a new FileEntry instance, given a [js.Proxy] reference to a dom
   * FileEntry. Additionally, call [js.retain] on the proxy.
   */
  FileEntry.retain(js.Proxy proxy): super.retain(proxy);

  // TODO: test reading with errors

  /**
   * Return the contents of the file as a String.
   */
  Future<String> readText() {
    Completer<String> completer = new Completer();

    js.Callback loadCallback = new js.Callback.once((var event) {
      completer.complete(event.target.result);
    });

    js.Callback errorCallback = new js.Callback.once((var domError) {
      completer.completeError(domError);
    });

    js.Callback fileCallback = new js.Callback.once((var file) {
      var reader = new js.Proxy((js.context as dynamic).FileReader);
      reader.onloadend = loadCallback;
      reader.onerror = errorCallback;
      reader.readAsText(file);
    });

    _proxy.file(fileCallback, errorCallback);

    return completer.future;
  }

//  // TODO: implement
//  /**
//   * Return the contents of the file as binary.
//   */
//  Future<List<int>> readBinary() {
//    Completer<String> completer = new Completer();
//
//    js.Callback loadCallback = new js.Callback.once((var event) {
//      // TODO: event.target.result is an ArrayBuffer
//
//      completer.complete(event.target.result);
//    });
//
//    js.Callback errorCallback = new js.Callback.once((var domError) {
//      completer.completeError(domError);
//    });
//
//    js.Callback fileCallback = new js.Callback.once((var file) {
//      var reader = new js.Proxy((js.context as dynamic).FileReader);
//      reader.onloadend = loadCallback;
//      reader.onerror = errorCallback;
//      reader.readAsArrayBuffer(file);
//    });
//
//    _proxy.file(fileCallback, errorCallback);
//
//    return completer.future;
//  }

  /**
   * Write out the given String to the file. On success, a references to [this]
   * is returned.
   */
  Future<FileEntry> writeText(String text) {
    Completer<FileEntry> completer = new Completer();

    js.Callback writeEndCallback = new js.Callback.once((var event) {
        completer.complete(this);
    });

    js.Callback errorCallback = new js.Callback.once((var event) {
      completer.completeError(event);
    });

    js.Callback writerCallback = new js.Callback.once((var writer) {
      // blob = new Blob([contents])
      var blob = new js.Proxy((js.context as dynamic).Blob, js.array([text]));
      writer.onwriteend = writeEndCallback;
      writer.onerror = errorCallback;
      writer.write(blob, js.map({'type': 'text/plain'}));
    });

//    TODO: the writeable entry stuff should be going away
//    js.Callback writeableCallback = new js.Callback.once((var writeableEntry) {
//      _proxy.createWriter(writerCallback, errorCallback);
//    });
//
//    chromeProxy.fileSystem.getWritableEntry(_proxy, writeableCallback);
    _proxy.createWriter(writerCallback, errorCallback);

    return completer.future;
  }
}

/**
 * A class to make working with js.Proxy instances that represent a dom
 * DirectoryEntry.
 *
 * see: http://www.w3.org/TR/file-system-api/
 * see: http://dev.w3.org/2006/webapi/FileAPI/
 */
class DirectoryEntry extends Entry {

  /**
   * Create a new DirectoryEntry instance, given a [js.Proxy] reference to a dom
   * DirectoryEntry.
   */
  DirectoryEntry(js.Proxy proxy): super(proxy);

  /**
   * Create a new DirectoryEntry instance, given a [js.Proxy] reference to a dom
   * DirectoryEntry. Additionally, call [js.retain] on the proxy.
   */
  DirectoryEntry.retain(js.Proxy proxy): super.retain(proxy);

}

/**
 * A class to make working with js.Proxy instances that represent a dom
 * FileSystem.
 *
 * see: http://www.w3.org/TR/file-system-api/
 */
class FileSystem {
  var _proxy;

  FileSystem(this._proxy);

  FileSystem.retain(this._proxy) {
    js.retain(_proxy);
  }

  /**
   * The name of the entry, excluding the path leading to it.
   */
  String get name => _proxy.name;

  /**
   * The root directory of the file system.
   */
  DirectoryEntry get root => new DirectoryEntry.retain(_proxy.root);

  String toString() => name;

  /**
   * Call [js.release] on the retained proxy.
   */
  void release() {
    js.release(_proxy);
  }

  js.Proxy get proxy => _proxy;
}

///**
// * A convenience method to read data from a dom [FileEntry]. The file contents
// * are returned as binary (a list of ints).
// *
// * Errors will come back through the Future as [FileError].
// */
//Future<List<int>> fileEntryReadBinary(FileEntry fileEntry) {
//  return fileEntry.file().then((File file) {
//    Completer<List<int>> completer = new Completer();
//    FileReader reader = new FileReader();
//    reader.onLoadEnd.listen((_) => completer.complete(new Uint8List.view(reader.result)));
//    reader.onError.listen((_) => completer.completeError(reader.error));
//    reader.readAsArrayBuffer(file);
//    return completer.future;
//  });
//}
