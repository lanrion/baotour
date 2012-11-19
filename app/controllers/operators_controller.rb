#coding: utf-8
class OperatorsController < ApplicationController
	protect_from_forgery :except => [:destroy, :create, :update]
	load_and_authorize_resource :only => [:create,:update,:destroy]
	
	def destroy
		@o = Operator.find(params[:id])
		
		if @o.destroy
   	 	respond_to do |format|
    	  	format.json { render :json => @o.as_json }
    	end  
    end
    
	end
	
	def create
		@op = Operator.new(params[:operator])
		
		if @op.save
			
			flash.notice = "保存成功"
			respond_to do |format|
    	  	format.json { render :json => @op.as_json }
    	end
		else
			
			respond_to do |format|
    	  	format.json { render :json => @op.errors.as_json, :status => 500 }
    	end
		end
	end
	
	def update
		@uo = Operator.find(params[:id])
		
		if @uo.update_attributes(params[:operator])
			
			flash.notice = "保存成功"
			respond_to do |format|
    	  	format.json { render :json => @uo.as_json }
    	end
		else
			respond_to do |format|
    	  	format.json { render :json => @uo.errors.as_json, :status => 500 }
    	end
		end
		
	end	

end
