library chrome.app;

import 'dart:async';
import 'package:js/js.dart' as js;
import 'common.dart';

/// Accessor for the `chrome.app` namespace.
final ChromeApp app = const ChromeApp._();

/// Encapsulation of the `chrome.app` namespace.
/// 
/// The single instance of this class is accessed from the [app] getter.
class ChromeApp {
  /// Accessor for the `chrome.app.window` namespace.
  final ChromeWindow window = const ChromeWindow._();
  const ChromeApp._();
}

/// Encapsulation of the `chrome.app.window` namespace.
/// 
/// The single instance of this class is accessed from the [app.window] getter.
class ChromeWindow {
  const ChromeWindow._();
  
  static AppWindow _current;
  /// An [AppWindow] object for the current script context.
  AppWindow get current {
    if (_current == null) {
      _current = new AppWindow._(js.context.chrome.app.window.current());
    }
    return _current;
  }

  /// Create an [AppWindow].
  ///
  /// The size and position of a window can be specified in a number of 
  /// different ways. The most simple option is not specifying anything at all, 
  /// in which case a default size and platform dependent position will be used.
  /// 
  /// Another option is to specify a [bounds], which will always put the window 
  /// at the specified coordinates with the specified size.  
  /// 
  /// Yet another option is to give the window a (unique) [id]. This id is then 
  /// used to remember the bounds of the window whenever it is moved or resized. 
  /// This bounds is then used instead of the specified bounds on subsequent 
  /// opening of a window with the same id. If you need to open a window with an 
  /// id at a location other than the remembered default, you can create it 
  /// [hidden], move it to the desired location, then [AppWindow.show] it. 
  /// 
  /// You can also combine these various options, explicitly specifying for 
  /// example the size while having the position be remembered or other 
  /// combinations like that. Size and position are dealt with seperately, but 
  /// individual coordinates are not. So if you specify a top (or left) 
  /// coordinate, you should also specify a left (or top) coordinate, and 
  /// similar for size.
  /// 
  /// The following optional parameters may be specified:
  /// 
  /// [id] : An identifier for the window. This will be used to remember the 
  /// size and position of the window and restore that geometry when a window 
  /// with the same id (and no explicit size or position) is later opened.
  /// [minWidth]: Minimum width for the lifetime of the window.
  /// [minHeight]: Minimum height for the lifetime of the window.
  /// [maxWidth]: Maximum width for the lifetime of the window.
  /// [maxHeight]: Maximum height for the lifetime of the window.
  /// [frame]: Frame type: 'none' or 'chrome' (defaults to 'chrome').
  /// [bounds]: Position and size of the content in the window (excluding the 
  /// titlebar).
  /// [transparentBackground]: Enable window background transparency. Only 
  /// supported in ash. Requires experimental API permission.
  /// [hidden]: If true, the window will be created in a hidden state. Call 
  /// [AppWindow.show] to show it once it has been created. Defaults to false.
  /// [resizable]: If true, the window will be resizable by the user. Defaults 
  /// to true.
  /// [singleton]: By default if you specify an id for the window, the window 
  /// will only be created if another window with the same id doesn't already 
  /// exist. If a window with the same id already exists that window is 
  /// activated instead. If you do want to create multiple windows with the same 
  /// id, you can set this property to false.
  /// [state]: The initial state of the window, allowing it to be created 
  /// already fullscreen, maximized, or minimized. Defaults to 'normal'.
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
                           bool singleton,
                           String state}) {
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
    if (state != null) options['state'] = state;
    
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
/// The bounds of an [AppWindow].
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
/// A Chrome application window.
/// 
/// Windows have an optional frame with title bar and size controls. They are 
/// not associated with any Chrome browser windows.
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
  
  /// The html 'window' object for the created child.
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
  
  /// Fullscreens this window.
  void fullscreen() => _proxy.fullscreen();
  
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
  
  /// Restore this window, exiting a maximized, minimized, or fullscreen state.
  void restore() => _proxy.restore();
  
  /// Show this window. Does nothing if this window is already visible.
  void show() => _proxy.show();
}
