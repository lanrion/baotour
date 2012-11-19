class CreateFundUsages < ActiveRecord::Migration
  def change
    create_table :fund_usages, :options => 'DEFAULT CHARSET=utf8' do |t|
      t.references :customer,       :null => false
      t.references :order,          :null => false
      t.references :transaction,    :null => false
      t.references :order_group,    :null => false
      t.integer :usage_amount,      :null => false
      t.boolean :done,              :default => false
      t.string  :creator,           :null => false
      t.timestamps
    end
    add_index :fund_usages, :customer_id
    add_index :fund_usages, :order_id
    add_index :fund_usages, :transaction_id
    add_index :fund_usages, :order_group_id
  end
end
