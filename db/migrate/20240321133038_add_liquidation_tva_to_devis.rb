class AddLiquidationTvaToDevis < ActiveRecord::Migration[7.1]
  def change
    add_column :devis, :liquidation_tva, :boolean, default: false
  end
end
