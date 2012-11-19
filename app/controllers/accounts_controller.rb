#coding: utf-8
class AccountsController < ApplicationController
	protect_from_forgery :except => [:destroy, :create, :update] 
	load_and_authorize_resource :only => [:create,:update,:destroy]
	
	def destroy
		@a = Account.find(params[:id])
		
		if @a.destroy
   	 	respond_to do |format|
    	  	format.json { render :json => @a.as_json }
    	end  
    end
	end
	
	def create
		@a = Account.new(params[:account])
		
		if @a.save
			flash.notice = "保存成功"
			render :json => {:code => "10000", :error => "保存成功！"}
		else
			render :json => {:code => "10001", :error => "姓名、银行、账号为必填项！"}
		end
	end
	
	def update
		@ua = Account.find(params[:id])
		
		if @ua.update_attributes(params[:account])
			
			flash.notice = "保存成功"
			respond_to do |format|
    	  	format.json { render :json => {:code => "10000", :error => "更新成功！"} }
    	end
		else
			respond_to do |format|
    	  	format.json { render :json => {:code => "10001", :error => "姓名、银行与账号为必填项！"} }
    	end
		end
		
	end


end
