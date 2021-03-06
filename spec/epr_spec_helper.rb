require 'selenium-webdriver'
require 'yaml'

# Utility methods for tests
module EprSpecHelper
  # @note
  #   I know, a singleton might be improper, but I didn't want tests to perform
  #   too many logins and logouts in case GitHub finds this activity
  #   suspicious.
  #
  # @return [Selenium::WebDriver::Driver]
  #   Chrome driver instance with the enhanced_pull_request extension loaded
  def self.driver
    @driver ||=
      begin
        options = Selenium::WebDriver::Chrome::Options.new(
          args: ["--load-extension=#{File.join(__dir__, '..')}"]
        )
        Selenium::WebDriver.for(:chrome, options: options)
      end
  end

  # Logs into GitHub.
  def self.login
    driver.get('https://github.com/login')

    driver.find_element(:name, 'login').send_keys(config['login'])
    password_field = EprSpecHelper.driver.find_element(:name, 'password')
    password_field.send_keys(config['password'])
    password_field.submit
  end

  # Logs out of GitHub.
  #
  # @note This assumes the driver is on a page with the avatar dropdown menu
  def self.logout
    selector = 'summary[aria-label*="View profile"]'
    avatar_icon = driver.find_element(:css, selector)
    avatar_icon.location_once_scrolled_into_view
    avatar_icon.click
    driver.find_element(:class, 'logout-form').click
  end

  # @return [Hash{String => Object}] GitHub credentials for testing
  def self.config
    @config ||= YAML.load_file(File.join(__dir__, 'config.yml'))
  end
end
