class AddDefaultToTvaDevis < ActiveRecord::Migration[7.1]
  def change
    change_column_default :devis, :tva, from: nil, to: 0.0
  end
end
