#coding: utf-8
class ChangeDateName < ActiveRecord::Migration

	def change
    change_table :orders do |t|  
      #t.change :remain, :float
      #t.change :used, :float 
      #t.change :amount, :float
     # t.change :refund_state, :boolean, :default => false 
      t.change :date, :integer, :null => false
    end 
    
    #change_table :refunds do |t|
    	#t.change :amount, :float
    #end 
	end

end
