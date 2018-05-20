EnhancedPullRequest.reply = (function () {
  const turndownService = new TurndownService()
    .use(turndownPluginGfm.gfm)
    .addRule('emoji', {
      filter: 'g-emoji',
      replacement: (content, node) => `:${node.getAttribute('alias')}:`,
    })
    .addRule('user-mention', {
      filter: node => node.className === 'user-mention',
      replacement: content => content,
    });

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

  /**
   * Adds reply text.
   *
   * @param {Element} commentContainer - container with the original comment
   * @param {jQuery} $replyTextarea - textarea to add the reply text to
   */
  function addReplyTextTo(commentContainer, $replyTextarea) {
    const commentBody = $('.js-comment-body', commentContainer).html();
    const replyText = replyTextFor(turndownService.turndown(commentBody));
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
  }

  return {addReplyIconTo, replyTextFor, addReplyTextTo, load};
})();

EnhancedPullRequest.register_cb(EnhancedPullRequest.reply.load);
