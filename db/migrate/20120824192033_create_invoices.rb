class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices, :options => 'DEFAULT CHARSET=utf8' do |t|
      t.references :customer, :null => false
      t.integer    :issued,   :null => false
      t.integer    :remain,   :null => false
    end
  end
end
