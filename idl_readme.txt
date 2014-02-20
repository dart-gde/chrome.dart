This directory contains copies of Chromium IDL files.

The original files are from:
URL: https://src.chromium.org/chrome/trunk/src/chrome/common/extensions/api
Current revision: 241107

SVN revisions available at http://omahaproxy.appspot.com/.

To update:
rm -rf idl
svn co https://src.chromium.org/chrome/trunk/src/chrome/common/extensions/api idl
 -or-
svn co https://src.chromium.org/chrome/trunk/src/chrome/common/extensions/api idl -r <rev_number>
update the svn revision above
dart tool/gen_apis.dart
ensure that the generated code looks good!

Please see the corresponding LICENSE file at: http://src.chromium.org/svn/trunk/src/LICENSE
