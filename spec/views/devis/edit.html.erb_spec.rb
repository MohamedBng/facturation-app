require 'rails_helper'

RSpec.describe "devis/edit", type: :view do
  let(:devi) {
    Devi.create!(
      client: nil
    )
  }

  before(:each) do
    assign(:devi, devi)
  end

  it "renders the edit devi form" do
    render

    assert_select "form[action=?][method=?]", devi_path(devi), "post" do

      assert_select "input[name=?]", "devi[client_id]"
    end
  end
end
