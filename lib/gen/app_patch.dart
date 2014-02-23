
/**
 * Hand-written patches for the generated `app.dart` file.
 */
part of chrome.app;

/*
 * This patch file re-routes event calls on the ChromeAppWindow class to the
 * single AppWindow instance. The idl defines the events on ChromeAppWindow; the
 * implementation actually exists on the AppWindow.
 *
 * As a special caveat, the onClosed will never be called.
 */

class ChromeAppWindow extends _ChromeAppWindow {
  ChromeAppWindow._() : super._();

  Stream get onBoundsChanged => current().onBoundsChanged;
  Stream get onClosed => current().onClosed;
  Stream get onFullscreened => current().onFullscreened;
  Stream get onMaximized => current().onMaximized;
  Stream get onMinimized => current().onMinimized;
  Stream get onRestored => current().onRestored;
}

class AppWindow extends _AppWindow {
  Map<String, Stream> _streamMap = {};

  AppWindow({Window contentWindow}) : super(contentWindow: contentWindow);
  AppWindow.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  Stream get onBoundsChanged => _streamFor('onBoundsChanged');
  Stream get onClosed => _streamFor('onClosed');
  Stream get onFullscreened => _streamFor('onFullscreened');
  Stream get onMaximized => _streamFor('onMaximized');
  Stream get onMinimized => _streamFor('onMinimized');
  Stream get onRestored => _streamFor('onRestored');

  Stream _streamFor(String event) {
    if (_streamMap[event] == null) {
      _streamMap[event] = new ChromeStreamController.noArgs(jsProxy, event).stream;
    }

    return _streamMap[event];
  }
}
