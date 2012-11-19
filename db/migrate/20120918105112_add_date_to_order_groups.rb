class AddDateToOrderGroups < ActiveRecord::Migration
  def change
    add_column :order_groups, :date, :date, :null => false
  end
end
