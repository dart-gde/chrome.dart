#!/bin/bash
PATH=/Applications/dart/dart-sdk/bin/:$PATH
dart2js --verbose --disallow-unsafe-eval -oclock.dart.js clock.dart

