class AddFactureRefToItems < ActiveRecord::Migration[7.1]
  def change
    change_column_null :items, :devi_id, true
    add_reference :items, :facture, foreign_key: true
  end
end
