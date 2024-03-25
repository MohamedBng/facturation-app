class ChangeNameLogoToProviders < ActiveRecord::Migration[7.1]
  def change
    rename_column :providers, :logo, :logo_data
  end
end
