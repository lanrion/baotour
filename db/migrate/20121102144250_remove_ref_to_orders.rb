class RemoveRefToOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :ref
  end
end
