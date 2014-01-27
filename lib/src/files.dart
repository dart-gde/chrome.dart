
library chrome.src.files;

import 'dart:async';
import 'dart:js';
//import 'dart:html' show EventStreamProvider;

import 'common.dart';

import '../src/files_exp.dart';
export '../src/files_exp.dart';

class CrFileSystem extends ChromeObject implements FileSystem {
  static Map _fileSystems = {};

  /**
   * Use a factory to ensure that the same JavsScript file systems are the same
   * Dart objects.
   */
  factory CrFileSystem.fromProxy(JsObject jsProxy) {
    if (!_fileSystems.containsKey(jsProxy)) {
      _fileSystems[jsProxy] = new CrFileSystem._(jsProxy);
    }

    return _fileSystems[jsProxy];
  }

  CrFileSystem._(JsObject jsProxy): super.fromProxy(jsProxy);

  String get name => jsProxy['name'];

  DirectoryEntry get root => new CrDirectoryEntry.fromProxy(jsProxy['root']);

  bool operator==(Object other) =>
      other is CrFileSystem && other.jsProxy == jsProxy;

  int get hashCode => jsProxy.hashCode;
  String toString() => name;
}

class CrMetadata extends ChromeObject implements Metadata {
  CrMetadata.fromProxy(JsObject jsProxy) : super.fromProxy(jsProxy);

  int get size => jsProxy['size'];
  DateTime get modificationTime {
    var modTime = jsProxy['modificationTime'];
    if (modTime is DateTime) return modTime;
    return new DateTime.fromMillisecondsSinceEpoch(
        new JsObject.fromBrowserObject(modTime).callMethod('getTime'));
  }
}

abstract class CrEntry extends ChromeObject implements Entry {
  // This factory returns either a FileEntry or a DirectoryEntry.
  factory CrEntry.fromProxy(JsObject jsProxy) {
    if (jsProxy == null) {
      return null;
    } else if (jsProxy['isFile']) {
      return new ChromeFileEntry.fromProxy(jsProxy);
    } else {
      return new CrDirectoryEntry.fromProxy(jsProxy);
    }
  }

  CrEntry._fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  bool get isDirectory => jsProxy['isDirectory'];
  bool get isFile => jsProxy['isFile'];
  String get fullPath => jsProxy['fullPath'];
  String get name => jsProxy['name'];
  FileSystem get filesystem => new CrFileSystem.fromProxy(jsProxy['filesystem']);

  String toUrl() => this.jsProxy.callMethod('toURL');

  Future<Entry> copyTo(DirectoryEntry parent, {String name}) {
    var completer = new _ChromeCompleterWithError<Entry>.oneArg((obj) => new CrEntry.fromProxy(obj));
    jsProxy.callMethod('copyTo', [(parent as ChromeObject).jsProxy, name, completer.callback, completer.errorCallback]);
    return completer.future;
  }

  Future<Entry> moveTo(DirectoryEntry parent, {String name}) {
    var completer = new _ChromeCompleterWithError<Entry>.oneArg((obj) => new CrEntry.fromProxy(obj));
    jsProxy.callMethod('moveTo', [(parent as ChromeObject).jsProxy, name, completer.callback, completer.errorCallback]);
    return completer.future;
  }

  Future remove() {
    var completer = new _ChromeCompleterWithError.noArgs();
    jsProxy.callMethod('remove', [completer.callback, completer.errorCallback]);
    return completer.future;
  }

  Future<Metadata> getMetadata() {
    var completer = new _ChromeCompleterWithError<Metadata>.oneArg(
        (obj) => (obj is Metadata ? obj : new CrMetadata.fromProxy(obj)));
    jsProxy.callMethod('getMetadata', [completer.callback, completer.errorCallback]);
    return completer.future;
  }

  Future<Entry> getParent() {
    var completer = new _ChromeCompleterWithError<Entry>.oneArg((obj) => new CrDirectoryEntry.fromProxy(obj));
    jsProxy.callMethod('getParent', [completer.callback, completer.errorCallback]);
    return completer.future;
  }

  String toString() => name;
}

class CrDirectoryEntry extends CrEntry implements DirectoryEntry {
  CrDirectoryEntry.fromProxy(JsObject jsProxy) : super._fromProxy(jsProxy);

  Future<Entry> createFile(String path, {bool exclusive: false}) {
    var options = new JsObject.jsify({'create': true, 'exclusive': exclusive});
    var completer = new _ChromeCompleterWithError<Entry>.oneArg((obj) => new CrEntry.fromProxy(obj));
    jsProxy.callMethod('getFile', [path, options, completer.callback, completer.errorCallback]);
    return completer.future;
  }

  Future<Entry> createDirectory(String path, {bool exclusive: false}) {
    var options = new JsObject.jsify({'create': true, 'exclusive': exclusive});
    var completer = new _ChromeCompleterWithError<Entry>.oneArg((obj) => new CrEntry.fromProxy(obj));
    jsProxy.callMethod('getDirectory', [path, options, completer.callback, completer.errorCallback]);
    return completer.future;
  }

