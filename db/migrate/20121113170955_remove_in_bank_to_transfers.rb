class RemoveInBankToTransfers < ActiveRecord::Migration
  def change
    remove_column :transfers, :in_bank
    remove_column :transfers, :in_account
  end
end
