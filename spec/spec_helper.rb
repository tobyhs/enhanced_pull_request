require 'epr_spec_helper'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.disable_monkey_patching!

  # selenium-webdriver is noisy
  config.warnings = false

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.order = :random

  config.before :suite do
    EprSpecHelper.login
  end

  config.after :suite do
    EprSpecHelper.logout
    EprSpecHelper.driver.quit
  end
end
