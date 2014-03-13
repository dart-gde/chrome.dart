library mock_filesystem;

import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:path/path.dart' as pathos;

import 'filesystem.dart';
export 'filesystem.dart';

// TODO(gram): complete the missing APIs, add Windows support, and
// make this a standalone package or part of unitest/mock. It seems like
// a useful library.
//
// TODO(gram): this could be optimized at some point so that
// calls to getFile/getLink/getDirectory return a canonical
// object if possible (i.e. if the object exists in the tree
// with that path and type, return the one from the tree rather
// than a new instance).
// We could set a flag on whether an object is canonical.
// We could then speed up many calls like existsSync etc if
// the call is on the canonical instance.
// Another option is to make a distinction between real file system
// objects and File/Link/Directory, which may reference these real
// objects. This could eliminate some of the weirdness we have here
// where an object is often just a proxy for some other object (where
// the latter is the one actually in the tree) - i.e. all the calls
// to getEntity in the methods to get the 'real' canonical entity.

abstract class MockFileSystemEntity implements FileSystemEntity {
  Directory parent;
  FileSystemEntityType type;
  final String path;

  static FileSystemEntityType typeSync(String path, {bool followLinks: true}) {
    var entity = (fileSystem as MockFileSystem)
        .getEntity(path, followLinks: followLinks);
    if (entity != null) {
      return entity.type;
    }
    return FileSystemEntityType.NOT_FOUND;
  }

  MockFileSystemEntity(this.path, this.type);

  bool existsSync() {
    // dart:io documentation is ambiguous here as to whether links
    // should be followed. For File they say that links are followed
    // except for delete/deleteSync, but for File.delete they imply
    // that links are not followed.
    var entity = (fileSystem as MockFileSystem)
        .getEntity(path, followLinks: false);
    return (entity is FileSystemEntity && entity.type == type);
  }

  Future<bool> exists() => new Future.value(existsSync());
}

class MockFile extends MockFileSystemEntity implements File {
  final MockDirectory directory;
  String _contents;
  DateTime _lastModified;

  MockFile(String filepath) :
    super(filepath, FileSystemEntityType.FILE),
    directory = fileSystem.getDirectory(pathos.dirname(absolutePath(filepath)));

  void createSync() {
    (fileSystem as MockFileSystem).setEntity(path, this);
  }

  Future<File> create() {
    createSync();
    return new Future.value(this);
  }

  void deleteSync() {
    _contents = null;
    var myType = MockFileSystemEntity.typeSync(path, followLinks: false);
    if (myType == FileSystemEntityType.LINK) {
      var targetType = MockFileSystemEntity.typeSync(path);
      if (targetType != FileSystemEntityType.FILE) {
        throw new FileException("Cannot delete $path; link target not a file");
      }
    } else if (myType != FileSystemEntityType.FILE) {
      throw new FileException("Cannot delete $path; not a file");
    }
    (fileSystem as MockFileSystem).removeEntity(path);
  }

  Future<File> delete() {
    deleteSync();
    return new Future.value(this);
  }

  String fullPathSync() => (fileSystem as MockFileSystem).targetPath(path);

  Future<String> fullPath() => new Future.value(fullPathSync());

  DateTime lastModifiedSync() {
    var entity = (fileSystem as MockFileSystem)
        .getEntity(path, followLinks: true);
    if (entity is FileSystemEntity &&
        entity.type == FileSystemEntityType.FILE) {
      return (entity as MockFile)._lastModified;
    }
    throw new FileException("Cannot get last modified time of $path");
  }

  Future<DateTime> lastModified() => new Future.value(lastModifiedSync());

  String readAsStringSync({encoding}) {
    var entity = (fileSystem as MockFileSystem)
        .getEntity(path, followLinks: true);
    if (entity is FileSystemEntity &&
        entity.type == FileSystemEntityType.FILE) {
      var file = (entity as MockFile);
      if (file._contents != null) {
        return file._contents;
      }
    }
    throw new FileException("Cannot read $path");
  }

  Future<String> readAsString({encoding}) =>
      new Future.value(readAsStringSync());

