# chrome.dart

An library for accessing the Chrome APIs in a packaged app or extension.

[![Build Status](https://drone.io/github.com/dart-gde/chrome.dart/status.png)](https://drone.io/github.com/dart-gde/chrome.dart/latest)

## Installing

Add this to your package's pubspec.yaml file:

    dependencies:
      chrome: any

## Using the library

    import 'package:chrome/chrome_app.dart' as chrome;

    void main() {
      chrome.runtime.getPlatformInfo().then((Map m) {
        print(m.toString());
      });
    }

Also, see the [FAQ](https://github.com/dart-gde/chrome.dart/wiki/FAQ).

## In your pubspec.yaml

In order to build your app with `pub build`, you'll need to tell it to select
the CSP compliant output of dart2js. To do that, add these lines:

    transformers:
    - chrome

to your `pubspec.yaml` file.

## Documentation
Documentation is available at:

* [Chrome Apps
  API](http://dart-gde.github.io/chrome.dart/index.html#chrome/chrome_app)
* [Chrome Extensions
  API](http://dart-gde.github.io/chrome.dart/index.html#chrome/chrome_ext)

## Breaking Changes

For version 0.5.0, we removed the older `chrome.socket` API in favor of the new
`chrome.sockets` API. In order to continue using the older API, you can
reference it directly via an import:

    import 'package:chrome/gen/socket.dart';

