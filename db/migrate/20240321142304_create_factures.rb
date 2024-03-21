class CreateFactures < ActiveRecord::Migration[7.1]
  def change
    create_table :factures do |t|
      t.references :client, null: false, foreign_key: true
      t.decimal :tva
      t.integer :status, default: 0
      t.boolean :liquidation_tva, default: false

      t.timestamps
    end
  end
end
