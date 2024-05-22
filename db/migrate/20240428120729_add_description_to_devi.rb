class AddDescriptionToDevi < ActiveRecord::Migration[7.1]
  def change
    add_column :devis, :description, :text
  end
end
