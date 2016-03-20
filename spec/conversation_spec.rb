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

  context 'when clicking on the reply icon of an issue comment', reply: true do
    let(:comment_field) { driver.find_element(id: 'new_comment_field') }

    before do
      driver.
        find_element(css: '#issuecomment-196083866 .epr-reply-button').click
    end

    it 'fills in the new comment field with quoted text' do
      expect(comment_field.attribute('value')).to eq(
        "\n\n> Fake self-reply\n> \n> > Original comment"
      )
    end

    it 'focuses on the new comment field' do
      expect(comment_field).to eq(driver.switch_to.active_element)
    end
  end
end
