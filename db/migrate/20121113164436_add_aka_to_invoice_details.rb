class AddAkaToInvoiceDetails < ActiveRecord::Migration
  def change
    add_column :invoice_details, :aka, :string
    add_column :invoice_details, :project, :string
    add_column :invoice_details, :memo, :string
  end
end
