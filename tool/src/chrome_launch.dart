library nv.tool.chrome;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bot_io/bot_io.dart';

const _CHROME_PATH_ENV_KEY = 'CHROME_PATH';
const _MAC_CHROME_PATH = '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome';

Future<int> launchChrome(String manifestDir, {String chromePath,
  bool logStdOut: false, bool logStdErr: true, bool logVerbose: true}) {
  if(chromePath == null) {
    chromePath = Platform.environment[_CHROME_PATH_ENV_KEY];
  }
  if(chromePath == null && Platform.isMacOS) {
    chromePath = _MAC_CHROME_PATH;
  }

  if(chromePath == null) {
    throw new ArgumentError('"chromePath" must be provided or the '
        '$_CHROME_PATH_ENV_KEY environment variable must be set');
  }

  if(!FileSystemEntity.isFileSync(chromePath)) {
    throw new Exception('Could not find Chrome at $chromePath');
  }

  var config =
    {
     'enable-logging': 'stderr',
     'load-and-launch-app': manifestDir,
     'no-default-browser-check': null,
     'no-first-run': null,
     'no-startup-window': null
    };

  if(logVerbose) {
    config['v'] = null;
  }

  return TempDir
      .then((dir) => _launchChrome(dir, chromePath, config, logStdOut, logStdErr));
}

Future<int> _launchChrome(Directory tempDir, String chromePath,
    Map<String, String> argsMap, bool logStdOut, bool logStdErr) {

  argsMap['user-data-dir'] = tempDir.path;

  var args = argsMap.keys.map((key) {
    assert(!key.startsWith('-'));
    var value = argsMap[key];

    var str = "--$key";
    if(value == null) {
      return str;
    } else {
      return "$str=$value";
    }
  }).toList(growable: false);

  return Process.start(chromePath, args)
      .then((Process process) {

        _captureStd(logStdOut, process.stdout);
        _captureStd(logStdErr, process.stderr);

        return process.exitCode;
      });
}

void _captureStd(bool process, Stream<List<int>> std) {

  std.transform(UTF8.decoder)
    .listen((String value) {
      if(process) {
        print(value);
      }
    });
}
