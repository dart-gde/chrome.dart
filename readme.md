# chrome.dart

[![Build Status](https://drone.io/github.com/dart-gde/chrome.dart/status.png)][badge]

### Description

A team effort to create interop with the [Chrome.* APIs][] used for
[Chrome Packaged Apps][].

### Using

## Chrome Packaged Apps

```dart
import 'package:chrome/app.dart';
```

## Chrome Extensions

```dart
import 'package:chrome/ext.dart';
```

The best results will happen when compiling to javascript with the following
command.

```
dart2js --verbose --disallow-unsafe-eval -o<name>.dart.js <name>.dart
```

Check out the [example](example) folder on setup.

### Using in dartium

It is possible to run a dart chrome app in dartium within the dartvm. Chrome
apps do not like having sym links outside of there project folder. One solution
is to clone the package dependencies and breaking the symlinks. Something like
the following might work.

```
pub install
cd <project_name>/packages/
rsync -RLr . ../packages_snapshots
cd ../
rm -rf packages
mv packages_snapshots packages
```

Then you can `cp -r` the `packages` to the containing chrome app package
directory.

### Building unit tests and loading

* Run `./bin/hop test_dart2js`.
* Open chrome to `chrome://extensions/`.
* Click `developer mode`
* `Load unpacked extension…` to `chrome.dart/test`.

### Authors

 * [Kevin Moore](https://github.com/kevmoo) ([@kevmoo](http://twitter.com/kevmoo))
 * [Adam Singer](http://goo.gl/v5xRS)
 * [Devon Carew](https://github.com/devoncarew)
 * [Amanda Cameron](http://github.com/AmandaCameron)
 * [Ross Smith](http://futureperfect.info)
 * [Marc Fisher](https://github.com/DrMarcII)
 * _You? File bugs. Fork and Fix bugs. Let's build this community._

### Versioning

Our goal is to follow [Semantic Versioning](http://semver.org/).

### License

```
The BSD 2-Clause License
http://www.opensource.org/licenses/bsd-license.php

Copyright (c) 2012, The chrome.dart project authors
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

The views and conclusions contained in the software and documentation are those
of the authors and should not be interpreted as representing official policies,
either expressed or implied, of the FreeBSD Project.
```

[badge]: https://drone.io/github.com/dart-gde/chrome.dart/latest
[Chrome.* APIs]: http://developer.chrome.com/trunk/apps/api_index.html
[Chrome Packaged Apps]: http://developer.chrome.com/trunk/apps/about_apps.html
