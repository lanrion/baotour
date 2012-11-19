#encoding: utf-8
class FundUsagesController < ApplicationController
	protect_from_forgery :except => [:index, :destroy]
	
	load_and_authorize_resource :only => [:index, :destroy]

	def index
		customer_id = params[:customer_id]
		order_id = params[:order_id]
		@fusages = FundUsage.where(:customer_id => customer_id, :order_id => order_id, :done => false)
												.order("created_at desc")
												
		@order = Order.find(params[:order_id])
		new_json = {
						"order_data" => @order.as_json(:only => [:coverd_amount,:uncoverd_amount]),
						"fusage_data" => @fusages.as_json(:only =>[:id, :usage_amount, :creator, :created_at, :transaction_id])
					}
							
		respond_to do |format|
			format.json {render :json => new_json}
			format.html {render "index"}
		end
	end

	def destroy
		@fusage = FundUsage.find(params[:id])
		#删除后先还原transaction数据，再更新order的coverd
	 	ActiveRecord::Base.transaction do	
			if @fusage.destroy
			#
				ActiveRecord::Base
					.connection.execute("UPDATE transactions SET transactions.used = (transactions.used - #{@fusage.usage_amount}), transactions.remain = (transactions.remain+#{@fusage.usage_amount}) WHERE transactions.id = '#{@fusage.transaction_id }'")
			
				 #更新订单值
		 		ActiveRecord::Base
		 			.connection.execute("UPDATE orders SET orders.coverd_amount = (orders.coverd_amount - #{@fusage.usage_amount}), orders.all_coverd=0 ,orders.uncoverd_amount=(orders.uncoverd_amount+#{@fusage.usage_amount}) WHERE orders.id='#{@fusage.order_id}'")			
				
			end
		
			@order = Order.find(@fusage.order_id)
			@tran = Transaction.find_by_id(@fusage.transaction_id)
		
			new_json = { :id => @fusage.id, 
									 :uncoverd_amount => @order.uncoverd_amount, 
									 :coverd_amount => @order.coverd_amount,
									 :used => @tran.used,
									 :remain => @tran.remain,
									 :tran_id => @tran.id,
									 :order_id => @order.id
									 }
		
			respond_to do |format|
				format.json {render :json => new_json}
			end
		end	
	end
	
end
