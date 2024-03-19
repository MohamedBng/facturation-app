require 'rails_helper'

RSpec.describe "devis/new", type: :view do
  before(:each) do
    assign(:devi, Devi.new(
      client: nil
    ))
  end

  it "renders new devi form" do
    render

    assert_select "form[action=?][method=?]", devis_path, "post" do

      assert_select "input[name=?]", "devi[client_id]"
    end
  end
end
