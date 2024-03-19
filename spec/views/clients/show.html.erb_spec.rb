require 'rails_helper'

RSpec.describe "clients/show", type: :view do
  before(:each) do
    assign(:client, Client.create!(
      nom_complet: "Nom Complet",
      adresse: "Adresse",
      ville: "Ville",
      code_postal: "Code Postal",
      num_siret: "Num Siret"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nom Complet/)
    expect(rendered).to match(/Adresse/)
    expect(rendered).to match(/Ville/)
    expect(rendered).to match(/Code Postal/)
    expect(rendered).to match(/Num Siret/)
  end
end
