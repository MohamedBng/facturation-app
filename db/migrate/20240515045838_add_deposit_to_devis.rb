class AddDepositToDevis < ActiveRecord::Migration[7.1]
  def change
    add_column :devis, :deposit, :integer
  end
end
