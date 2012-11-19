#coding: utf-8

class TransfersController < ApplicationController
	protect_from_forgery :except => [:destroy, :create, :update] 
	load_and_authorize_resource :only => [:new,:index,:create,:update,:destroy]

	def index
		@hotel_ledgers = HotelLedger.includes(:hotel, :order_group)
										.order("created_at DESC")
    								.paginate(:page => params[:page], :per_page => 20)
	end
	
	def new
		@transfer = Transfer.new
		@hotel_name=""
	end
	
	def create
		
		_hotel_name = params[:hotel_name]
		
		@hotel = Hotel.find_by_name(_hotel_name)
		if @hotel.blank?
			flash.alert = "没有此酒店，请输入正确的酒店名称，建议通过自动匹配填充！"
			render :new
			return
		end
		
		@transfer = Transfer.new(params[:transfer])
		@transfer.hotel_id = @hotel.id
		@transfer.creator = current_user.name
		@transfer.by = current_user.name
	 	ActiveRecord::Base.transaction do	
			if @transfer.save
			
				@hl = HotelLedger.new
				@hl.hotel_id = @hotel.id
				@hl.transfer_id = @transfer.id
				@hl.add_amount = @transfer.amount
				#为转账之后的最新值
				@hl.credit = @hotel.credit.to_i + @transfer.amount
				if @hl.save 
					#@hotel.update_attribute(:credit, @hl.credit)
					ActiveRecord::Base.connection.execute(
						"UPDATE hotels SET hotels.credit = (hotels.credit+#{@hl.credit}) WHERE hotels.id=#{@hotel.id}")
				end
				flash.notice = "添加酒店转帐记录成功!"
				redirect_to :action => "index"
			else
				flash.alert = "保存此转账记录时出错了，请核实数据是否规范！"
				render :new
			end
		end
	end
	
	def edit
		@transfer = Transfer.find(params[:id])
		@hotel_name= @transfer.hotel.name
	end
	
end
