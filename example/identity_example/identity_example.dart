import 'dart:html';
import 'package:logging/logging.dart';
import 'package:chrome/chrome.dart';
// Example application: https://github.com/GoogleChrome/chrome-app-samples/blob/master/identity/identity.js
void main() {
  chromeIdentity.getAuthToken(true);
}