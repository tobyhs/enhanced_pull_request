// The following listener receives messages from the background script
// (background.js) when the browser history changes and the URL is a GitHub
// pull request URL.
chrome.runtime.onMessage.addListener(function (msg, sender, sendResponse) {
  EnhancedPullRequest.run();
});

EnhancedPullRequest.run();
