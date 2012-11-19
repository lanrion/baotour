#encoding:utf-8

class HotelsController < ApplicationController
	load_and_authorize_resource :only => [:edit,:new,:index,:create,:update,:manage_to_user,:detroy_manage_hotel]
	protect_from_forgery :except => [:manage_to_user, :detroy_manage_hotel] 
	
	def index
		@hotels = Hotel.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
	end
	
	def new
		@hotel = Hotel.new
	end
	
	def create
		@hotel = Hotel.new(params[:hotel])
		if @hotel.save
			flash[:notice] = "新建酒店成功"
			redirect_to hotels_path
		else
			flash[:alert] = "新建酒店异常,酒店名不能重复"
			render action: "new" 
		end
	end
	
	def edit
		@hotel = Hotel.find(params[:id])
	end
	
	def update
		@hotel = Hotel.find(params[:id])
		if @hotel.update_attributes(params[:hotel])
			flash[:notice] = "更新酒店成功"
			redirect_to hotels_path
		else
			flash[:alert] = "新建酒店异常,酒店名不能重复"
			render action: "edit" 
		end	
	end
	
	def search
		@hotels = Hotel.where("name like ?", "%#{params[:term].strip}%")
		
		arrays = Array.new
		
		@hotels.each do |hotel|
			#防止accounts为空时出错
			hotels = Hash.new
			hotels[:id] = hotel.id
			hotels[:label] = hotel.name + " " + hotel.credit
			hotels[:value] = hotel.name
			arrays << hotels	
		end
		
	 	respond_to do |format|
  	  format.json { render :json => arrays.to_json }
  	end 
	end
	
	#授权给用户
	def manage_to_user
		@mh = ManageHotel.new(:user_id => params[:user_id],
										:hotel_id => params[:hotel_id], 
										:creator => current_user.name)
		
		if @mh.save
			render :json => {:code => "10000", :prompt => "操作成功!"}
		else
			render :json => {:code => "10001", :prompt => "操作失败!"}
		end								
	end
	
	def detroy_manage_hotel
		 @mh = ManageHotel.where(:user_id => params[:user_id], :hotel_id => params[:hotel_id]).first
		 if @mh.destroy
		 	 render :json => {:code => "10000", :prompt => "操作成功！"}
		 else
		   render :json => {:code => "10001", :prompt => "操作失败！"}
		 end
	end

end
