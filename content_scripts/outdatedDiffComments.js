EnhancedPullRequest.outdatedDiffComments = {
  /**
   * Adds a button to toggle the visibility of comments on outdated diffs.
   */
  load: function () {
    $('<button type="button">Toggle Outdated Diff Comments</button>')
      .addClass('epr epr-toggle-outdated-comments btn-link')
      .click(() => $('.discussion-item-toggle-closed').click())
      .prependTo('.pull-discussion-timeline');
  }
}

EnhancedPullRequest.register_cb(EnhancedPullRequest.outdatedDiffComments.load);
