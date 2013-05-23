#!/bin/bash
# PATH=/Applications/dart/dart-sdk/bin/:$PATH


dart2js --disallow-unsafe-eval -ochrome_app_usb_example.dart.js chrome_app_usb_example.dart

sed -i "s#=chrome_app_usb_example.dart.js.map#="`pwd`"/chrome_app_usb_example.dart.js.map#" chrome_app_usb_example.dart.js 