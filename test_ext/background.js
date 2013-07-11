// Called when the user clicks on the browser action.
chrome.browserAction.onClicked.addListener(function(tab) {
  chrome.tabs.create({url: "harness_extension.html"}, function() {
  	console.log("launching harness_extension.html");
  });
});