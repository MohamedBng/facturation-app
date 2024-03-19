require 'rails_helper'

RSpec.describe "devis/show", type: :view do
  before(:each) do
    assign(:devi, Devi.create!(
      client: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
