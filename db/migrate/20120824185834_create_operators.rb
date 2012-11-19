class CreateOperators < ActiveRecord::Migration
  def change
    create_table :operators, :options => 'DEFAULT CHARSET=utf8' do |t|
      t.references :customer,   :null => false
      t.string :name,           :null => false
      t.string :mobile,         :null => false
      t.date :DOB
      t.timestamps
    end
    add_index :operators, :customer_id
  end
end