  Future<Entry> getFile(String path) {
    var options = new JsObject.jsify({'create': false});
    var completer = new _ChromeCompleterWithError<Entry>.oneArg((obj) => new CrEntry.fromProxy(obj));
    jsProxy.callMethod('getFile', [path, options, completer.callback, completer.errorCallback]);
    return completer.future;
  }

  Future<Entry> getDirectory(String path) {
    var options = new JsObject.jsify({'create': false});
    var completer = new _ChromeCompleterWithError<Entry>.oneArg((obj) => new CrEntry.fromProxy(obj));
    jsProxy.callMethod('getDirectory', [path, options, completer.callback, completer.errorCallback]);
    return completer.future;
  }

  DirectoryReader createReader() {
    return new CrDirectoryReader.fromProxy(jsProxy.callMethod('createReader'));
  }

  Future removeRecursively() {
    var completer = new _ChromeCompleterWithError.noArgs();
    jsProxy.callMethod('removeRecursively', [completer.callback, completer.errorCallback]);
    return completer.future;
  }

  bool operator==(Object other) =>
      other is CrDirectoryEntry && other.jsProxy == jsProxy;

  int get hashCode => jsProxy.hashCode;
  String toString() => '${name}/';
}

class CrDirectoryReader extends ChromeObject implements DirectoryReader {
  CrDirectoryReader.fromProxy(JsObject jsProxy) : super.fromProxy(jsProxy);

  /**
   * Return a list of child entries for this directory.
   */
  Future<List<Entry>> readEntries() {
    Completer<List<Entry>> completer = new Completer();

    List<Entry> entries = [];

    Function entriesCallback = null;
    Function errorCallback = (var domError) {
      completer.completeError(_translateError(domError));
    };

    entriesCallback = (/*Entry[]*/ result) {
      if (result['length'] == 0) {
        completer.complete(entries);
      } else {
        entries.addAll(listify(result).map((e) => new CrEntry.fromProxy(e)));
        jsProxy.callMethod('readEntries', [entriesCallback, errorCallback]);
      }
    };

    jsProxy.callMethod('readEntries', [entriesCallback, errorCallback]);

    return completer.future;
  }
}

abstract class CrFileEntry extends CrEntry implements FileEntry {
  CrFileEntry.fromProxy(JsObject jsProxy) : super._fromProxy(jsProxy);

  Future<FileWriter> createWriter() {
    // TODO:

    throw new UnimplementedError('FileEntry.createWriter');
  }

  Future<File> file() {
    var completer = new _ChromeCompleterWithError<File>.oneArg(selfConverter);
    jsProxy.callMethod('file', [completer.callback, completer.errorCallback]);
    return completer.future;
  }

  bool operator==(Object other) =>
      other is CrDirectoryEntry && other.jsProxy == jsProxy;

  int get hashCode => jsProxy.hashCode;
}

/**
 * A convience class for reading and writing file content.
 */
class ChromeFileEntry extends CrFileEntry {
  ChromeFileEntry.fromProxy(JsObject jsProxy) : super.fromProxy(jsProxy);

  /**
   * Return the contents of the file as a String.
   */
  Future<String> readText() {
    return file().then((File file) {
      Completer<String> completer = new Completer();

      var reader = new JsObject(context['FileReader']);
      reader['onload'] = (var event) {
        completer.complete(reader['result']);
      };
      reader['onerror'] = (var domError) {
        completer.completeError(_translateError(domError));
      };
      reader.callMethod('readAsText', [file]);

      return completer.future;
    });
  }

  /**
   * Return the contents of the file as a byte array.
   */
  Future<ArrayBuffer> readBytes() {
    // readAsArrayBuffer
    return file().then((File file) {
      Completer<ArrayBuffer> completer = new Completer();

      var reader = new JsObject(context['FileReader']);
      reader['onload'] = (var event) {
        completer.complete(new ArrayBuffer.fromProxy(reader['result']));
      };
      reader['onerror'] = (var domError) {
        completer.completeError(_translateError(domError));
      };
      reader.callMethod('readAsArrayBuffer', [file]);

      return completer.future;
    });
  }

  /**
   * Write out the given String to the file.
   */
  Future writeText(String text) {
    return _createWriter().then((ChromeObject _writer) {
      JsObject writer = _writer.jsProxy;

      Completer<FileEntry> completer = new Completer();

      JsObject blob = new JsObject(
          context['Blob'], [new JsObject.jsify([text])]);

      writer['onwrite'] = (var event) {
        writer['onwrite'] = null;
        writer.callMethod('truncate', [writer['position']]);
        completer.complete(this);
      };
      writer['onerror'] = (var event) {
        completer.completeError(_translateError(event));
      };
      writer.callMethod(
          'write', [blob, new JsObject.jsify({'type': 'text/plain'})]);

      return completer.future;
    });
  }

