class AddStartingInvoiceNumberToProviders < ActiveRecord::Migration[7.1]
  def change
    add_column :providers, :starting_invoice_number, :integer, default: 1
  end
end