  void writeAsStringSync(String value, {mode, encoding}) {
    var file;
    var entity = (fileSystem as MockFileSystem)
        .getEntity(path, followLinks: true);
    if (entity is FileSystemEntity) {
      if (entity.type == FileSystemEntityType.FILE) {
        file = (entity as MockFile);
      } else {
        throw new FileException("Cannot write $path: not a file");
      }
    } else {
      (fileSystem as MockFileSystem).setEntity(path, file = this);
    }
    file._contents = value;
    file._lastModified = new DateTime.now();
  }

  Future<File> writeAsString(String value, {mode, encoding}) {
    writeAsStringSync(value);
    return new Future.value(this);
  }

  dynamic noSuchMethod(Invocation invocation) {
    throw 'Not implemented: ${invocation.memberName}';
  }
}

class MockLink extends MockFileSystemEntity implements Link {
  String _target;

  MockLink(String path) :
    super(path, FileSystemEntityType.LINK);

  MockLink _getCanonicalLink() {
    var entity = (fileSystem as MockFileSystem)
        .getEntity(path, followLinks: false);
    if (entity is FileSystemEntity &&
        entity.type == FileSystemEntityType.LINK) {
      return (entity as MockLink);
    }
    return null;
  }

  void deleteSync() {
    var entity = _getCanonicalLink();
    if (entity != null) {
      (fileSystem as MockFileSystem).removeEntity(path);
    } else {
      throw new LinkException("Cannot delete link $path");
    }
  }

  Future<Link> delete() {
    deleteSync();
    return new Future.value(this);
  }

  void createSync(String target) {
    _target = target;
    (fileSystem as MockFileSystem).setEntity(path, this);
  }

  Future<Link> create(String target) => new Future.value(createSync(target));

  String targetSync() {
    var entity = _getCanonicalLink();
    if (entity != null && entity._target != null) {
      return entity._target;
    }
    throw new LinkException("Cannot get target of link $path");
  }

  Future<String> target() => new Future.value(target());

  void updateSync(String target, {bool linkRelative: false}) {
    // What should we do with the second argument? It isn't clear.
    // See issue https://code.google.com/p/dart/issues/detail?id=12003
    var entity = _getCanonicalLink();
    if (entity != null) {
      entity._target = target;
    } else {
      throw new LinkException("Cannot update link $path: nonexistent.");
    }
  }

  dynamic noSuchMethod(Invocation invocation) {
    throw 'Not implemented: ${invocation.memberName}';
  }
}

class MockDirectory extends MockFileSystemEntity implements Directory {
  static String _currentDir = Directory.current.path;
  static int _tempNum = 0;
  Map<String, FileSystemEntity> _children = {};

  static Directory get current => new MockDirectory(_currentDir);

  static set current(value) {
    if (value is Directory) {
      _currentDir = absolutePath(value.path);
    } else if (value is String) {
      _currentDir = value;
    }
  }

  MockDirectory._internal(String dirpath) :
    super(dirpath, FileSystemEntityType.DIRECTORY);

  factory MockDirectory(String dirPath) {
    return new MockDirectory._internal(dirPath);
  }

  factory MockDirectory.fromPath(Path dirPath) {
    return new MockDirectory._internal(dirPath.toString());
  }

  void createSync({recursive: false}) {
    (fileSystem as MockFileSystem).setEntity(path, this, recursive: recursive);
  }

  Future<Directory> create({recursive: false}) {
    createSync(recursive: recursive);
    return new Future.value(this);
  }

  Directory createTempSync() {
    var dir = path.length == 0 ? '/tmp' : path;
    return new MockDirectory(joinPaths(dir, 'temp${_tempNum++}'));
  }

  Future<Directory> createTemp() => new Future.value(createTempSync());

  void deleteSync({recursive: false}) {
    var entity = (fileSystem as MockFileSystem)
        .getEntity(path, followLinks: false);
    if (entity is! FileSystemEntity) return;
    if (entity.type != FileSystemEntityType.DIRECTORY) {
      if (!recursive) {
        throw new DirectoryException("Can't remove $path; not a directory");
      }
    } else {
      // This is a directory.
      var dir = entity as MockDirectory;
      if (!recursive && dir._children.length > 0) {
        throw new DirectoryException("Can't remove non-empty directory $path");
      }
    }
    (fileSystem as MockFileSystem).removeEntity(path);
  }

