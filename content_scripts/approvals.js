(function () {
  // Regular expressions to determine whether an issue comment is an approval
  const APPROVALS = [/lgtm/i, /alias="(\+1|ship|shipit)"/];

  EnhancedPullRequest.load(function () {
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
