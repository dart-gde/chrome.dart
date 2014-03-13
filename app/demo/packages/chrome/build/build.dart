
/**
 * A library to de-sym link packages directories, and make real copies of the
 * `packages` references.
 */
library chrome.build;

import 'dart:io';

export 'dart:io' show Directory;

/**
 * This method copies the `<cwd>/packages` directory to [destDir]`/packages`. It
 * optionally removes all `packages` symlinks found in subdirectories of
 * [destDir].
 *
 * This function is useful for Chrome Apps, which can't load their content from
 * symlinks.
 */
void copyPackages(Directory destDir, {bool removeSymlinks: true}) {
  _removePackagesSymlinks(destDir, recursive: removeSymlinks);
  _copyDirectory(new Directory('packages'), _joinDirectory(destDir, 'packages'));
}

void _removePackagesSymlinks(Directory dir, {bool recursive: false}) {
  if (FileSystemEntity.isLinkSync(_join(dir, 'packages'))) {
    _joinDirectory(dir, 'packages').deleteSync();
  }

  if (recursive) {
    for (FileSystemEntity entity in dir.listSync(followLinks: false)) {
      if (FileSystemEntity is Directory) {
        _removePackagesSymlinks(entity, recursive: true);
      }
    }
  }
}

void _copyDirectory(Directory srcDir, Directory destDir) {
  for (FileSystemEntity entity in srcDir.listSync()) {
    if (entity is File) {
      _copyFile(entity, destDir);
    } else {
      _copyDirectory(entity, _joinDirectory(destDir, _name(entity)));
    }
  }
}

void _copyFile(File srcFile, Directory destDir) {
  File destFile = _joinFile(destDir, _name(srcFile));

  if (!destFile.existsSync() ||
      srcFile.lastModifiedSync().isAfter(destFile.lastModifiedSync())) {
    if (!destFile.parent.existsSync()) {
      destFile.parent.createSync(recursive: true);
    }

    destFile.writeAsBytesSync(srcFile.readAsBytesSync());
  }
}

String _name(FileSystemEntity entity) =>
    new Uri.file(entity.path).pathSegments.last;

String _join(FileSystemEntity entity, String child) =>
    "${entity.path}${Platform.pathSeparator}${child}";

File _joinFile(Directory dir, String name) =>
    new File('${dir.path}${Platform.pathSeparator}${name}');

Directory _joinDirectory(Directory dir, String name) =>
    new Directory('${dir.path}${Platform.pathSeparator}${name}');
