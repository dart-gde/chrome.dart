This directory contains copies of Chromium IDL files.

The original files are from:

  https://src.chromium.org/chrome/trunk/src/chrome/common/extensions/api
  https://src.chromium.org/chrome/trunk/src/extensions/common/api

SVN revisions available at http://omahaproxy.appspot.com/.
Current revision: 283104

To update:

  rm -rf idl
  svn co https://src.chromium.org/chrome/trunk/src/chrome/common/extensions/api idl/chrome -r <rev_number>
  svn co https://src.chromium.org/chrome/trunk/src/extensions/common/api idl/extensions -r <rev_number>

Please see the corresponding LICENSE file at: http://src.chromium.org/svn/trunk/src/LICENSE
