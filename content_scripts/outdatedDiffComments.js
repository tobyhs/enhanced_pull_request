EnhancedPullRequest.outdatedDiffComments = {
  /**
   * Adds buttons to show or hide comments on outdated diffs.
   */
  load: function () {
    const $container = $('<div class="epr">Outdated Diff Comments: </div>');

    $('<button type="button">Show</button>')
      .addClass('epr epr-show-outdated-comments btn-link')
      .click(() => $('.discussion-item-toggle-closed:visible, .show-outdated-button:visible').click())
      .appendTo($container);

    $container.append(' ');

    $('<button type="button">Hide</button>')
      .addClass('epr epr-hide-outdated-comments btn-link')
      .click(() => $('.discussion-item-toggle-open:visible, .hide-outdated-button:visible').click())
      .appendTo($container);

    $container.prependTo('.pull-discussion-timeline');
  }
};

EnhancedPullRequest.register_cb(EnhancedPullRequest.outdatedDiffComments.load);
