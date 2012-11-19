#coding: utf-8
class ChangeHotelLedgersType < ActiveRecord::Migration

	def change
		remove_column :hotel_ledgers, :date
    change_table :hotel_ledgers do |t|  
      #t.change :remain, :float
      #t.change :used, :float 
      #t.change :amount, :float
     # t.change :refund_state, :boolean, :default => false 
      t.change :rooms, :string, :null => true
      t.change :night, :integer, :default => 0 
      t.change :cosumption, :integer, :default => 0
      t.change :credit, :integer, :default => 0
      t.change :add_amount, :integer, :default => 0
      #t.change :remain, :integer, :default => false       
    end 
    
    #change_table :refunds do |t|
    	#t.change :amount, :float
    #end 
	end

end
