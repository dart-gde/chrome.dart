library filesystem;

import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:logging/logging.dart';

final Logger _logger = new Logger('filesystem');

class FileSystem {
  const FileSystem();

  File getFile(String path) => new File(path);
  Link getLink(String path) => new Link(path);
  Directory getDirectory(String path) => new Directory(path);

  FileSystemEntity symlink(String where, String target) {
    _logger.fine("linking $where -> $target");
    try {
      if (FileSystemEntity.isDirectorySync(where)) {
        _logger.fine("${where} already exists and is a directory; removing");
        new Directory(where).deleteSync(recursive: true);
      } else if (FileSystemEntity.isFileSync(where)) {
        _logger.fine("${where} already exists and is a file; removing");
        new File(where).deleteSync();
      } else if (FileSystemEntity.isLinkSync(where)) {
        var existingLink = new Link(where);
        if (existingLink.targetSync() == target) {
          // the symlink already exists to the same file, reuse it.
          _logger.fine("Reusing existing link");
          return existingLink;
        }
        _logger.fine("Existing link for $target points "
            "elsewhere (${existingLink.targetSync()}); removing");
        existingLink.deleteSync();
      } else {
        // Make sure the link directory exists.
        var dir = new Directory(path.dirname(where));
        if (!dir.existsSync()) {
          _logger.fine("Creating directory ${dir.path}");
          dir.createRecursivelySync();
        }
      }
      return new Link(where)..createSync(target);
    } catch (e, trace) {
      // TODO(gram): When logger supports an exception argument,
      // change this.
      _logger.warning("Couldn't create symlink to: ${target}");
      _logger.fine("Exception details: $e $trace");
      return null;
    }
  }

  String get currentDirectory => Directory.current.path;
  set currentDirectory(String dir) => Directory.current = dir;

  static var _timeGranularity = new Duration(seconds:1);
  Duration get timeGranularity => _timeGranularity;
}

FileSystem fileSystem = const FileSystem();

// We use this instead of path.absolute so we can use
// fileSystem.currentDirectory and thus MockFileSystem.
String absolutePath(String filePath) {
  if (filePath == null) return null;
  return path.join(fileSystem.currentDirectory, filePath);
}

// Useful utility for joining paths into an absolute path.
String joinPaths(String path1, String path2) {
  if (path.isAbsolute(path2)) {
    path2 = path2.substring(path.rootPrefix(path2).length);
  }
  return path.join(absolutePath(path1), path2);
}

