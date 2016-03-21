RSpec.shared_examples 'a page with line comment replies' do
  context 'when clicking on the reply icon of a line comment', reply: true do
    let(:comment_field) do
      # Sometimes there is more than one textarea with the same id
      driver.find_elements(
        css: "textarea[id$='_diff-780594414fe50c0ffbb11dfe104c53e4_1']"
      ).find(&:displayed?)
    end

    before do
      driver.find_element(css: "div[id$='r55945068'] .epr-reply-button").click
    end

    it 'fills in a new comment field with quoted text' do
      expect(comment_field.attribute('value')).to eq(
        "\n\n> Mac still doesn't come with Python 3"
      )
    end

    it 'focuses on the newly opened comment field' do
      expect(comment_field).to eq(driver.switch_to.active_element)
    end
  end
end
