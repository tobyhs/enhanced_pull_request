require 'selenium-webdriver'
require 'yaml'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.disable_monkey_patching!

  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.order = :random

  # selenium-webdriver is noisy
  config.warnings = false

  gh_config = YAML.load_file(File.join(__dir__, 'config.yml'))

  config.before :context do
    @driver = Selenium::WebDriver.for(
      :chrome, args: ["--load-extension=#{File.join(__dir__, '..')}"]
    )

    @driver.get('https://github.com/login')
    @driver.find_element(name: 'login').send_keys(gh_config['login'])
    password_field = @driver.find_element(name: 'password')
    password_field.send_keys(gh_config['password'])
    password_field.submit
  end

  config.after :context do
    @driver.find_element(css: '.header-nav-link .avatar').click
    @driver.find_element(class: 'logout-form').click

    @driver.quit
  end
end
