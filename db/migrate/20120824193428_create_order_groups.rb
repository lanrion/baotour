#coding: utf-8
class CreateOrderGroups < ActiveRecord::Migration
  def change
    create_table :order_groups, :options => 'DEFAULT CHARSET=utf8' do |t|
      t.references :hotel,  :null => false
      t.string    :ref,     :null => false
      t.string    :day_1
      t.string    :day_2    
      t.string    :day_3    
      t.string    :dinner
      t.string    :fee,     :null => false
      t.integer   :sum,     :null => false
      t.integer   :night,   :null => false
      t.boolean   :done,		:default => false
      
      t.timestamps
    end
    add_index :order_groups, :hotel_id
  end
end
