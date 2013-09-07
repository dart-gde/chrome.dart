# Changelog - chrome.dart

## 0.3.1-dev

## 0.3.0 Sept 2013 (SDK 0.6.21.3_r26639)

- Refactoring of fileSystem library and wrapping of FileEntry
- Moved drone.io execution to local build script
- Added chrome.syncFileSystem api
- Removed old dependencies
- Added chrome.debugger extension api
- bot_io moved to dev_dependency

## 0.2.0

- Support for Chrome extension APIs was added.  You should now import one of the
following libraries, as appropriate:
	- Packaged apps: `import 'package:chrome/app.dart';`
	- Extensions: `import 'package:chrome/ext.dart';`
- Work on the `chrome.app.window` API including several breaking changes, please
refer to the dartdoc for usage.
- Added identity support and example

## 0.0.1 20 May 2013 (SDK 0.5.9.0 r22879)

## 0.0.0-dev 17 Dec 2012 (SDK 0.2.9.6 r16207)
