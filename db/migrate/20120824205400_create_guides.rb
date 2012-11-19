class CreateGuides < ActiveRecord::Migration
  def change
    create_table :guides, :options => 'DEFAULT CHARSET=utf8' do |t|
      t.string :name
      t.timestamps
    end
  end
end
