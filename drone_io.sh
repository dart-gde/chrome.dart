# start xwindows
sudo start xvfb
# ls -al $DART_SDK
echo $DART_SDK
$DART_SDK/../chromium/chrome --version
CHROME=$DART_SDK/../chromium/chrome
pub install
dartanalyzer lib/app.dart
dartanalyzer lib/ext.dart
dart tool/hop_runner.dart --log-level all build_all
# dart tool/hop_runner.dart --log-level all analyze_tests
# dart tool/hop_runner.dart --log-level all test_dart2js
# $CHROME --load-and-launch-app=test
