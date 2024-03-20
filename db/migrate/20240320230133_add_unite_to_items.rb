class AddUniteToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :unite, :string
  end
end
