class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers, :options => 'DEFAULT CHARSET=utf8' do |t|
      t.references :hotel,    :null => false
      t.date  :date,          :null => false
      t.string :out_bank,     :null => false
      t.string :out_account,  :null => false
      t.string :in_bank,      :null => false
      t.string :in_account,   :null => false
      t.integer :amount,      :null => false
      t.string  :memo
      t.string  :by,          :null => false
      t.boolean :confirm,     :null => false, :default => false
      t.string :creator,      :null => false
      t.timestamps
    end
    add_index :transfers, :hotel_id
  end
end
