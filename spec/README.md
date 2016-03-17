# Tests

You will need Ruby and bundler to run tests. Install gem dependencies by
running `bundle install` from the project root. Make sure `chromedriver` is in
your PATH (so selenium-webdriver can use it).

Create a spec/config.yml file with credentials of a GitHub account to use for
running tests; it will look like:
```yaml
login: test-account
password: test-password
```

Then, run `bundle exec rspec`.
