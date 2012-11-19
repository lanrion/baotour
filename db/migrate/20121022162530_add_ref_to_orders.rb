class AddRefToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :ref, :string, :limit=>20, :null => false
  end
end
