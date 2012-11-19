class CreateCustomers < ActiveRecord::Migration
  def change
    create_table(:customers,:options => 'DEFAULT CHARSET=utf8') do |t|
      t.string :vip,      :null => false
      t.string :name,     :null => false
      t.string :aka,      :null => false
      t.string :fax   
      t.string :addr,     :limit => 2000
      t.string :manager,  :null => false
      t.string :tel,      :null => false
      t.integer :credit,  :null => false, :default => 0
      t.timestamps
    end
  end
end
