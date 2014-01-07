
chrome.app.runtime.onLaunched.addListener(function(launchData) {
  chrome.app.window.create('demo.html', {
    'id': '_mainWindow', 'bounds': {'width': 800, 'height': 650 }
  });
});
