class AddNumberToDevis < ActiveRecord::Migration[7.1]
  def change
    add_column :devis, :number, :string
  end
end
