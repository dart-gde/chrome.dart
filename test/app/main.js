
chrome.runtime.onMessage.addListener(function(message, sender, sendResponse) {
  sendResponse('respond: ' + message);
});

chrome.app.runtime.onLaunched.addListener(function() {
  chrome.app.window.create('harness_browser.html',
    {id: 'chrome_test', width: 1024, height: 768});
});
