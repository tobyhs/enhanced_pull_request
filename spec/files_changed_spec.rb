require 'spec_helper'
require 'support/line_comment_replies_shared_examples'

RSpec.describe 'Files changed page' do
  let(:driver) { EprSpecHelper.driver }

  before do
    pr_url = 'https://github.com/tobyhs/enhanced_pull_request/pull/1/files'
    driver.get(pr_url) unless driver.current_url == pr_url
  end

  it_behaves_like 'a page with line comment replies'
end
