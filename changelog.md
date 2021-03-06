# Changelog - chrome.dart

## 0.10.1 2018-05-02
- fix missing classes on generated `app.dart` file.

## 0.10.0 2018-04-30
- updated to be compatible with Chrome 66 IDL's
  - Ignoring `app.runtime.ActionType` in AppWindow API

## 0.9.4 2018-04-06
- updated to be compatible with Chrome 63 IDL's.

## 0.9.34 2018-03-09
- fixes issues with firefox and optional args

## 0.9.32 2017-08-23
- fix to transformers for strong mode

## 0.9.32 2017-08-21
- fixes package structure to enable ddc

## 0.9.31 2017-03-30
- bug fixes for the ContextMenu and Runtime libraries

## 0.9.3 2017-03-27
- updated to M57, with no new APIs

## 0.9.2 2016-09-22
- updated to M53, with no new APIs

## 0.9.1 2016-07-01
- updated to M51, adding the following APIs
  - certificateProvider
  - enterprise.deviceAttributes
  - enterprise.platformKeys

## 0.8.0-dev1 2015-09-15
- updated to M44, adding the following APIs
  - documentScan
  - fileSystemProvider
  - printerProvider
  - vpnProvider
  - networking.config
  - wallpaper

## 0.7.0-dev1 2015-04-25
- updated the APIs to M41
- removed scriptBadge api that was dropped in M41
- removed pusheMessaging api that was dropped in M41 (use gcm instead)

## 0.6.5 2014-11-06
- fixed an issue with Port.onMessage() and Port.sendMessage()

## 0.6.4 2014-10-19
- fixed an issue with double loading compiled JavaScript files

## 0.6.3 2014-08-29 (SDK 1.6.0-dev.9.7 r39537)
- removed dependency loop in `files_exp.dart` and `files.dart`

## 0.6.2 2014-08-29 (SDK 1.6.0)
- moved a script from `bin` to `tool` in order to avoid exposing in in the `bin` directory

## 0.6.1 2014-08-28 (SDK 1.6.0)

- updated the APIs to M37
- changed the bootstrap script and the chrome transformer to expect the csp file in foo.dart.js instead of foo.dart.precompiled.js
- clients must now include the csp parameter to the dart2js transformer:
    transformers:
      chrome
      $dart2js:
        csp: true

## 0.6.0 2014-07-01 (SDK 1.5.1 r37644)

- Updated the APIs to M35 (current Chrome stable)
- Added the `chrome.bluetoothLowEnergy` API
- Added the `chrome.bluetoothSocket` API
- Added the `chrome.commands` API
- Added the `chrome.hid` API

## 0.5.6 2014-04-29 (SDK 1.4.0-dev.4.0 r35362)

- Added speculative performance fix for array performance issue

## 0.5.5 2014-04-14 (SDK 1.3.0-dev.4.1 r33731)

- Make the pub transformer work with the old and new version of barback

## 0.5.4 2014-03-19 (SDK 1.3.0-dev.4.1 r33731)

- Update to latest serial.idl
- Included overrides for new serial namespace
- Updated serial unit tests

## 0.5.3 2014-02-15 (SDK 1.3.0-dev.3.2 r33495)

- Fixed an issue with event listeners and Chrome M35+

## 0.5.2 2014-02-14 (SDK 1.3.0-dev.3.2 r33495)

- Updated to use docgen for api documentation 
- Make the window close event sync instead of async
- Clean up warnings in unit tests
- Add app/ to drone_io.sh script
- Add a chrome pub transformer  
- Fix an issue w/ the hand-overridden API
- Use a getter to fetch the JsObject for an API each time it is needed

## 0.5.1 2014-02-24 (SDK 1.2.0-dev.5.15 r32954)

- Added a `toString()` to the `FileError` implementation
- Added ability to override generated code with hand-written methods
- Implemented window events override for `ChromeAppWindow` class

## 0.5.0 2014-02-20 (SDK 1.2.0-dev.5.12 r32844)

- Added the new `chrome.sockets` API
- The existing `chrome.socket` API has been removed from the chrome_app.dart
  library. In order to continue using it, you can reference it directly
  (`import 'package:chrome/gen/socket.dart';`)
- Added `chrome.gcm`; exposes Google Cloud Messaging
- Added `chrome.signedInDevices`
- Added `chrome.wallpaper`
- Added `chrome.system.display`
- Added `chrome.system.network`

## 0.4.3 2014-01-21 (SDK 1.2.0-dev.1.0 r31918)

- Fixed bug with `entry.metaData.timeStamp`

## 0.4.2 2014-01-18 (SDK 1.1.0-dev.5.11 r31818)

- Fix performance issues with converting array buffers to lists

## 0.4.1 2014-01-16 (SDK 1.1.0-dev.5.11 r31818)

- Unscripted updated to `>=0.3.0 <0.4.0`
- USB bug found and fixed with naming of `_interface` in the chrome idl.

## 0.4.0 2014-01-13 (SDK 1.1.0-dev.5.6 r31661)

- Merge from [chrome_gen.dart](https://github.com/dart-gde/chrome_gen.dart) completed
- All apis are generated from IDL files
- All unit tests have been updated to work against generated apis
- Api docs are autogenerated
- drone.io script now runs the tool unit tests

## 0.3.1 2013-09-17 (SDK 0.7.3.1 r27487)

- Auto doc generation and deployment to drone.io [API documentation]
(http://dart-gde.github.com/chrome.dart).
- Implemented DirectoryEntry.getEntries()
- Documentation updates, removal of javadoc'isms
- Refactored unit tests so each test module has a single main() entry point.

## 0.3.0 2013-09-04 (SDK 0.6.21.3 r26639)

- Refactoring of fileSystem library and wrapping of FileEntry
- Moved drone.io execution to local build script
- Added chrome.syncFileSystem api
- Removed old dependencies
- Added chrome.debugger extension api
- bot_io moved to dev_dependency

## 0.2.0 2013-08-08

- Support for Chrome extension APIs was added.  You should now import one of the
following libraries, as appropriate:
	- Packaged apps: `import 'package:chrome/app.dart';`
	- Extensions: `import 'package:chrome/ext.dart';`
- Work on the `chrome.app.window` API including several breaking changes, please
refer to the dartdoc for usage.
- Added identity support and example

## 0.0.1 2013-05-20 (SDK 0.5.9.0 r22879)

## 0.0.0-dev 2012-12-17 (SDK 0.2.9.6 r16207)
