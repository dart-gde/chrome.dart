#!/bin/sh

echo "NOTE: For extensions to be loaded by this script 'chrome://flags' needs 'Experimental Extension APIs' enabled. \n" 

if [ $# -lt 2 ]; then
  echo "Usage: $0 [chrome|canary|dartium] [app/extension directory]"
  exit 127
fi

PROFILE_NAME="TEST"
PROFILE_PARENT="Chrome-TEST"

case "$1" in
'chrome')  
	echo "Launching chrome with"
	GOOGLE_CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
	USER_DIR="/Users/$USER/Library/Application Support/Google/${PROFILE_PARENT}"
	echo "GOOGLE_CHROME = $GOOGLE_CHROME"
	echo "USER_DIR = $USER_DIR \n"
    ;;
'canary')  
	echo  "Launching canary with"
	GOOGLE_CHROME="/Applications/Google Chrome Canary.app/Contents/MacOS/Google Chrome Canary"
	USER_DIR="/Users/$USER/Library/Application Support/Google/${PROFILE_PARENT}"
	echo "GOOGLE_CHROME = $GOOGLE_CHROME"
	echo "USER_DIR = $USER_DIR \n"
    ;;
'dartium')  
	echo  "Launching dartium with"
	GOOGLE_CHROME="/Applications/dart/chromium/Chromium.app/Contents/MacOS/Chromium"
	USER_DIR="/Users/$USER/Library/Application Support/Dartium/${PROFILE_PARENT}"
	echo "GOOGLE_CHROME = $GOOGLE_CHROME"
	echo "USER_DIR = $USER_DIR \n"	
    ;;
*) echo "Usage: $0 [chrome|canary|dartium] [app/extension directory]"
    ;;
esac

if [[ ! -d $2 ]] ; then
  echo "App/Extension directory $1 does not exist \n"
  exit 127
fi

echo "Loading App/Extension $2 \n"

exec "$GOOGLE_CHROME" \
  --enable-udd-profiles --user-data-dir="$USER_DIR" \
  --profile-directory="$PROFILE_NAME" \
  --no-first-run \
  --no-default-browser-check \
  --enable-extension-activity-logging \
  --enable-extension-activity-ui \
  --load-and-launch-app=$2
EOF
