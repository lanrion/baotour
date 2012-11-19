#coding: utf-8
class ChangeTransDefault < ActiveRecord::Migration

	def change
    change_table :transactions do |t|  
      #t.change :remain, :float
      #t.change :used, :float 
      #t.change :amount, :float
     # t.change :refund_state, :boolean, :default => false 
      t.change :used, :integer, :default => 0 
      #t.change :remain, :integer, :default => false       
    end 
    
    #change_table :refunds do |t|
    	#t.change :amount, :float
    #end 
	end

end
