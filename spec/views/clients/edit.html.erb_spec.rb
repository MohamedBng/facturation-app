require 'rails_helper'

RSpec.describe "clients/edit", type: :view do
  let(:client) {
    Client.create!(
      nom_complet: "MyString",
      adresse: "MyString",
      ville: "MyString",
      code_postal: "MyString",
      num_siret: "MyString"
    )
  }

  before(:each) do
    assign(:client, client)
  end

  it "renders the edit client form" do
    render

    assert_select "form[action=?][method=?]", client_path(client), "post" do

      assert_select "input[name=?]", "client[nom_complet]"

      assert_select "input[name=?]", "client[adresse]"

      assert_select "input[name=?]", "client[ville]"

      assert_select "input[name=?]", "client[code_postal]"

      assert_select "input[name=?]", "client[num_siret]"
    end
  end
end
