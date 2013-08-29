
chrome.app.runtime.onLaunched.addListener(function() {
  chrome.app.window.create('app_test.html',
    {id: 'app_test_3', width: 800, height: 575});
});
