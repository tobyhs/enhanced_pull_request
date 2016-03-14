// Button/link to show/hide comments on outdated diffs
$('<button type="button">Toggle Outdated Diff Comments</button>')
  .addClass('btn-link epr-toggle-outdated-comments')
  .click(() => $('.discussion-item-toggle-closed').click())
  .prependTo('.pull-discussion-timeline');
