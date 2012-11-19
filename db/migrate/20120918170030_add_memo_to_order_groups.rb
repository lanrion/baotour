class AddMemoToOrderGroups < ActiveRecord::Migration
  def change
    add_column :order_groups, :memo, :string, :limit => 2000
  end
end
