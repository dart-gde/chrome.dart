
import 'dart:async';
import 'dart:convert' show JSON;
import 'dart:html';

import 'package:chrome/app.dart';

final plusUrl = "https://www.googleapis.com/plus/v1/people/me";

Future<String> loadImage(String imageUrl) {
  HttpRequest request;
  Completer completer = new Completer();
  request = new HttpRequest()
  ..responseType = 'blob'
  ..onLoadEnd.listen((Event e) {
    completer.complete(Url.createObjectUrlFromBlob(request.response));
  })
  ..open('GET', imageUrl)
  ..send();
  return completer.future;
}

void main() {
  String token;

  ButtonElement signinButton = query("#signin");
  ButtonElement revokeButton = query("#revoke");
  DivElement outputDiv = query("#output");

  signinButton
  ..style.display = null
  ..onClick.listen((data) {
    chromeIdentity.getAuthToken(interactive: true)
      .then((_token) {
        token = _token;
        print("token = $token , ${token.runtimeType}");
        var request = new HttpRequest();
        request.onLoadEnd.listen((Event e) {
          print("onLoadEnd = $e");
          if (request.status == 200) {
            signinButton.style.display = "none";
            revokeButton.style.display = null;
            outputDiv.children.clear();
            print("request.responseText = ${request.responseText}");
            var data = JSON.parse(request.responseText);
            ParagraphElement p = new ParagraphElement()
            ..text = "Logged in as ${data["displayName"]}";
            outputDiv.children.add(p);
            var imageUrl = data["image"]["url"];
            loadImage(imageUrl).then((dataUrl) {
              ImageElement img = new ImageElement();
              img.src = dataUrl;
              outputDiv.children.add(img);
            });
          } else {
            ParagraphElement p = new ParagraphElement()
            ..text = "Error ${request.status}: ${request.statusText}";
            outputDiv.children.add(p);
            chromeIdentity.removeCachedAuthToken(token)
              .then((_) {
                final removedTokenText = "Removed ${token} from cache";
                print(removedTokenText);
                ParagraphElement p = new ParagraphElement()
                ..text = removedTokenText;
                outputDiv.children.add(p);
              });
          }
        });

        print("opening request");
        request
        ..open("GET", plusUrl)
        ..setRequestHeader('Authorization', 'Bearer $token')
        ..send();

      });
  });

  revokeButton.onClick.listen((data) {
    if (token != null) {
      new HttpRequest()
      ..open('GET', 'https://accounts.google.com/o/oauth2/revoke?token=${token}')
      ..send();
    }

    signinButton.style.display = null;
    revokeButton.style.display = "none";
    outputDiv.children.clear();
  });
}