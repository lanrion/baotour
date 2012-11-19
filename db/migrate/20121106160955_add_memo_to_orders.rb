class AddMemoToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :memo, :string, :limit=>200
  end
end
