class AddProviderRefToDevis < ActiveRecord::Migration[7.1]
  def change
    add_reference :devis, :provider, null: false, foreign_key: true
  end
end
