#!/usr/bin/env bash
set -o xtrace

# run pub; ensure that the code is warning free
pub get 
dartanalyzer tool/gen_apis.dart
dartanalyzer test/all.dart
dartanalyzer bin/setup_app.dart

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

# gen docs
#mkdir docs
#mkdir docs/app
#mkdir docs/ext
#dartdoc --omit-generation-time --package-root packages/ --exclude-lib=logging,chrome.src.common --out docs/app lib/chrome_app.dart
#dartdoc --omit-generation-time --package-root packages/ --exclude-lib=chrome.src.common --out docs/ext lib/chrome_ext.dart
docgen --compile --package-root=./packages --no-include-sdk --include-private lib/chrome_*

rm dartdoc-viewer/client/out/web/packages
rm dartdoc-viewer/client/out/web/docs/packages
rm dartdoc-viewer/client/out/web/docs/chrome/packages

rm dartdoc-viewer/client/out/web/static/packages
rm dartdoc-viewer/client/out/web/static/js/packages
rm dartdoc-viewer/client/out/web/static/css/packages

mv dartdoc-viewer/client/out/packages dartdoc-viewer/client/out/web/packages
mv dartdoc-viewer/client/out/web ./.docs_staging

# make sure we don't have changes in lib/gen
git checkout lib/gen

# fetch origin
git fetch origin

# get branches 
git branch -v -a

# delete any files that might still be around.
rm -rf *

# copy docs up to github gh-pages branch
#git checkout gh-pages
git checkout --track -b gh-pages origin/gh-pages

# delete any files that might still be around.
rm -rf *
date > date.txt
cd .docs_staging
cp -r . ..
cd ../
rm -rf .docs_staging
git add -A
git commit -m"auto commit from drone"
git remote set-url origin git@github.com:dart-gde/chrome.dart.git
git push origin gh-pages
