class CreateInvoiceDetails < ActiveRecord::Migration
  def change
    create_table :invoice_details, :options => 'DEFAULT CHARSET=utf8' do |t|
      t.references :invoice,  :null => false
      t.integer   :amount,    :null => false
      t.date      :at,        :null => false
      t.string    :creator,   :null => false
      t.string    :doc_ref,   :null => false
      t.timestamps
    end
    add_index :invoice_details, :invoice_id
  end
end
