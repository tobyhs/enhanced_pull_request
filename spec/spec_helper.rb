require 'yaml'

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

  gh_config = YAML.load_file(File.join(__dir__, 'config.yml'))

  config.before :suite do
    EprSpecHelper.driver.get('https://github.com/login')

    EprSpecHelper.driver.find_element(name: 'login').
      send_keys(gh_config['login'])
    password_field = EprSpecHelper.driver.find_element(name: 'password')
    password_field.send_keys(gh_config['password'])
    password_field.submit
  end

  config.after :suite do
    EprSpecHelper.driver.find_element(css: '.header-nav-link .avatar').click
    EprSpecHelper.driver.find_element(class: 'logout-form').click

    EprSpecHelper.driver.quit
  end
end
