# Enhanced Pull Request

Chrome Web Store URL:
https://chrome.google.com/webstore/detail/enhanced-pull-request/pnepdakkbfhmgjhdfhgdkpjpjgfnnabl

This is an attempt at a Chrome extension to add features (that I have been
spoiled with from other code review tools) to GitHub Pull Requests.


# Features

* Link to show/hide all comments on outdated diffs in Conversation ("Toggle
  Outdated Diff Comments" link below the "Conversation" tab)
* Replies to emulate conversation threading (reply icon on the right side of a
  comment header)


# Development

Install Node.js and this project's dependencies (run `npm install` from the
project root). Then, install bower dependencies with `node_modules/.bin/bower
install`.


# Tests

See [spec/README.md](https://github.com/tobyhs/enhanced_pull_request/blob/master/spec/README.md).
