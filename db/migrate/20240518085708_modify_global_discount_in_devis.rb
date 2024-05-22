class ModifyGlobalDiscountInDevis < ActiveRecord::Migration[7.1]
  def change
    remove_column :devis, :global_discount_price, :integer
    remove_column :devis, :global_discount_percent, :integer
    add_column :devis, :global_discount, :integer
    add_column :devis, :global_discount_type, :integer
  end
end
