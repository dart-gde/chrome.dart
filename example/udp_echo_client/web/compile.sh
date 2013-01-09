#!/bin/bash
PATH=/Applications/dart/dart-sdk/bin/:$PATH
dart2js --verbose --disallow-unsafe-eval -oudp_echo_client_example.dart.js udp_echo_client_example.dart

