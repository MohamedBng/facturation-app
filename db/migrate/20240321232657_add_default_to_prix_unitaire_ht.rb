class AddDefaultToPrixUnitaireHt < ActiveRecord::Migration[7.1]
  def change
    change_column :items, :prix_unitaire_ht, :string, default: "0,0"
  end
end
