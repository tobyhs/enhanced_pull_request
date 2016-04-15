require 'spec_helper'
require 'support/line_comment_replies_shared_examples'

RSpec.describe 'Files changed page' do
  let(:driver) { EprSpecHelper.driver }
  let(:pr_url) do
    'https://github.com/tobyhs/enhanced_pull_request/pull/1/files'
  end

  before do
    driver.get(pr_url) unless driver.current_url == pr_url
  end

  it_behaves_like 'a page with line comment replies'

  context 'after clicking a one-file diff link' do
    before do
      driver.find_element(:id, 'one-file-diff-btn').click
      link = "#{pr_url}?eprFocus=sandbox/hello.rb"
      driver.find_element(:css, %(a[href="#{link}"])).click
    end

    it 'has a title with the file name' do
      Selenium::WebDriver::Wait.new(
        message: 'Title does not contain the file name'
      ).until { driver.title.start_with?('sandbox/hello.rb') }
    end

    it 'only shows the diff of the selected file' do
      Selenium::WebDriver::Wait.new.until do
        !driver.
          find_element(:css, '.file-header[data-path="sandbox/hello.py"]').
          displayed?
      end
      expect(
        driver.find_element(:css, '.file-header[data-path="sandbox/hello.rb"]')
      ).to be_displayed
    end
  end
end
