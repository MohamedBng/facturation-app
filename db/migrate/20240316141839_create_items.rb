class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.references :devi, null: false, foreign_key: true
      t.text :detail
      t.integer :quantite
      t.integer :prix_unitaire_ht
      t.integer :total_ht

      t.timestamps
    end
  end
end
