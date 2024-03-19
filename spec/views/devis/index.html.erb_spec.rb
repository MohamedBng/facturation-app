require 'rails_helper'

RSpec.describe "devis/index", type: :view do
  before(:each) do
    assign(:devis, [
      Devi.create!(
        client: nil
      ),
      Devi.create!(
        client: nil
      )
    ])
  end

  it "renders a list of devis" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
