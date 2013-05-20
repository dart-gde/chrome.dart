#!/bin/bash
PATH=/Applications/dart/dart-sdk/bin/:$PATH
dart2js --verbose --disallow-unsafe-eval -obluetooth_getadapterstate.dart.js bluetooth_getadapterstate.dart

