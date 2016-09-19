require 'spec_helper'
require 'support/line_comment_replies_shared_examples'

RSpec.describe 'Conversation page' do
  let(:driver) { EprSpecHelper.driver }

  before do
    pr_url = 'https://github.com/tobyhs/enhanced_pull_request/pull/1'
    driver.get(pr_url) unless driver.current_url == pr_url
  end

  context 'when clicking on the Outdated Diff Comments buttons' do
    it 'shows and hides the comments on the outdated diffs' do
      outdated_comments = driver.find_elements(:css, '#r55944516, #r55944545')

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

  context 'when clicking on the reply icon of an issue comment', reply: true do
    let(:comment_field) { driver.find_element(:id, 'new_comment_field') }

    before do
      driver.
        find_element(:css, '#issuecomment-196083866 .epr-reply-button').click
    end

    it 'fills in the new comment field with quoted text' do
      expect(comment_field.attribute('value')).to eq(
        "\n\n> Fake self-reply @tobyhs\n> \n> > Original :+1:"
      )
    end

    it 'focuses on the new comment field' do
      expect(comment_field).to eq(driver.switch_to.active_element)
    end
  end

  context 'on an issue comment with an approval message' do
    let(:green) { 'rgba(153, 255, 153, 1)' }

    context 'when the comment author is the pull request opener' do
      it 'does not have a green background' do
        comment_body = driver.find_element(
          :css, '#issuecomment-196083866 .js-comment-body'
        )
        bg_color = comment_body.css_value('background-color')
        expect(bg_color).not_to eq(green)
      end
    end

    context 'when the comment author is not the pull request opener' do
      it 'has a green background' do
        comment_body = driver.find_element(
          :css, '#issuecomment-236418593 .js-comment-body'
        )
        bg_color = comment_body.css_value('background-color')
        expect(bg_color).to eq(green)
      end
    end
  end

  it_behaves_like 'a page with line comment replies'
end
