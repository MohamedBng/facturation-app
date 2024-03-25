class CreateProviders < ActiveRecord::Migration[7.1]
  def change
    create_table :providers do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :postal_code
      t.string :num_siret
      t.jsonb :logo

      t.timestamps
    end
  end
end
