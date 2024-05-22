class AddPaidToDevis < ActiveRecord::Migration[7.1]
  def change
    add_column :devis, :paid, :boolean, default: false, null: false
  end
end
