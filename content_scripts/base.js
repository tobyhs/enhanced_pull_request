const EnhancedPullRequest = {
  _callbacks: [],

  /**
   * Loads the given callback and registers it to reload on pjax requests.
   *
   * @param {Function} callback - function to execute
   */
  load: function (callback) {
    this._callbacks.push(callback);
    callback();
  }
};

chrome.runtime.onMessage.addListener(function (msg, sender, sendResponse) {
  // This isn't pretty, but I haven't found a better way yet.
  $('.epr').remove();
  EnhancedPullRequest._callbacks.forEach(callback => callback());
});
