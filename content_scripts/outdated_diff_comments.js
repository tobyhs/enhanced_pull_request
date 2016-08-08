(function () {
  EnhancedPullRequest.load(function () {
    // Button/link to show/hide comments on outdated diffs
    $('<button type="button">Toggle Outdated Diff Comments</button>')
      .addClass('epr epr-toggle-outdated-comments btn-link')
      .click(() => $('.discussion-item-toggle-closed').click())
      .prependTo('.pull-discussion-timeline');
  });
})();
