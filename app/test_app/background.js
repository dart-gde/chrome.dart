
chrome.runtime.onMessage.addListener(function(message, sender, sendResponse) {
  console.log('respond: ' + message);
  sendResponse('respond: ' + message);
});

chrome.app.runtime.onLaunched.addListener(function() {
  chrome.app.window.create('harness.html',
    {id: 'chrome_test', width: 1024, height: 768});
});
