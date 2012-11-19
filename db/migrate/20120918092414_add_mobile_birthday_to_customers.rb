class AddMobileBirthdayToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :mobile, :string, :limit=>20, :null => true
    add_column :customers, :dob, :date,  :null => true
  end
end
