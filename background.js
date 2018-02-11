// GitHub uses pjax, so we can't solely rely on content scripts to run each
// time. Instead, we listen for history changes and send messages to
// content_scripts/main.js.
chrome.webNavigation.onHistoryStateUpdated.addListener(
  function (details) {
    chrome.tabs.query({active: true, currentWindow: true}, function (tabs) {
      chrome.tabs.sendMessage(tabs[0].id, {type: 'pjax-update'});
    });
  },
  {url: [{originAndPathMatches: '^https://github.com/.*/.*/pull/'}]}
);
