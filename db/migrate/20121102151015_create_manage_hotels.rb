class CreateManageHotels < ActiveRecord::Migration
  def change
    create_table :manage_hotels, :options => 'DEFAULT CHARSET=utf8' do |t|
      t.references :user, :null => false
      t.references :hotel, :null => false
      t.string :creator, :null => false
      t.timestamps
    end
    add_index :manage_hotels, :user_id
    add_index :manage_hotels, :hotel_id
  end
end
