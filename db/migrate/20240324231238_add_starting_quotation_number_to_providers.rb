class AddStartingQuotationNumberToProviders < ActiveRecord::Migration[7.1]
  def change
    add_column :providers, :starting_quotation_number, :integer, default: 1
  end
end
