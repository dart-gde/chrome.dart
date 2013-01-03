#!/bin/bash
PATH=/Applications/dart/dart-sdk/bin/:$PATH
dart2js --verbose --disallow-unsafe-eval -otcp_echo_server_example.dart.js tcp_echo_server_example.dart

