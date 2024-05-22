class AddInterventionLocationToDevis < ActiveRecord::Migration[7.1]
  def change
    add_column :devis, :intervention_location, :string
  end
end
