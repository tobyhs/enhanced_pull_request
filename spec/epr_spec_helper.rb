require 'selenium-webdriver'
require 'yaml'

# Utility methods for tests
module EprSpecHelper
  # @return [Selenium::WebDriver::Driver]
  #   Chrome driver instance with the enhanced_pull_request extension loaded
  def self.driver
    @driver ||= Selenium::WebDriver.for(
      :chrome, args: ["--load-extension=#{File.join(__dir__, '..')}"]
    )
  end

  # Logs into GitHub.
  def self.login
    driver.get('https://github.com/login')

    driver.find_element(name: 'login').send_keys(config['login'])
    password_field = EprSpecHelper.driver.find_element(name: 'password')
    password_field.send_keys(config['password'])
    password_field.submit
  end

  # Logs out of GitHub.
  #
  # @note This assumes the driver is on a page with the avatar dropdown menu
  def self.logout
    driver.find_element(css: '.header-nav-link .avatar').click
    driver.find_element(:class => 'logout-form').click
  end

  # @return [Hash{String => Object}] GitHub credentials for testing
  def self.config
    @config ||= YAML.load_file(File.join(__dir__, 'config.yml'))
  end
end
