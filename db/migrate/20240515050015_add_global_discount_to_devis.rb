class AddGlobalDiscountToDevis < ActiveRecord::Migration[7.1]
  def change
    add_column :devis, :global_discount_price, :integer
    add_column :devis, :global_discount_percent, :integer
  end
end
