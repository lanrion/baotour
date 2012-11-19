class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders, :options => 'DEFAULT CHARSET=utf8'  do |t|
      t.references :customer,         :null => false
      t.references :order_group,      :null => false
      t.string     :operator,         :null => false
      t.string     :guide,            :null => false
      t.string     :day_1
      t.string     :day_2
      t.string     :day_3
      t.string     :dinner
      t.date       :date,             :null => false
      t.string     :fee,              :null => false
      t.integer    :sum,              :null => false, :default => 0
      t.integer    :coverd_amount,    :null => false, :default => 0
      t.integer    :uncoverd_amount,  :null => false, :default => 0
      t.boolean    :all_coverd
      t.boolean    :done,             :null => false, :default => false
      t.string     :creator,          :null => false
      t.timestamps
    end
    add_index :orders, :customer_id
    add_index :orders, :order_group_id
  end
end
