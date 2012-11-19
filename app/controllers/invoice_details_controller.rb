#coding: utf-8

class InvoiceDetailsController < ApplicationController
	protect_from_forgery :except => [:destroy, :create, :update] 
	load_and_authorize_resource :only => [:index,:create,:update,:destroy,:new]
	
  def index
  	@invoice = Invoice.find(params[:invoice_id])
		@details = InvoiceDetail.where(:invoice_id => params[:invoice_id])
							.order("created_at DESC").paginate(:page => params[:page], :per_page => 20)
	end

	def new
		@invoice = Invoice.find(params[:invoice_id])
		@invoice_detail = InvoiceDetail.new(:invoice_id => params[:invoice_id])
	end
	
	def create
		@detail = InvoiceDetail.new(params[:invoice_detail])
		@invoice = Invoice.select(:remain).find(@detail.invoice_id)
		if @invoice.remain.to_i < @detail.amount.to_i
			flash.alert = "出错了,开票金额不能超过可未开票金额: #{@invoice.remain}！"
			redirect_to "/invoice_details/new?invoice_id=#{@detail.invoice_id}"
			return
		end
		@detail.creator = current_user.name
		ActiveRecord::Base.transaction do
			if @detail.save
				ActiveRecord::Base.connection.execute(
					"UPDATE invoices SET invoices.issued = (invoices.issued + #{@detail.amount}), invoices.remain=(invoices.remain-#{@detail.amount}) WHERE invoices.id=#{@detail.invoice_id}")
				flash.notice = "操作成功!"
				redirect_to "/invoices"
			else
				flash.alert = "出错了,文档头,文档编号与开票金额不能为空！"
				redirect_to "/invoice_details/new?invoice_id=#{@detail.invoice_id}"
			end
		end		
	end
	
end
