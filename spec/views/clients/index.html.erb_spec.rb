require 'rails_helper'

RSpec.describe "clients/index", type: :view do
  before(:each) do
    assign(:clients, [
      Client.create!(
        nom_complet: "Nom Complet",
        adresse: "Adresse",
        ville: "Ville",
        code_postal: "Code Postal",
        num_siret: "Num Siret"
      ),
      Client.create!(
        nom_complet: "Nom Complet",
        adresse: "Adresse",
        ville: "Ville",
        code_postal: "Code Postal",
        num_siret: "Num Siret"
      )
    ])
  end

  it "renders a list of clients" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Nom Complet".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Adresse".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Ville".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Code Postal".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Num Siret".to_s), count: 2
  end
end
