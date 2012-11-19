#coding: utf-8
class TransactionsController < ApplicationController

	#before_filter :validate_customer, :only => [:create, :update]
	protect_from_forgery :except => [:reduce_cash]
	load_and_authorize_resource :only => [:index,:new,:edit,:create,:update,:destroy, :reduce_cash]
	
	def index
		@trans = Transaction.includes(:customer).order("created_at DESC")
						.paginate(:page => params[:page], :per_page => 20)
	end
	
	def new
		@tran = Transaction.new
	end
	
	def create
		@tran = Transaction.new(params[:transaction])
		@tran.remain = @tran.amount
		@tran.used = 0
		@tran.created_by = current_user.name
		
		if @tran.save
			flash[:notice] = "新建转账记录成功"
			@c = @tran.customer
			@c.update_attribute(:credit, @c.credit.to_i+@tran.amount.to_i)
			redirect_to transactions_path
		else
			flash[:notice] = "新建转账记录异常"
			render action: "new" 
		end
	end
	
	def edit
		@tran = Transaction.includes(:customer).find(params[:id])
		@aka = @tran.customer.aka
	end
	
	def update
	  @tran = Transaction.find(params[:id])
				
		if @tran.update_attributes(params[:transaction])
			flash[:notice] = "更新转账记录成功"
			redirect_to transactions_path
		else
			flash[:notice] = "更新转账记录异常"
			redirect_to edit_transaction_path(@tran) 
		end	
	end
	
	
	#表单自动补全，需要修改
	def search
		
    rs = ActiveRecord::Base.connection.execute("SELECT `customers`.`id`,`customers`.`aka`,`customers`.`vip`, `accounts`.`id`, `accounts`.`name`, `accounts`.`bank`, `accounts`.`acc`  FROM `accounts` INNER JOIN `customers` ON `customers`.`id` = `accounts`.`customer_id`  WHERE `customers`.`aka` like '%#{params[:term].strip}%'")
		
		arrays = Array.new
		
		rs.each do |customer|
			#防止accounts为空时出错
			customers = Hash.new
			customers[:id] = customer[0].to_s + "," + customer[5] + "," + customer[6]
			customers[:label] = customer[2] + " " + customer[1] + " "+ customer[4]
			customers[:value] = customer[1]	
			arrays << customers	
		end
		
	 	respond_to do |format|
  	  format.json { render :json => arrays.to_json }
  	end 
		
	end
	
	def get_transactions
		
		@trans = Transaction.where("customer_id = ? and remain >0", params[:customer_id])
								.order("remain desc").paginate(:page => params[:page], :per_page => 8)

		new_json = {
							"tran_data" => @trans.as_json(:only => [:id, :remain, :used, :created_by, :created_at]),
							"pages" => @trans.total_pages	
						}									
		respond_to do |format|
			format.json {
				render :json => new_json
			}
		end
	end
	
	#order reduce cash
	#UPDATE fund_usages SET fund_usages.usage_amount = fund_usages.usage_amount + 100 WHERE fund_usages.id = '1' 
	def reduce_cash
		_tran_id = params[:id]
		_cash =  params[:cash].to_i
		_order_id = params[:order_id]
		
		@forder = Order.find(_order_id)
		
		if current_user.check_mhotel(@forder.order_group.hotel_id).blank? and current_user.has_role? :operator
			render :json => {"code" => "10001","prompt" => "你没有权限进行扣款!"}
			return
		end
		
		#判断所扣金额是否超过当前order的uncoverd_amount
		if _cash > @forder.uncoverd_amount.to_i
			render :json => {"code" => "10001","prompt" => "所扣金额超过当前订单未付款值!"}
			return
		end
		
		#所扣金额是否大于
		@ftran = Transaction.find(_tran_id)
		if _cash > @ftran.remain.to_i
		   render :json => {"code" => "10001", "prompt" => "扣款金额大于当前转账记录的剩余金额"}
		   return
		end
	 ActiveRecord::Base.transaction do
	 
		 #保存使用记录	
		 @fund = FundUsage.new(
	 						:customer_id => @ftran.customer_id, :order_id => _order_id,
	 						:usage_amount => _cash, :transaction_id => params[:id],
	 						:creator => current_user.name,:order_group_id => params[:ogroup_id])
	 	 			
		 if @fund.save! 	 
	 		
	 		_usages = @forder.coverd_money
	 		
			#更新转账记录的值
			ActiveRecord::Base
				.connection.execute("UPDATE transactions SET transactions.used = (transactions.used + #{_cash}), transactions.remain = (transactions.remain-#{_cash}) WHERE transactions.id = '#{_tran_id}'")
			
		 #更新订单值
		 ActiveRecord::Base
		 	.connection.execute("UPDATE orders SET orders.coverd_amount = #{_usages},orders.uncoverd_amount=(orders.sum-#{_usages}) WHERE orders.id='#{_order_id}'")	
		 	
		 	@order = Order.find_by_id(_order_id)
		 	@tran = Transaction.find_by_id(_tran_id)
		 	
		 	if @order.uncoverd_amount.to_i == 0
		 		@order.update_attribute(:all_coverd, true)
		 	end
		 	
		 render :json => { 
		 			"code" => "10000","tran_id" => @tran.id,"coverd_amount" => @order.coverd_amount,
					"uncoverd_amount"=>@order.uncoverd_amount, "remain"=> @tran.remain, "used" => @tran.used,
					"fusage_data" => 
					@fund.as_json(:only =>[:id, :usage_amount, :creator, :created_at, :transaction_id])}
			
		 else
		 	 render :json => { "code" => "10001", "prompt" => "扣款出现未知错误！"}
		 end		
	
	 end			
	 
	end
	

	
	protected
	
	#验证客户名称是否存在
	def validate_customer
		@tran = Transaction.new(params[:transaction])
		@c = Customer.where(:name => @tran.customer_id.to_s.strip).first
	end
	
	
end
