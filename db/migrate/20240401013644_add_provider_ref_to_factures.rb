class AddProviderRefToFactures < ActiveRecord::Migration[7.1]
  def change
    add_reference :factures, :provider, null: false, foreign_key: true
  end
end
