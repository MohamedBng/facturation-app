class AddTvaToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :tva, :decimal, precision: 5, scale: 2, default: 0.0
    add_column :items, :exempt_tva, :boolean, default: false
  end
end
