#!/usr/bin/env bash
set -o xtrace
set -e 

# run pub; ensure that the code is warning free
pub get 
dartanalyzer tool/gen_apis.dart
dartanalyzer test/all.dart
dartanalyzer bin/setup_app.dart

# TODO(adam): https://github.com/dart-gde/chrome.dart/issues/196
# generate the APIs; ensure the gen tool is happy
dart tool/gen_apis.dart

# ensure the generated code is warning free
dartanalyzer lib/chrome_app.dart
dartanalyzer lib/chrome_ext.dart

# run tests
dart test/all.dart

# ensure app folder builds and is warning free
dart bin/setup_app.dart app/demo demo.dart  
dartanalyzer app/demo/demo.dart

dart bin/setup_app.dart app/test_app harness.dart
dartanalyzer app/test_app/harness.dart

dart bin/setup_app.dart app/test_ext harness.dart
dartanalyzer app/test_ext/harness.dart

