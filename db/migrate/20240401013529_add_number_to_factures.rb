class AddNumberToFactures < ActiveRecord::Migration[7.1]
  def change
    add_column :factures, :number, :string
  end
end
