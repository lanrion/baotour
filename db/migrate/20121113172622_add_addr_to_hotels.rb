class AddAddrToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :addr, :string
    add_column :hotels, :telephone ,:string
    add_column :hotels, :fax ,:string
    add_column :hotels, :sell_tel ,:string
    add_column :hotels, :contact_name ,:string
    add_column :hotels, :contact_tel ,:string            
  end
end

