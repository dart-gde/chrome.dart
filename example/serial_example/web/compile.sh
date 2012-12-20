#!/bin/bash
PATH=/Applications/dart/dart-sdk/bin/:$PATH
dart2js --verbose --disallow-unsafe-eval -ochrome_app_serial_example.dart.js chrome_app_serial_example.dart

