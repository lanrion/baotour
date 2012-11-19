class AddTitleToInvoiceDetails < ActiveRecord::Migration
  def change
    add_column :invoice_details, :title, :string, :limit=>200, :null => false
  end
end
