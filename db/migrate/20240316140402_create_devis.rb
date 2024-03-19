class CreateDevis < ActiveRecord::Migration[7.1]
  def change
    create_table :devis do |t|
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
