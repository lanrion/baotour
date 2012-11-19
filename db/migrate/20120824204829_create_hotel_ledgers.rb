class CreateHotelLedgers < ActiveRecord::Migration
  def change
    create_table :hotel_ledgers, :options => 'DEFAULT CHARSET=utf8' do |t|
      t.references :hotel,        :null => false
      t.references :order_group
      t.references :transfer
      t.date :date,               :null => false
      t.string :rooms,            :null => false
      t.integer :night,           :null => false
      t.integer :cosumption,      :null => false
      t.integer :credit,          :null => false
      t.integer :add_amount,      :null => false
      t.timestamps
    end
    add_index :hotel_ledgers, :hotel_id
    add_index :hotel_ledgers, :order_group_id
  end
end
