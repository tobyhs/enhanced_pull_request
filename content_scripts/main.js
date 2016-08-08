chrome.runtime.onMessage.addListener(function (msg, sender, sendResponse) {
  EnhancedPullRequest.run();
});

EnhancedPullRequest.run();
