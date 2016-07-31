(function () {
  // Regular expressions to determine whether an issue comment is an approval
  const APPROVALS = [/lgtm/i, /alias="(\+1|ship|shipit)"/];

  EnhancedPullRequest.load(function () {
    // Button/link to show/hide comments on outdated diffs
    $('<button type="button">Toggle Outdated Diff Comments</button>')
      .addClass('epr epr-toggle-outdated-comments btn-link')
      .click(() => $('.discussion-item-toggle-closed').click())
      .prependTo('.pull-discussion-timeline');

    // Give approvals a green background
    $('div[id|="issuecomment"]').each(function (i, commentContainer) {
      const commentBody = $('.js-comment-body', commentContainer);
      const commentText = commentBody.html();

      if (APPROVALS.some(regEx => commentText.match(regEx))) {
        commentBody.css('background-color', '#99ff99');
      }
    });
  });
})();
