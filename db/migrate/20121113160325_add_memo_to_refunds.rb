class AddMemoToRefunds < ActiveRecord::Migration
  def change
    add_column :refunds, :memo, :string
    add_column :refunds, :operator, :string
    add_column :refunds, :sch_hotel, :string
    add_column :refunds, :sch_date, :string
    add_column :refunds, :refund_acc, :string
  end
end
