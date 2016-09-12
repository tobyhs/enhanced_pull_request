EnhancedPullRequest.approvals = {
  // Regular expressions to determine whether an issue comment is an approval
  APPROVALS: [/lgtm/i, /alias="(\+1|ship|shipit)"/],

  BG_COLOR: '#99ff99',

  /**
   * @returns {string} username of pull request opener
   */
  getOpener: function () {
    return $('.pull-header-username').text().trim();
  },

  /**
   * Gives issue comments with approvals a green background.
   */
  load: function () {
    const approvals = EnhancedPullRequest.approvals;
    const prOpener = approvals.getOpener();

    $('div[id|="issuecomment"]').each(function (i, commentContainer) {
      const commentAuthor = $('.author', commentContainer).text();
      const commentBody = $('.js-comment-body', commentContainer);
      const commentText = commentBody.html();

      if (approvals.APPROVALS.some(regEx => commentText.match(regEx)) &&
          commentAuthor !== prOpener) {
        commentBody.css('background-color', approvals.BG_COLOR);
      }
    });
  }
};

EnhancedPullRequest.register_cb(EnhancedPullRequest.approvals.load);
