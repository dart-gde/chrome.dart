
// Called when the user clicks on the browser action.
chrome.browserAction.onClicked.addListener(function(tab) {
  chrome.tabs.create({url: "harness.html"}, function() {
    console.log("launching harness.html");
  });
});
