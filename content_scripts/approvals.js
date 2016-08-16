EnhancedPullRequest.approvals = {
  // Regular expressions to determine whether an issue comment is an approval
  APPROVALS: [/lgtm/i, /alias="(\+1|ship|shipit)"/],

  BG_COLOR: '#99ff99',

  /**
   * Gives issue comments with approvals a green background.
   */
  load: function () {
    const approvals = EnhancedPullRequest.approvals;

    $('div[id|="issuecomment"]').each(function (i, commentContainer) {
      const commentBody = $('.js-comment-body', commentContainer);
      const commentText = commentBody.html();

      if (approvals.APPROVALS.some(regEx => commentText.match(regEx))) {
        commentBody.css('background-color', approvals.BG_COLOR);
      }
    });
  }
};

EnhancedPullRequest.register_cb(EnhancedPullRequest.approvals.load);
