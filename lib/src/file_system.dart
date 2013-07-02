library chrome.file_system;

import 'dart:async';

import 'package:js/js.dart' as js;
import 'package:logging/logging.dart';

import 'common.dart';

final ChromeFileSystem fileSystem  = new ChromeFileSystem();

// chrome.fileSystem

// Examples here:
//   http://developer.chrome.com/apps/app_storage.html
//   http://www.html5rocks.com/en/tutorials/file/filesystem/

// chrome.fileSystem docs here:
//   http://developer.chrome.com/dev/apps/fileSystem.html

// FileEntry interface definition:
//   http://www.w3.org/TR/file-system-api/#the-fileentry-interface
//   http://dev.w3.org/2006/webapi/FileAPI/

//interface File : Blob {
//  readonly attribute DOMString name;
//  readonly attribute Date lastModifiedDate;
//};

//interface FileEntry : Entry {
//    void createWriter (FileWriterCallback successCallback, optional ErrorCallback errorCallback);
//    void file (FileCallback successCallback, optional ErrorCallback errorCallback);
//};

//interface FileCallback {
//    void handleEvent (File file);
//};

//interface FileWriterCallback {
//    void handleEvent (FileWriter fileWriter);
//};

//interface ErrorCallback {
//    void handleEvent (DOMError err);
//};

class ChromeFileSystem {

  Future<ChromeFileEntry> chooseOpenFile() {
    Completer completer = new Completer();

    js.scoped(() {
      js.Callback callback = new js.Callback.once((var fileEntry) {
        if (fileEntry != null) {
          completer.complete(new ChromeFileEntry(fileEntry));
        } else {
          completer.complete(null);
        }
      });

      chromeProxy.fileSystem.chooseEntry(js.map({'type': 'openFile'}), callback);
    });

    return completer.future;
  }

  Future<ChromeFileEntry> chooseSaveFile() {
    Completer completer = new Completer();

    js.scoped(() {
      js.Callback callback = new js.Callback.once((var fileEntry) {
        if (fileEntry != null) {
          completer.complete(new ChromeFileEntry(fileEntry));
        } else {
          completer.complete(null);
        }
      });

      chromeProxy.fileSystem.chooseEntry(js.map({'type': 'saveFile'}), callback);
    });

    return completer.future;
  }

  /**
   * Get the display path of a FileEntry object. The display path is based on
   * the full path of the file on the local file system, but may be made more
   * readable for display purposes.
   */
  Future<String> getDisplayPath(ChromeFileEntry fileEntry) {
    return js.scoped(() {
      Completer completer = new Completer();

      js.Callback callback = new js.Callback.once((var path) {
        completer.complete(path);
      });

      chromeProxy.fileSystem.getDisplayPath(fileEntry._proxy, callback);

      return completer.future;
    });
  }

  /**
   * Gets whether this FileEntry is writable or not.
   */
  Future<bool> isWritableEntry(ChromeFileEntry fileEntry) {
    return js.scoped(() {
      Completer completer = new Completer();

      js.Callback callback = new js.Callback.once((var writeable) {
        completer.complete(writeable);
      });

      chromeProxy.fileSystem.isWritableEntry(fileEntry._proxy, callback);

      return completer.future;
    });
  }

  /**
   * Returns the file entry with the given id.
   */
  ChromeFileEntry getEntryById(String id) {
    return js.scoped(() {
      return new ChromeFileEntry(chromeProxy.fileSystem.getEntryById(id));
    });
  }

  /**
   * Returns the id of the given file entry. This can be used to retrieve file
   * entries with getEntryById(). When an app is restarted (ie: it is sent the
   * onRestarted event) it can regain access to the file entries it had by
   * remembering their ids and calling getEntryById().
   */
  String getEntryId(ChromeFileEntry fileEntry) {
    return js.scoped(() {
      return chromeProxy.fileSystem.getEntryId(fileEntry._proxy);
    });
  }
}

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

//file id = 338AA34D90FC449DABB1249355C96C7F:solar.html undefined:1
//file name = solar.html undefined:1
//file fullPath = /solar.html undefined:1
//file toURL = undefined:1
//display path = ~/Google Drive/scratch/solar/web/solar.html

class ChromeFileEntry {
  js.Proxy _proxy;

  String _name;
  String _fullPath;
  bool _isFile;
  bool _isDirectory;

  ChromeFileEntry(js.Proxy proxy) {
    this._proxy = proxy;

    js.retain(_proxy);

    _name = _proxy.name;
    _fullPath = _proxy.fullPath;
    _isFile = _proxy.isFile;
    _isDirectory = _proxy.isDirectory;
  }

  String get name => _name;

  String toString() => name;

  String get fullPath => _fullPath;

  String get id => fileSystem.getEntryId(this);

  String toURL() {
    return js.scoped(() {
      return _proxy.toURL();
    });
  }

  // TODO: this seems to crash Dartium consistently -
  Future<ChromeFileEntry> getParent() {
    return js.scoped(() {
      Completer completer = new Completer();

      _proxy.getParent(
          new js.Callback.once((var e) {
            completer.complete(new ChromeFileEntry(e));
          }),
          new js.Callback.once((var e) {
            completer.completeError(e);
          })
      );

      return completer.future;
    });
  }

  Future<String> readContents() {
//    readOnlyEntry.file(function(file) {
//      var reader = new FileReader();
//
//      reader.onerror = errorHandler;
//      reader.onloadend = function(e) {
//        console.log(e.target.result);
//      };
//
//      reader.readAsText(file);
//    });

    Completer completer = new Completer();

    js.scoped(() {
      js.Callback contentsCallback = new js.Callback.once((var e) {
        // TODO:
        completer.complete(e.target.result);
      });

      js.Callback callback = new js.Callback.once((var file) {
        var reader = new js.Proxy(js.context.FileReader);
        (reader as dynamic).onloadend = contentsCallback;
        (reader as dynamic).readAsText(file);
      });

      _proxy.file(callback);
    });

    return completer.future;
  }

  Future<ChromeFileEntry> writeContents(String contents) {
//  chrome.fileSystem.getWritableEntry(chosenFileEntry, function(writableEntry)

//  writableFileEntry.createWriter(function(writer) {
//    writer.onerror = errorHandler;
//    writer.onwriteend = function(e) {
//      console.log('write complete');
//    };
//    writer.write(new Blob(['1234567890'], {type: 'text/plain'}));
//  }, errorHandler);

    Completer completer = new Completer();

    js.scoped(() {
      js.Callback writeEndCallback = new js.Callback.once((var event) {
        if (!completer.isCompleted) {
          completer.complete(this);
        }
      });

      js.Callback errorCallback = new js.Callback.once((var event) {
        completer.completeError(event);
      });

      js.Callback writerCallback = new js.Callback.once((var writer) {
        // blob = new Blob([contents])
        var blob = new js.Proxy(js.context.Blob, js.array([contents]));

        writer.onwriteend = writeEndCallback;
        writer.onerror = errorCallback;
        writer.write(blob, js.map({'type': 'text/plain'}));
      });

      js.Callback writeableCallback = new js.Callback.once((var writeableEntry) {
        writeableEntry.createWriter(writerCallback, errorCallback);
      });

      chromeProxy.fileSystem.getWritableEntry(_proxy, writeableCallback);
    });

    return completer.future;
  }

  void dispose() {
    js.release(_proxy);
  }
}
