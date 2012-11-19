#coding: utf-8

class InvoicesController < ApplicationController
	protect_from_forgery :except => [:destroy, :create, :update] 
	load_and_authorize_resource :only => [:index,:create,:update,:destroy]

	def index
		@invoices = Invoice.includes(:customer)
    						.paginate(:page => params[:page], :per_page => 20)
	end
	
end
