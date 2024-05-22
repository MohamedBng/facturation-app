require 'rails_helper'

RSpec.describe 'Gestion des devis', type: :system do
  before do
    @user = create(:user)
    @provider = create(:provider, user: @user)
    @client = create(:client, user: @user)
    sign_in @user
  end

  it 'permet d’ajouter un item et enregistre toutes les valeurs' do
    visit new_admin_devi_path

    select @provider.name, from: 'Prestataire'
    select @client.nom_complet, from: 'Client'
    fill_in 'Lieu d\'intervention', with: 'Site A'
    select 'Taux Uniforme', from: 'Type d\'application de la TVA'
    # fill_in 'Date de création', with: Date.today
    # fill_in 'Date de validité', with: Date.today + 1.month
    # fill_in 'Date de début du service', with: Date.today + 1.week

    click_on 'Ajouter un item'
    within all('.nested-fields').last do
      fill_in_rich_text_area('message_content', with: 'Hello <em>world!</em>')
      fill_in 'Quantite', with: 5
      fill_in 'Unite', with: 'Heures'
      fill_in 'Prix unitaire (HT)', with: '100.0'
      check 'Exonération de TVA'
      fill_in 'TVA (%)', with: '20'
    end

    click_on 'Envoyer'

    devi = Devi.last
    expect(devi.items.count).to eq(1)
    item = devi.items.first
    expect(item.detail).to eq('Service A')
    expect(item.quantite).to eq(5)
    expect(item.unite).to eq('Heures')
    expect(item.price).to eq(100.0)
    expect(item.exempt_tva).to be true
    expect(item.tva).to eq(20)
  end
end
