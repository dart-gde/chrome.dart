#!/bin/bash
PATH=/Applications/dart/dart-sdk/bin/:$PATH
dart2js --verbose --disallow-unsafe-eval -obluetooth_getdevices.dart.js bluetooth_getdevices.dart

