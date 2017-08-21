#!/usr/bin/env bash
set -o xtrace
set -e 

# Ensure that the code is warning free.
dartanalyzer --fatal-warnings tool/lib/gen_apis.dart
dartanalyzer --fatal-warnings tool/test/all.dart
dartanalyzer --fatal-warnings test/all.dart

# TODO(adam): https://github.com/dart-gde/chrome.dart/issues/196
# Generate the APIs; ensure the gen tool is happy.
# dart tool/gen_apis.dart

# Ensure the generated code is warning free.
dartanalyzer --fatal-warnings lib/chrome_app.dart
dartanalyzer --fatal-warnings lib/chrome_ext.dart

# Run tests.
dart test/all.dart

# Ensure app folder builds and is warning free.
pub build app/demo  
dartanalyzer --fatal-warnings app/demo/demo.dart

pub build app/test_app
dartanalyzer --fatal-warnings app/test_app/harness.dart

pub build app/test_ext
dartanalyzer --fatal-warnings app/test_ext/harness.dart
