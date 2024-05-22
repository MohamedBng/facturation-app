class AddDurationAndUnitToServices < ActiveRecord::Migration[7.1]
  def change
    add_column :devis, :estimated_duration, :integer
    add_column :devis, :duration_unit, :integer
  end
end
