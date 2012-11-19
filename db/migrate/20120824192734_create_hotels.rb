class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels, :options => 'DEFAULT CHARSET=utf8' do |t|
      t.string :name,   :null => false
      t.string :credit, :null => false
      t.timestamps
    end
  end
end
