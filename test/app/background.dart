library background;

import 'package:chrome/app.dart';

void main() {
  runtime.onMessage.listen((MessageEvent evt) {
    evt.sendResponse('respond: ${evt.message}');
  });

  app.window.create('harness_browser.html', 
      id: 'chrome_test', minWidth: 1024, minHeight: 768);
}
