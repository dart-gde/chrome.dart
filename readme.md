# chrome_gen.dart

An library for accessing the Chrome APIs in a packaged app or extension.

[![Build Status](https://drone.io/github.com/dart-gde/chrome_gen.dart/status.png)](https://drone.io/github.com/dart-gde/chrome_gen.dart/latest)

## Installing

Add this to your package's pubspec.yaml file:

    dependencies:
      chrome_gen: any

## Using the library

    import 'package:chrome_gen/chrome_app.dart' as chrome_gen;

    void main() {
      chrome_gen.runtime.getPlatformInfo().then((Map m) {
        print(m.toString());
      });
    }

Also, see the [FAQ](https://github.com/dart-gde/chrome_gen.dart/wiki/FAQ).

## Documentation
Documentation is available at:

* [Chrome Apps API](http://dart-gde.github.io/chrome_gen.dart/app/)
* [Chrome Extensions API](http://dart-gde.github.io/chrome_gen.dart/ext/)

## Re-generating the library
From the project directory, run:

`dart tool/gen_apis.dart`

This will:

* read `meta/apis.json` and `meta/overrides.json`
* parse the cooresponding `idl/*.json` and `idl/*.idl` files
* generate `lib/chrome_app.dart`, `lib/chrome_ext.dart`, and `lib/gen/*.dart`.
