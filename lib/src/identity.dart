library chrome.identity;

import 'dart:async';
import 'package:js/js.dart' as js;
import 'common.dart';

const ChromeIdentity chromeIdentity = const ChromeIdentity._();

class ChromeIdentity {
  const ChromeIdentity._();

  Future<String> getAuthToken(bool interactive) {
    ChromeCompleter completer = new ChromeCompleter.oneArg();

    js.scoped(() {
      chromeProxy.identity
        .getAuthToken(js.map({'interactive': interactive}), completer.callback);
    });

    return completer.future;
  }

  Future removeCachedAuthToken(String token) {
    ChromeCompleter completer = new ChromeCompleter.noArgs();

    js.scoped(() {
      chromeProxy.identity
        .removeCachedAuthToken(js.map({'token': token}), completer.callback);
    });

    return completer.future;
  }

  Future<String> launchWebAuthFlow(String url, {bool interactive: false}) {
    ChromeCompleter completer = new ChromeCompleter.oneArg();

    js.scoped(() {
      chromeProxy.identity
        .launchWebAuthFlow(js.map({'url': url, 'interactive': interactive}),
            completer.callback);
    });

    return completer.future;
  }

}