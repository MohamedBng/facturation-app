class AddTvaToDevis < ActiveRecord::Migration[7.1]
  def change
    add_column :devis, :tva, :decimal
  end
end
