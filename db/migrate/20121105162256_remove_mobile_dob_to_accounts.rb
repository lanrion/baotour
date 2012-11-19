#coding: utf-8
class RemoveMobileDobToAccounts < ActiveRecord::Migration
	def change
		remove_column :accounts, :mobile
		remove_column :accounts, :DOB
		add_column :accounts, :bank, :string, :limit=>200, :null => false
		add_column :accounts, :acc, :string, :limit => 200, :null => false
	end

end
