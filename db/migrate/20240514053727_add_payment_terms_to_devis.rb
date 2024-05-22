class AddPaymentTermsToDevis < ActiveRecord::Migration[7.1]
  def change
    add_column :devis, :payment_terms, :text
  end
end
