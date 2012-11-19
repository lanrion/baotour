#encoding:utf-8
class CustomersController < ApplicationController
  protect_from_forgery :except => [:destroy, :create, :update] 
  load_and_authorize_resource :only => [:new,:index,:create,:update,:edit]
  
  def index
    @customers = Customer.order("vip asc")
    						.paginate(:page => params[:page], :per_page => 20)
  end
  
  def new
  	@customer = Customer.new
  	@_action = "_new"
  end
  
  def create
  	 @customer = Customer.new(params[:customer])
		 if @customer.save
		  flash.notice = "保存客户信息成功！"
		  redirect_to edit_customer_path(@customer)
		 else
		 	flash.notice = "保存客户信息异常！"
	 	  render "new"
		 end
  end
  
  def edit
  	@customer = Customer.includes(:operators, :accounts).find(params[:id])
  end
 
  def update
  	@customer = Customer.find(params[:id])
		
		if @customer.update_attributes(params[:customer])
			
			flash.notice = "保存成功"
			respond_to do |format|
    	  	format.json { render :json => @customer.as_json }
    	end
		else
			respond_to do |format|
    	  	format.json { render :json => @customer.errors.as_json, :status => 500 }
    	end
		end
  	
  end
  
  
end
