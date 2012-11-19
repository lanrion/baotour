class CreateRefunds < ActiveRecord::Migration
  def change
    create_table :refunds,:options => 'DEFAULT CHARSET=utf8' do |t|
      t.references :transaction, :null => false
      t.integer :amount,         :null => false
      t.date    :at,             :null => false
      t.string  :doc_ref,        :null => false
      t.timestamps
    end
    add_index :refunds, :transaction_id
  end
end
