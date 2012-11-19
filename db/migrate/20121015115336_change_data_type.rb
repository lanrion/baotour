#coding: utf-8
class ChangeDataType < ActiveRecord::Migration

	def change
    change_table :transactions do |t|  
      #t.change :remain, :float
      #t.change :used, :float 
      #t.change :amount, :float
      t.change :refund_state, :boolean, :default => false 
    end 
    
    #change_table :refunds do |t|
    	#t.change :amount, :float
    #end 
	end

end
