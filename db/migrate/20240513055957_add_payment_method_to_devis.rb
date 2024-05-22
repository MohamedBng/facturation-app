class AddPaymentMethodToDevis < ActiveRecord::Migration[7.1]
  def change
    add_column :devis, :payment_method_mask, :integer
    add_column :devis, :simple_payment_method, :integer, default: 0
  end
end
