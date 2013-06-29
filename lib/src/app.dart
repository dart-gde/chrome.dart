library chrome_app;

import 'dart:async';
import 'package:js/js.dart' as js;
import 'common.dart';

// chrome.app

final ChromeApp app = const ChromeApp._();

class ChromeApp {
  final ChromeWindow window = const ChromeWindow._();
  const ChromeApp._();
}

// chrome.app.window

class ChromeWindow {
  const ChromeWindow._();
  
  static AppWindow _current;
  /// An [AppWindow] object for the current script context (ie JavaScript 
  /// 'window' object).
  AppWindow get current {
    if (_current == null) {
      _current = new AppWindow._(js.context.chrome.app.window.current());
    }
    return _current;
  }

  Future<AppWindow> create(String url, 
                           {String id, 
                           int minWidth,
                           int minHeight,
                           int maxWidth,
                           int maxHeight,
                           String frame,
                           Bounds bounds,
                           bool transparentBackground,
                           bool hidden,
                           bool resizable,
                           bool singleton}) {
    final options = {};
    if (id != null) options['id'] = id;
    if (minWidth != null) options['minWidth'] = minWidth;
    if (minHeight != null) options['minHeight'] = minHeight;
    if (maxWidth != null) options['maxWidth'] = maxWidth;
    if (maxHeight != null) options['maxHeight'] = maxHeight;
    if (frame != null) options['frame'] = frame;
    if (bounds != null) options['bounds'] = js.map(bounds._map);
    if (transparentBackground != null) 
      options['transparentBackground'] = transparentBackground;
    if (hidden != null) options['hidden'] = hidden;
    if (resizable != null) options['resizable'] = resizable;
    if (singleton != null) options['singleton'] = singleton;
    
    final completer = new Completer<AppWindow>();
    js.context.chrome.app.window.create(
        url,
        js.map(options),
        new js.Callback.once((proxy) =>
            completer.complete(new AppWindow._(proxy))));
    return completer.future;
  }
}

// http://developer.chrome.com/apps/app.window.html#type-Bounds
class Bounds {
  final int left, top, width, height;
  Map get _map {
    final m = {};
    if (left != null) m['left'] = left;
    if (top != null) m['top'] = top;
    if (width != null) m['width'] = width;
    if (height != null) m['height'] = height;
    return m;
  }
  const Bounds({this.left, this.top, this.width, this.height});
  Bounds._(m)
      : left = m['left']
      , top = m['top']
      , width = m['width']
      , height = m['height'];
}

// http://developer.chrome.com/apps/app.window.html#type-AppWindow
class AppWindow {  
  js.Proxy _proxy;
  js.Callback _jsOnBoundsChanged;
  js.Callback _jsOnClosed;
  js.Callback _jsOnFullscreened;
  js.Callback _jsOnMaximized;
  js.Callback _jsOnMinimized;
  js.Callback _jsOnRestored;
  
  /// The bounds of this window.
  Bounds 
    get bounds => new Bounds._(_proxy.getBounds());
    set bounds(Bounds value) => _proxy.setBounds(value);
  
  /// The JavaScript 'window' object for the created child.
  /* Window */ get contentWindow => throw new UnimplementedError();
  
  bool get isDisposed => _proxy == null;
  
  /// Is this window fullscreen?
  bool get isFullscreen => _proxy.isFullscreen();
  
  /// Is this window maximized?
  bool get isMaximized => _proxy.isMaximized();
  
  /// Is this window minimized?
  bool get isMinimized => _proxy.isMinimized();
  
  final _onBoundsChanged = new StreamController.broadcast();
  // We must send the `onClosed` event synchronously so that the `current`
  // AppWindow has a chance to perform some work on closing.
  final _onClosed = new StreamController.broadcast(sync: true);
  final _onFullscreened = new StreamController.broadcast();
  final _onMaximized = new StreamController.broadcast();
  final _onMinimized = new StreamController.broadcast();
  final _onRestored = new StreamController.broadcast();
  
  /// Fired when this window is resized.
  Stream get onBoundsChanged => _onBoundsChanged.stream;
  
  /// Fired when this window is closed.
  Stream get onClosed => _onClosed.stream;
  
  /// Fired when this window is fullscreened.
  Stream get onFullscreened => _onFullscreened.stream;
  
  /// Fired when this window is maximized.
  Stream get onMaximized => _onMaximized.stream;
  
  /// Fired when this window is minimized.
  Stream get onMinimized => _onMinimized.stream;
  
  /// Fired when this window is restored from being minimized or maximized.
  Stream get onRestored => _onRestored.stream;
  
  AppWindow._(js.Proxy proxy) : _proxy = js.retain(proxy) {
    _jsOnBoundsChanged = new js.Callback.many(() => _onBoundsChanged.add(this));
    _jsOnClosed = new js.Callback.many(() => _onClosed.add(this));
    _jsOnFullscreened = new js.Callback.many(() => _onFullscreened.add(this));
    _jsOnMaximized = new js.Callback.many(() => _onMaximized.add(this));    
    _jsOnMinimized = new js.Callback.many(() => _onMinimized.add(this));
    _jsOnRestored = new js.Callback.many(() => _onRestored.add(this));
    _proxy.onBoundsChanged.addListener(_jsOnBoundsChanged);
    _proxy.onClosed.addListener(_jsOnClosed);
    _proxy.onFullscreened.addListener(_jsOnFullscreened);
    _proxy.onMaximized.addListener(_jsOnMaximized);
    _proxy.onMinimized.addListener(_jsOnMinimized);
    _proxy.onRestored.addListener(_jsOnRestored);
  }
  
  void dispose() {
    assert(!isDisposed);
    _onBoundsChanged.close();
    _onClosed.close();
    _onFullscreened.close();
    _onMaximized.close();
    _onMinimized.close();
    _onRestored.close();
    _jsOnBoundsChanged.dispose();
    _jsOnClosed.dispose();
    _jsOnFullscreened.dispose();
    _jsOnMaximized.dispose();
    _jsOnMinimized.dispose();
    _jsOnRestored.dispose();
    js.release(_proxy);
    _proxy = null;
  }
  
  /// Clear attention from this window.
  void clearAttention() => _proxy.clearAttention();
  
  /// Close this window.
  void close() => _proxy.close();
  
  /// Draw attention to this window.
  void drawAttention() => _proxy.drawAttention();
  
  /// Focus this window.
  void focus() => _proxy.focus();
  
  /// Hide this window. Does nothing if this window is already hidden.
  void hide() => _proxy.hide();
  
  /// Maximize this window.
  void maximize() => _proxy.maximize();
  
  /// Minimize this window.
  void minimize() => _proxy.minimize();
  
  /// Move this window to the position ([left], [top]).
  void moveTo(int left, int top) => _proxy.moveTo(left, top);
  
  /// Resize this window to [width] x [height] pixels in size.
  void resizeTo(int width, int height) => _proxy.resizeTo(width, height);
  
  /// Restore this window, exiting a maximized or minimized state.
  void restore() => _proxy.restore();
  
  /// Show this window. Does nothing if this window is already visible.
  void show() => _proxy.show();
}
