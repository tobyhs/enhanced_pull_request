require 'spec_helper'

RSpec.describe 'Files changed page' do
  let(:driver) { EprSpecHelper.driver }
  let(:pr_url) do
    'https://github.com/tobyhs/enhanced_pull_request/pull/1/files'
  end

  before do
    driver.get(pr_url) unless driver.current_url == pr_url
  end

  it 'has one-file diff links' do
    unless driver.find_element(:class, 'epr-one-file-diff').displayed?
      driver.find_element(:id, 'one-file-diff-btn').click
    end
    link = "#{pr_url}#eprFocus=sandbox/hello.rb"
    Selenium::WebDriver::Wait.new.until do
      driver.find_element(:css, %(a[href="#{link}"])).displayed?
    end
  end

  context 'on a one-file diff page' do
    let(:file) { 'sandbox/hello.rb' }

    let(:pr_url) do
      'https://github.com/tobyhs/enhanced_pull_request/pull/1/files' \
        "#eprFocus=#{file}"
    end

    it 'has a title with the file name' do
      Selenium::WebDriver::Wait.new(
        message: 'Title does not contain the file name'
      ).until { driver.title.start_with?(file) }
    end

    it 'only shows the diff of the selected file' do
      Selenium::WebDriver::Wait.new.until do
        !driver.
          find_element(:css, '.file-header[data-path="sandbox/hello.py"]').
          displayed?
      end

      expect(
        driver.find_element(:css, %(.file-header[data-path="#{file}"]))
      ).to be_displayed
    end

    context 'after clicking a one-file diff link of another file' do
      before do
        driver.find_element(:id, 'one-file-diff-btn').click
        url = "#{pr_url.sub(/#.*/, '')}#eprFocus=sandbox/hello.py"
        link = driver.find_element(:css, %(a[href="#{url}"]))
        Selenium::WebDriver::Wait.new.until { link.displayed? }
        link.click
      end

      it 'only shows the diff of the selected file' do
        Selenium::WebDriver::Wait.new.until do
          !driver.
            find_element(:css, '.file-header[data-path="sandbox/hello.rb"]').
            displayed?
        end

        expect(
          driver.find_element(
            :css,
            %(.file-header[data-path="sandbox/hello.py"]),
          )
        ).to be_displayed
      end
    end
  end
end
