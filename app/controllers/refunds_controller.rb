#coding: utf-8

class RefundsController < ApplicationController

	protect_from_forgery :except => [:destroy, :create, :update]
	load_and_authorize_resource :only => [:index,:create,:update,:destroy]
	
	def index
		@tran_id = params[:tran_id]
		if @tran_id.blank?
			@refunds = Refund.order("created_at DESC").includes(:transaction)
    						.paginate(:page => params[:page], :per_page => 20)
    else
    	@refunds = Refund.where(:transaction_id => @tran_id).order("created_at DESC")
    							.includes(:transaction).paginate(:page => params[:page], :per_page => 20)
    end 						
	end

	def create
		@refund = Refund.new(params[:refund])
		@tran = Transaction.find(@refund.transaction_id)
		
		if @refund.amount > @tran.remain
			render :json => {:code => "10001", :prompt => "退款金额不能大于当前转账记录的剩余金额!"}
			return
		end
		ActiveRecord::Base.transaction do
			if @refund.save
				@tran.update_attributes(:remain => @tran.remain-@refund.amount, :refund_state => true)
				# 减少当前客户的相应字段	
				ActiveRecord::Base.connection.execute(
				"UPDATE customers SET customers.credit=(customers.credit-#{@refund.amount}) WHERE customers.id=#{@tran.customer_id}"
				)
			
				flash.notice = "创建退款记录成功！"
				render :json => {:code => "10000", :prompt => "退款成功!"}
			end
		end	
		
	end
	
	def destroy
		@refund = Refund.find(params[:id])
		@refund.destroy
	end
	
	def edit
		@refund = Refund.find(params[:id])
	end
	
	def update
	
	end

end
