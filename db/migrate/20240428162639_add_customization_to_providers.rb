class AddCustomizationToProviders < ActiveRecord::Migration[7.1]
  def change
    add_column :providers, :primary_color, :string, default: '#009688'
    add_column :providers, :secondary_color, :string, default: '#00796B'
    add_column :providers, :background_color, :string, default: '#FFFFFF'
    add_column :providers, :text_color, :string, default: '#333333'
  end
end
