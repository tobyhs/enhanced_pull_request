# Enhanced Pull Request

Chrome Web Store URL:
https://chrome.google.com/webstore/detail/enhanced-pull-request/pnepdakkbfhmgjhdfhgdkpjpjgfnnabl

This is a Chrome extension that adds features (that I have been spoiled with
from other code review tools) to GitHub Pull Requests.


# Features

* Link to show/hide all comments on outdated diffs in Conversation ("Toggle
  Outdated Diff Comments" link below the "Conversation" tab)
* Replies to emulate conversation threading (reply icon on the right side of a
  comment header)
* See the diff of one file in one window as opposed to all changes in one
  window ("One-File Diff" link below the tab bar)
* Give approval comments (like "lgtm") a green background


# Development

Install Node.js and this project's dependencies (run `npm install` from the
project root). Then, install bower dependencies with `node_modules/.bin/bower
install`.


# Tests

See [spec/README.md](https://github.com/tobyhs/enhanced_pull_request/blob/master/spec/README.md).
