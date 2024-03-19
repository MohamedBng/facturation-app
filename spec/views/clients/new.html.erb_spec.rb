require 'rails_helper'

RSpec.describe "clients/new", type: :view do
  before(:each) do
    assign(:client, Client.new(
      nom_complet: "MyString",
      adresse: "MyString",
      ville: "MyString",
      code_postal: "MyString",
      num_siret: "MyString"
    ))
  end

  it "renders new client form" do
    render

    assert_select "form[action=?][method=?]", clients_path, "post" do

      assert_select "input[name=?]", "client[nom_complet]"

      assert_select "input[name=?]", "client[adresse]"

      assert_select "input[name=?]", "client[ville]"

      assert_select "input[name=?]", "client[code_postal]"

      assert_select "input[name=?]", "client[num_siret]"
    end
  end
end