  Future<Directory> delete({recursive: false}) {
    deleteSync(recursive: recursive);
    return new Future.value(this);
  }

  String toString() => path;
}

class MockFileSystem implements FileSystem {

  // TODO(gram): Handle Windows drive specs with multiple roots.
  var _root = new MockDirectory('');

  String get currentDirectory => MockDirectory.current.path;

  set currentDirectory(String dir) => MockDirectory.current = dir;

  static var _timeGranularity = new Duration(milliseconds: 1);

  Duration get timeGranularity => _timeGranularity;

  File getFile(String path) => new MockFile(path);

  Link getLink(String path) => new MockLink(path);

  Directory getDirectory(String path) => new MockDirectory(path);

  dynamic _getDirectory(List<String> segments, int length, bool addMissing) {
    var dir = _root;
    var temppath = '';
    // Pathos puts root as first segment so we start at 1.
    for (var i = 1; i < length; i++) {
      // TODO(gram): handle case-insensitivity in Windows.
      var segment = segments[i];
      bool hasSegment = dir._children.containsKey(segment);
      temppath = '${temppath}${pathos.separator}${segment}';
      if (hasSegment) {
        var entity = dir._children[segment];
        if (entity is! Directory) {
          return "non-directory $segment in path";
        }
        dir = entity as Directory;
      } else if (addMissing) {
        var newdir = new MockDirectory(temppath);
        dir._children[segment] = newdir;
        dir = newdir;
      } else {
        return "missing directory $segment in path";
      }
    }
    return dir;
  }

  dynamic getEntity(String entityPath, {bool followLinks: false}) {
    if (followLinks) entityPath = targetPath(entityPath);
    else entityPath = absolutePath(entityPath);
    if (entityPath == null) return null;
    var segments = pathos.split(entityPath);
    if (segments.length == 0) {
      return _root;
    }
    var segment = _getDirectory(segments, segments.length - 1, false);
    if (segment is String) {
      return "Cannot get $entityPath; $segment";
    }
    var dir = segment as MockDirectory;
    var lastSegment = segments[segments.length -1];
    if (dir._children.containsKey(lastSegment)) {
      return dir._children[lastSegment];
    }
    return null;
  }

  void setEntity(String entityPath, FileSystemEntity entity,
                 {bool recursive: false}) {
    entityPath = absolutePath(entityPath);
    if (entityPath == null) return;
    var segments = pathos.split(entityPath);
    if (segments.length == 0) {
      throw new FileException("Root directory already exists");
    }
    var segment = _getDirectory(segments, segments.length - 1, recursive);
    if (segment is String) {
      throw new FileException("Cannot create $entityPath; $segment");
    }
    var dir = segment as MockDirectory;
    var lastSegment = segments[segments.length -1];
    if (dir._children.containsKey(lastSegment)) {
      throw new FileException("Cannot create $entityPath; already exists");
    }
    dir._children[lastSegment] = entity;
  }

  void removeEntity(String entityPath) {
    entityPath = absolutePath(entityPath);
    if (entityPath == null) return;
    var segments = pathos.split(entityPath);
    if (segments.length == 0) {
      throw new FileException("Cannot delete root directory");
    }
    var segment = _getDirectory(segments, segments.length - 1, false);
    if (segment is String) {
      throw new FileException("Cannot delete $entityPath; $segment");
    }
    var dir = segment as MockDirectory;
    var lastSegment = segments[segments.length -1];
    if (!dir._children.containsKey(lastSegment)) {
      throw new FileException("Cannot delete $entityPath; doesn't exist");
    }
    dir._children.remove(lastSegment);
  }

  String targetPath(String path) {
    do {
      path = absolutePath(path);
      var e = getEntity(path);
      if (e is! FileSystemEntity) break;
      if (e.type != FileSystemEntityType.LINK) return path;
      path = (e as MockLink)._target;
    } while (path != null);
    return null;
  }

  Link symlink(String linkName, String target) {
    linkName = absolutePath(linkName);
    var link = getLink(linkName);
    link.createSync(target);
    return link;
  }
}
