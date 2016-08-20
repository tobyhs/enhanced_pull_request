EnhancedPullRequest.oneFileDiff = {
  /**
   * Adds a "One-File Diff" link that expands to links of files. Clicking one
   * of these file links opens a page with only the diff of that file.
   */
  load: function () {
    const diffLinks = $('div[data-path]').map(function () {
      const fileName = this.getAttribute('data-path');
      const url = new URL(location);
      const params = new URLSearchParams();
      params.set('eprFocus', fileName);
      url.search = `?${params.toString()}`;

      const link = $('<a class="epr epr-one-file-diff" data-skip-pjax/>')
        .attr({href: url}).text(fileName);
      return $('<div class="epr"/>').append(link)[0];
    }).hide().insertAfter('.pr-toolbar.js-sticky');

    const oneFileDiffBtn = $('<button type="button" id="one-file-diff-btn"/>')
      .addClass('epr btn-link muted-link select-menu-button')
      .html('<strong>One-File Diff</strong> ')
      .click(() => diffLinks.slideToggle(100));
    $('<div class="epr diffbar-item"/>')
      .append(oneFileDiffBtn)
      .prependTo('.diffbar');

    const file = new URLSearchParams(location.search.slice(1)).get('eprFocus');
    if (!file) return;
    const fileHeader = $(`div[data-path="${escape(file)}"]`)[0];
    if (!fileHeader) return;

    const [blank, owner, repo, pull, prNumber] = location.pathname.split('/');
    document.title = `${file} - ${owner}/${repo} #${prNumber}`;

    $('.file.js-details-container').each(function () {
      if (!$.contains(this, fileHeader)) {
        this.style.display = 'none';
      }
    });
  }
};

EnhancedPullRequest.register_cb(EnhancedPullRequest.oneFileDiff.load);
