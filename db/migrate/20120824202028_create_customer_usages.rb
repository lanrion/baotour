class CreateCustomerUsages < ActiveRecord::Migration
  def change
    create_table :customer_usages, :options => 'DEFAULT CHARSET=utf8' do |t|
      t.references :customer, :null => false
      t.references :order,    :null => false
      t.references :hotel,    :null => false
      t.integer    :remain
      t.integer    :cosume,   :null => false
      t.date       :date,     :null => false

      t.timestamps
    end
    add_index :customer_usages, :customer_id
    add_index :customer_usages, :order_id
    add_index :customer_usages, :hotel_id
  end
end
