part of harness_browser;

class TestApp {
  void main() {
    group('chrome.app.window', () {
      const String TEST_WINDOW_URL = 'test_window.html';
      final windows = <AppWindow>[];
      
      final createWindow = () => 
          app.window.create(TEST_WINDOW_URL)
            .then((AppWindow win) {
              windows.add(win);
              return new Future.value(win);
            });
      
      tearDown(() {
        return Future.forEach(windows, (AppWindow win) {
          win.close();
          return win.onClosed.first.then((_) => 
              new Future(() => win.dispose()));
        }).then((_) => new Future.sync(() => windows.clear()));
      });
      
      test('Test that a call to get the current window succeeds', () {
        final win = app.window.current;
        expect(win, const isInstanceOf<AppWindow>());
        expect(win.isMaximized, isFalse);
        expect(win.isMinimized, isFalse);
        expect(win.isFullscreen, isFalse);
      });
      
      test('Test a vanilla call to create() with no options', () {
        app.window.create(TEST_WINDOW_URL)
          .then(expectAsync1((AppWindow win) { 
            windows.add(win);          
            expect(win, const isInstanceOf<AppWindow>());          
            expect(win.isMaximized, isFalse);
            expect(win.isMinimized, isFalse);
            expect(win.isFullscreen, isFalse);          
          }));
      });
      
      test('Test a call to create() with options: { bounds }', () {
        app.window.create(TEST_WINDOW_URL, 
                         bounds: const Bounds(left: 10, 
                                              top: 20, 
          // TODO(rms): if we specify any width < 130 here the test will fail.
          // Investigate, possibly a Chrome bug?                                              
                                              width: 131, 
                                              height: 40))
          .then(expectAsync1((AppWindow win) { 
            windows.add(win);          
            expect(win, const isInstanceOf<AppWindow>());          
            expect(win.isMaximized, isFalse);
            expect(win.isMinimized, isFalse);
            expect(win.isFullscreen, isFalse);   
            expect(win.bounds.left, equals(10));
            expect(win.bounds.top, equals(20));
            expect(win.bounds.width, equals(131));
            expect(win.bounds.height, equals(40));
          }));
      });
      
      test('Test a successful call to minimize()', () {
        final verify = expectAsync1((AppWindow win) {
          expect(win.isMinimized, isTrue);
          expect(win.isMaximized, isFalse);
          expect(win.isFullscreen, isFalse);
        });        
        createWindow().then((AppWindow win) {          
          win.onMinimized.listen(verify);
          win.minimize();
        });       
      });
      
      test('Test a successful call to maximize()', () {
        final verify = expectAsync1((AppWindow win) {          
          expect(win.isMaximized, isTrue);
          expect(win.isFullscreen, isFalse);
          expect(win.isMinimized, isFalse);
        });        
        createWindow().then((AppWindow win) {          
          win.onMaximized.listen(verify);
          win.maximize();
        });
      });
      
      test('Test a successful call to restore() from isMaximized', () {
        final verify = expectAsync1((AppWindow win) {          
          expect(win.isMaximized, isFalse);
          expect(win.isFullscreen, isFalse);
          expect(win.isMinimized, isFalse);
        });        
        createWindow().then((AppWindow win) {    
          win.onRestored.listen(verify);
          win.maximize();
          return win.onMaximized.first.then((win) => win.restore());
        });
      });
      
      test('Test a successful call to fullscreen()', () {
        final verify = expectAsync1((AppWindow win) {
          expect(win.isFullscreen, isTrue);
          expect(win.isMaximized, isFalse);          
          expect(win.isMinimized, isFalse);
        });        
        createWindow().then((AppWindow win) {          
          win.onFullscreened.listen(verify);
          win.fullscreen();
        });
      });
      
    });
  }
}
