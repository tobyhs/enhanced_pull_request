const EnhancedPullRequest = {
  _callbacks: [],

  /**
   * Registers the given callback to run on page load and pjax requests.
   *
   * @param {Function} callback - function to register
   */
  register_cb: function (callback) {
    this._callbacks.push(callback);
  },

  /**
   * Runs all callbacks.
   */
  run: function() {
    // This isn't pretty, but I haven't found a better way yet.
    $('.epr').remove();
    this._callbacks.forEach(callback => callback());
  }
};
