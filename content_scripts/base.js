const EnhancedPullRequest = (function () {
  const callbacks = [];

  return {
    /**
     * Registers the given callback to run on page load and pjax requests.
     *
     * @param {Function} callback - function to register
     */
    register_cb: function (callback) {
      callbacks.push(callback);
    },

    /**
     * Runs all callbacks.
     */
    run: function () {
      // This isn't pretty, but I haven't found a better way yet.
      $('.epr').remove();
      callbacks.forEach(callback => callback());
    }
  };
})();
