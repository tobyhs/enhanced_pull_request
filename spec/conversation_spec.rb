require 'spec_helper'

RSpec.describe 'Conversation page' do
  let(:driver) { EprSpecHelper.driver }

  before do
    pr_url = 'https://github.com/tobyhs/enhanced_pull_request/pull/1'
    driver.get(pr_url) unless driver.current_url == pr_url
  end

  context 'when clicking on the Outdated Diff Comments buttons' do
    it 'shows and hides the comments on the outdated diffs' do
      driver.find_element(:class, 'epr-show-outdated-comments').click
      outdated_comment = nil
      Selenium::WebDriver::Wait.new.until do
        outdated_comment = driver.find_element(:id, 'discussion_r84420650')
      end
      expect(outdated_comment).to be_displayed

      driver.find_element(:class, 'epr-hide-outdated-comments').click
      expect(outdated_comment).not_to be_displayed
    end
  end
end
