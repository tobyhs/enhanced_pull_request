EnhancedPullRequest.reply = (function () {
  /**
   * Adds a reply icon to the given context.
   *
   * @param {Element|jQuery} context
   *   where to add the icon (something containing an element of the
   *   "timeline-comment-actions" class)
   * @returns {jQuery} the icon that was created
   */
  function addReplyIconTo(context) {
    return $('<button type="button" title="Reply" aria-label="Reply" />')
      .addClass('epr epr-reply-button btn-link timeline-comment-action')
      .append($('<img />', {src: chrome.extension.getURL('images/reply.svg')}))
      .prependTo($('.timeline-comment-actions', context));
  }

  /**
   * Quotes the given message to form a reply.
   *
   * @param {string} message - original message (in Markdown)
   * @returns {string} quoted text for replying (in Markdown)
   */
  function replyTextFor(message) {
    return `\n\n> ${message.replace(/\n/g, '\n> ')}`;
  }

  // to-markdown converters (workarounds for GitHub-specific conversions)
  const markdownConverters = [
    {
      // emojis
      filter: 'g-emoji',
      replacement: (content, node) => `:${node.getAttribute('alias')}:`
    },
    {
      // user mentions
      filter: node => node.className === 'user-mention',
      replacement: content => content
    }
  ];

  /**
   * Adds reply text.
   *
   * @param {Element} commentContainer - container with the original comment
   * @param {jQuery} $replyTextarea - textarea to add the reply text to
   */
  function addReplyTextTo(commentContainer, $replyTextarea) {
    const commentBody = $('.js-comment-body', commentContainer).html();
    const replyText = replyTextFor(toMarkdown(
      commentBody, {gfm: true, converters: markdownConverters}
    ));
    $replyTextarea.val(replyText).focus();
    $replyTextarea[0].setSelectionRange(0, 0);
  }

  /**
   * Adds reply icons to comment containers.
   */
  function load() {
    const $newCommentField = $('#new_comment_field');

    // Replies for issue comments
    $('div[id|="issuecomment"]').each(function (i, commentContainer) {
      addReplyIconTo(commentContainer).click(function () {
        addReplyTextTo(commentContainer, $newCommentField);
      });
    });

    // Replies for line comments
    $('.line-comments').each(function () {
      const $commentButton = $('.js-toggle-inline-comment-form', this);
      const $commentTextarea = $('.inline-comment-form textarea', this);

      $('.commit-comment', this).each(function (i, commentContainer) {
        addReplyIconTo(commentContainer).click(function () {
          if ($commentTextarea.is(':hidden')) {
            $commentButton.click();
          }
          addReplyTextTo(commentContainer, $commentTextarea);
        });
      });
    });
  }

  return {addReplyIconTo, replyTextFor, addReplyTextTo, load};
})();

EnhancedPullRequest.register_cb(EnhancedPullRequest.reply.load);
