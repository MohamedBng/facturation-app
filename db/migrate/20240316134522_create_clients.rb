class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string :nom_complet
      t.string :adresse
      t.string :ville
      t.string :code_postal
      t.string :num_siret

      t.timestamps
    end
  end
end
