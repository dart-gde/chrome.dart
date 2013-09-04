/**
 * Utility methods for dealing with FileEntries (not strictly part of the chrome
 * app API).
 */
library chrome.files;

import 'dart:async';

import 'package:js/js.dart' as js;

import 'common.dart';

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

  /**
   * Create and return a new DirectoryEntry given a js.Proxy to a dom
   * DirectoryEntry. js.retain is automatically called on the proxy. It is the
   * caller's responsibility to call DirectoryEntry.release().
   */
  static Entry createFrom(js.Proxy proxy) {
    if ((proxy as dynamic).isFile) {
      return new FileEntry.retain(proxy);
    } else {
      return new DirectoryEntry.retain(proxy);
    }
  }

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
 * A class to wrap js.Proxy instances that represent a dom FileEntry.
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
 * A class to wrap js.Proxy instances that represent a dom DirectoryEntry.
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

  /**
   * Return a list of child entries for this directory.
   */
  Future<List<Entry>> getEntries() {
    Completer<List<Entry>> completer = new Completer();

    List<Entry> entries = [];

    var directoryReader = (proxy as dynamic).createReader();
    js.retain(directoryReader);

    js.Callback entriesCallback = null;

    js.Callback errorCallback = new js.Callback.once((var domError) {
      entriesCallback.dispose();
      js.release(directoryReader);
      completer.completeError(domError);
    });

    entriesCallback = new js.Callback.many((/*Entry[]*/ result) {
      if (result.length == 0) {
        entriesCallback.dispose();
        js.release(directoryReader);
        completer.complete(entries);
      } else {
        entries.addAll(listify(result).map((e) => Entry.createFrom(e)));
        directoryReader.readEntries(entriesCallback, errorCallback);
      }
    });

    directoryReader.readEntries(entriesCallback, errorCallback);

    return completer.future;
  }
}

/**
 * A class to wrap js.Proxy instances that represent a dom FileSystem.
 *
 * see: http://www.w3.org/TR/file-system-api/
 */
class FileSystem {
  var _proxy;

  /**
   * Create and return a new FileSystem given a js.Proxy to a dom
   * FileSystem. js.retain is automatically called on the proxy. It is the
   * caller's responsibility to call FileSystem.release().
   */
  static FileSystem createFrom(js.Proxy proxy) {
    return new FileSystem.retain(proxy);
  }

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
