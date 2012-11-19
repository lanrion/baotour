#encoding: utf-8
class CustomerUsagesController < ApplicationController
	load_and_authorize_resource :only => [:index]

	def index
		@cusages = CustomerUsage.includes(:customer, :order, :hotel)
						.order("cosume DESC").paginate(:page => params[:page], :per_page => 20)
	end
end
