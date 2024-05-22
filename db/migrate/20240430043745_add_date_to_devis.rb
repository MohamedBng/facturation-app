class AddDateToDevis < ActiveRecord::Migration[7.1]
  def change
    add_column :devis, :date_of_creation, :date
    add_column :devis, :date_of_validity, :date
    add_column :devis, :start_date_of_service, :date
  end
end
