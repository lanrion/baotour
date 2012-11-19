class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts, :options => 'DEFAULT CHARSET=utf8' do |t|
      t.references :customer,        :null => false
      t.string :name,           :null => false
      t.string :mobile,         :null => false
      t.date :DOB
      t.timestamps
    end
    
    change_table :transactions do |t|
        t.references :account
    end
    
    remove_column :transactions, :recv_bank
  end
end
