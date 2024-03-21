class AddStatusToDevis < ActiveRecord::Migration[7.1]
  def change
    add_column :devis, :status, :integer, default: 0
  end
end
