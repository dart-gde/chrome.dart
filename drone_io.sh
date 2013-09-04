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

# generate api docs to gh-pages
dartdoc --package-root packages lib/app.dart lib/ext.dart
git checkout gh-pages
cd docs/
cp -r . ..
cd ../
git add -A
git commit -m"auto commit from drone"
git remote set-url origin git@github.com:dart-gde/chrome.dart.git
git push origin gh-pages