  /**
   * Write out the given ArrayBuffer to the file.
   */
  Future writeBytes(ArrayBuffer data) {
    return _createWriter().then((ChromeObject _writer) {
      JsObject writer = _writer.jsProxy;

      Completer<FileEntry> completer = new Completer();

      // TODO: work around a bug on jsify, where toString() is called on
      // data.jsProxy, inserting '1, 2, 3, 4, ...' into the blob instead of a list
      // of ints
      JsObject args = new JsObject.jsify([null]);
      args[0] = data.jsProxy;
      JsObject blob = new JsObject(context['Blob'], [args]);

      writer['onwrite'] = (var event) {
        writer['onwrite'] = null;
        writer.callMethod('truncate', [writer['position']]);
        completer.complete(this);
      };
      writer['onerror'] = (var event) {
        completer.completeError(_translateError(event));
      };
      writer.callMethod('write', [blob]);

      return completer.future;
    });
  }

  Future<ChromeObject> _createWriter() {
    var completer = new _ChromeCompleterWithError<ChromeObject>.oneArg((obj) => new ChromeObject.fromProxy(obj));
    jsProxy.callMethod('createWriter', [completer.callback, completer.errorCallback]);
    return completer.future;
  }
}

//abstract class CrBlob extends ChromeObject implements Blob {
//  CrBlob.fromProxy(/*JsObject*/ jsProxy) : super.fromProxy(jsProxy);
//
//  int get size => jsProxy['size'];
//  String get type => jsProxy['type'];
//
//  Blob slice([int start, int end, String contentType]) {
//    // TODO:
//
//    throw new UnimplementedError('Blob.slice');
//  }
//}

//class CrFile extends CrBlob implements File {
//  CrFile.fromProxy(/*JsObject*/ jsProxy) : super.fromProxy(jsProxy);
//
//  DateTime get lastModifiedDate {
//    JsObject jsDateTime = jsProxy['lastModifiedDate'];
//    return new DateTime.fromMillisecondsSinceEpoch(jsDateTime.callMethod('getTime'));
//  }
//  String get name => jsProxy['name'];
//  String get relativePath => jsProxy['relativePath'];
//
//  String toString() => name;
//}

//abstract class CrEventTarget extends ChromeObject implements EventTarget {
//  CrEventTarget.fromProxy(JsObject jsProxy) : super.fromProxy(jsProxy);
//  CrEventTarget();
//
//  // TODO: ?
//  Events get on => new Events(this);
//
//  bool dispatchEvent(Event event) { }
//
//  // won't implement
//  void $dom_addEventListener(String type, EventListener listener, [bool useCapture]) { }
//  void $dom_removeEventListener(String type, EventListener listener, [bool useCapture]) { }
//}
//
//class CrFileReader extends CrEventTarget implements FileReader {
//  static const EventStreamProvider<ProgressEvent> loadEvent = const EventStreamProvider<ProgressEvent>('load');
//  static const EventStreamProvider<Event> errorEvent = const EventStreamProvider<Event>('error');
//
//  CrFileReader.fromProxy(JsObject jsProxy) : super.fromProxy(jsProxy);
//  CrFileReader();
//
//  Stream<ProgressEvent> get onLoad => loadEvent.forTarget(this);
//  Stream<Event> get onError => errorEvent.forTarget(this);
//
//  void readAsText(Blob blob, [String encoding]) {
//    // TODO: sdkjhsdfkjh
//
//  }
//}
//
///**
// * An alias for [CrFileReader].
// */
//class ChromeFileReader extends CrFileReader {
//  ChromeFileReader.fromProxy(JsObject jsProxy) : super.fromProxy(jsProxy);
//  ChromeFileReader();
//}


// TODO: Blob, File, FileWriter, ...

/**
 * An object for handling completion callbacks that are common in the chrome.*
 * APIs.
 */
class _ChromeCompleterWithError<T> {
  final Completer<T> _completer = new Completer();
  Function _callback;

  _ChromeCompleterWithError.noArgs() {
    this._callback = () {
      _completer.complete();
    };
  }

  _ChromeCompleterWithError.oneArg([Function transformer]) {
    this._callback = ([arg1]) {
      if (transformer != null) {
        arg1 = transformer(arg1);
      }
      _completer.complete(arg1);
    };
  }

  Future<T> get future => _completer.future;

  Function get callback => _callback;

  void errorCallback(dynamic domError) {
    _completer.completeError(_translateError(domError));
  }
}

class CrFileError extends ChromeObject implements FileError {
  CrFileError.fromProxy(JsObject jsProxy) : super.fromProxy(jsProxy);

  int get code => jsProxy['code'];
  String get message => jsProxy['message'];
  String get name => jsProxy['name'];

  static bool _isFileError(error) {
    if (error is JsObject) {
      // TODO: static JsFunction errorType = context['FileError'];
      return error.toString().contains('FileError');
    } else {
      return false;
    }
  }
}

/**
 * If the given error is a Javascript FileError, convert it to a dart:html
 * FileError.
 */
dynamic _translateError(var error) {
  if (CrFileError._isFileError(error)) {
    return new CrFileError.fromProxy(error);
  } else {
    return error;
  }
}
