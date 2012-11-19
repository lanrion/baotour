#coding: utf-8
class OrdersController < ApplicationController
	protect_from_forgery :except => [:destroy, :create, :update, :add_memo]
	load_and_authorize_resource :only => [:create,:update,:uncoverd_orders]
	
	def create
		_ref = params[:write_ref]
		@rf = OrderGroup.where(:ref => _ref, :done => false, :date => params[:current_date]).first
		
		if @rf.blank?
			render :json => {:code => "10001", :promot => "不存在此计调排期的Ref或者此计调排期已经完成。"}
			return
		end
		
	  #计调组并且存在记录
	  if current_user.check_mhotel(@rf.hotel_id).blank? and current_user.has_role? :operator
	  	 render :json => {:code => "10001", :promot => "你无此权限为 #{@rf.hotel.name} 添加排期明细"}
	  	 return
	  end
		
		@order = Order.new(params[:order])
		@order.creator = current_user.name
		@order.uncoverd_amount= @order.sum
		@order.order_group_id = @rf.id
		
		@order.all_coverd = false
		if @order.save
			Guide.save_by_g(params[:order][:guide])
    	render :json => {:code => "10000", :promot => "保存成功！"}
	  else
	  	render :json => {:code => "10001", :promot => "保存时发生未知错误，请保证排期明细数据正确！"}
	  end	
	end
	
	def update
	  _ref = params[:update_ref]
		@rf = OrderGroup.where(:ref => _ref, :done => false, :date => params[:current_date]).first
		
		if @rf.blank?
			render :json => {:code => "10001", :promot => "不存在此计调排期的Ref或者此计调排期已经完成。"}
			return
		end
		
		@order = Order.find(params[:id])
		
		_was_group = @order.order_group_id
		
		@order.order_group_id = @rf.id
	  #计调组并且存在记录
	  if current_user.check_mhotel(@order.order_group.hotel_id).blank? and current_user.has_role? :operator
	  	 render :json => {:code => "10001", :promot => "你无权限更新此排期明细"}
	  	 return
	  end	
	  
		uncoverd = params[:order][:sum].to_i - @order.coverd_money
		
		if uncoverd > 0 
			@order.all_coverd = false
		end
		
		if uncoverd < 0 or uncoverd == 0
			@order.all_coverd = true
		end
		
	  @order.uncoverd_amount = uncoverd
 ActiveRecord::Base.transaction do
		if @order.update_attributes!(params[:order])
			p _was_group
			p @order.order_group_id
			
			if _was_group.to_i != @order.order_group_id.to_i
				@order.fund_usages.update_all(:order_group_id => @rf.id)
			end
			
			Guide.save_by_g(params[:order][:guide])
 			render :json => {:code => "10000", :promot => "订单更新成功！"}
    else
			render :json => {:code => "10001", :promot => "更新时发生未知错误，请保证排期明细数据正确！"}    
		end
	end	
	end
	
	def add_memo
		@order = Order.find(params[:order_id])
		if @order.update_attribute(:memo, params[:memo])
		 render :json => {:code => "10000", :promot => "更新成功！"}
		else
			render :json => {:code => "10001", :promot => "保存失败！"}
		end
	end
	
	#未收款查询
	def uncoverd_orders
	 	@orders = Order.includes(:customer,:order_group)
	 								 .where(:all_coverd => false, :done => false).order("created_at DESC")
    						   .paginate(:page => params[:page], :per_page => 20)
	
	end
	
	#查找联系人
	def search_guider
		@guiders = Guide.where("name like ?", "%#{params[:term]}%")
		
		arrays = Array.new
		@guiders.each do |guide|
			ghash = Hash.new
			ghash[:id] = guide.id
			ghash[:lable] = guide.name
			ghash[:value] = guide.name
			arrays << ghash
		end
	  respond_to do |format|
  	  	format.json { render :json => arrays.to_json }
  	end 
		
	end
	
	#查找ref
	def serach_orgroup
		#待定
		hotel_id = params[:hotel_id]
		@refs = OrderGroup.
			find_by_sql("select order_groups.id, order_groups.ref from order_groups where order_groups.ref like '%#{params[:term]}%' and order_groups.hotel_id = '#{hotel_id}' and order_groups.date = '#{params[:date]}' and order_groups.done = false ")
		arrays = Array.new
		@refs.each do |ref|
			rhash = Hash.new
			rhash[:id] = ref.id
			rhash[:lable] = ref.ref
			rhash[:value] = ref.ref
			arrays << rhash
		end	
	  respond_to do |format|
  	  	format.json { render :json => arrays.to_json }
  	end 
  			
	end
	
	
end
