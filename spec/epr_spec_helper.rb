require 'selenium-webdriver'

# Utility methods for tests
module EprSpecHelper
  # @return [Selenium::WebDriver::Driver]
  #   Chrome driver instance with the enhanced_pull_request extension loaded
  def self.driver
    @driver ||= Selenium::WebDriver.for(
      :chrome, args: ["--load-extension=#{File.join(__dir__, '..')}"]
    )
  end
end
