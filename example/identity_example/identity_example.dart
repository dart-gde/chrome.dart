import 'dart:html';
import 'package:logging/logging.dart';
import 'package:chrome/chrome.dart';
// Example application: https://github.com/GoogleChrome/chrome-app-samples/blob/master/identity/identity.js
void main() {
  //chromeIdentity.getAuthToken(true);

  ButtonElement signinButton = query("#signin");
  ButtonElement revokeButton = query("#revoke");
  signinButton.style.display = null;
  signinButton.onClick.listen((data) {
    chromeIdentity.getAuthToken(interactive: true).then((token) => print("token = $token"));
  });
}