require 'spec_helper'

RSpec.describe 'Conversation page' do
  let(:driver) { EprSpecHelper.driver }

  before do
    pr_url = 'https://github.com/tobyhs/enhanced_pull_request/pull/1'
    driver.get(pr_url) unless driver.current_url == pr_url
  end

  context 'when clicking on the .epr-toggle-outdated-comments button' do
    it 'shows the comments on the outdated diffs' do
      outdated_comments = driver.find_elements(
        css: '#discussion_r55944516, #discussion_r55944545'
      )

      expect {
        driver.find_element(:class => 'epr-toggle-outdated-comments').click
      }.to change {
        outdated_comments.map(&:displayed?)
      }.from([false, false]).to([true, true])
    end
  end
end
