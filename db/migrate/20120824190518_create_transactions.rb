class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions,:options => 'DEFAULT CHARSET=utf8' do |t|
      t.references :customer, :null => false
      t.string :bank,         :null => false
      t.string :account,      :null => false
      t.string :name,         :null => false
      t.integer :amount,      :null => false
      t.string :recv_bank,    :null => false
      t.string :memo,         :limit => 2000
      t.string :created_by,   :null => false
      t.integer :used
      t.integer :remain
      t.string  :refund_state
      t.date :recv_date,      :null => false
      t.timestamps
    end
    add_index :transactions, :customer_id
  end
end
