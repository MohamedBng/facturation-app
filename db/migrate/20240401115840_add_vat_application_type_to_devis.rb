class AddVatApplicationTypeToDevis < ActiveRecord::Migration[7.1]
  def change
    add_column :devis, :vat_application_type, :integer
    remove_column :devis, :liquidation_tva, :boolean
  end
end
