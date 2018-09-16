require 'spec_helper'

RSpec.describe 'Conversation page' do
  let(:driver) { EprSpecHelper.driver }

  before do
    pr_url = 'https://github.com/tobyhs/enhanced_pull_request/pull/1'
    driver.get(pr_url) unless driver.current_url == pr_url
  end

  context 'when clicking on the Outdated Diff Comments buttons' do
    it 'shows and hides the comments on the outdated diffs' do
      outdated_comments = driver.find_elements(:css, '#r55944545, #discussion_r84420650')

      [
        ['epr-show-outdated-comments', true],
        ['epr-hide-outdated-comments', false],
      ].each do |class_name, displayed|
        expect {
          driver.find_element(:class, class_name).click
        }.to change {
          outdated_comments.map(&:displayed?).uniq
        }.from([!displayed]).to([displayed])
      end
    end
  end
end
