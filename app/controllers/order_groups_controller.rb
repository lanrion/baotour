#coding: utf-8
class OrderGroupsController < ApplicationController
	
	protect_from_forgery :except => [:_save_group, :_update_group, :make_done]
	
	load_and_authorize_resource :only => [:index,:_save_group,:_update_group, :make_done]
	
	def index
		
		#if current_user.has_role? :operator
	  #	@hotels = current_user.manage_hotels.includes(:hotel)
	  #send
	  
	  @hotels = Hotel.all 
	  
	  if @hotels.blank?
	  	_first_hotel = 1
	  else
	  	_first_hotel = @hotels.first.id.to_s
	  end
	  
    @date = params[:date] ? Date.strptime(params[:date],"%Y-%m-%d") : Date.today
    
	  @hotel_id = params[:hotel_id] || _first_hotel
	  @orgroups = OrderGroup.where(:date=>@date, :hotel_id=>@hotel_id).order("id asc")
    
	end
	
	def _save_group
	  hotel = Hotel.find(:first, :conditions=>{:id=>params[:hotel_id]})
	  date = params[:date]
	  
	  if !hotel || !date
	    render :json => {:code => "10001", :error => "操作错误,请先切换到相应的时间与酒店！"}
	    return
	  end
	  
	  #计调组并且存在记录
	  if current_user.check_mhotel(hotel.id).blank? and current_user.has_role? :operator
	  	 render :json => {:code => "10001", :error => "你无此权限为 #{hotel.name} 添加排期"}
	  	 return
	  end
	  
	  orderGroup = OrderGroup.new
	  orderGroup.hotel = hotel
	  orderGroup.date = date
	  orderGroup.ref = params[:gref]
	  orderGroup.day_1 = params[:gday_1]
	  orderGroup.day_2 = params[:gday_2]
	  orderGroup.day_3 = params[:gday_3]	  
	  orderGroup.dinner = params[:gdinner]	  
	  orderGroup.fee = params[:gfee]	  
	  orderGroup.sum = params[:gsum]	  
	  orderGroup.night = params[:gnight]
	  orderGroup.memo = params[:gmemo]	  
    orderGroup.save!
    
	  render :nothing => true, :status => 200
  end
  
  def _update_group
    hotel = Hotel.find(:first, :conditions=>{:id=>params[:hotel_id]})
	  date = params[:date]
	  
	  if !hotel || !date
	    render :json => {:code => "10001", :error => "操作错误,请先切换到相应的时间与酒店！"}
	    return
	  end
	  
	  #计调组并且存在记录
	  if current_user.check_mhotel(hotel.id).blank? and current_user.has_role? :operator
	  	 render :json => {:code => "10001", :error => "你无此权限为 #{hotel.name} 更新排期"}
	  	 return
	  end
	  
	  orderGroup = OrderGroup.find(:first, :conditions=>{:id=>params[:gid]})
	  orderGroup.ref = params[:gref]
	  orderGroup.day_1 = params[:gday_1]
	  orderGroup.day_2 = params[:gday_2]
	  orderGroup.day_3 = params[:gday_3]	  
	  orderGroup.dinner = params[:gdinner]	  
	  orderGroup.fee = params[:gfee]	  
	  orderGroup.sum = params[:gsum]	  
	  orderGroup.night = params[:gnight]	 
	  orderGroup.memo = params[:gmemo] 
    orderGroup.save!
	  render :nothing => true, :status => 200
  end

  def _customer_operator_search
    objs = []
    keyword = "%#{params[:term]}%"
    rs = ActiveRecord::Base.connection.execute("SELECT `customers`.`id`,`customers`.`aka`, `operators`.`id`, `operators`.`name` FROM `operators` INNER JOIN `customers` ON `customers`.`id` = `operators`.`customer_id`  WHERE `customers`.`aka` like '#{keyword}'")
    
    rs.each do |result|
      obj_id = "#{result[0]}_#{result[2]}"
      obj_name = "#{result[1]} #{result[3]}"
      obj = {:id=>obj_id, :label=>obj_name, :value=>obj_name}
      objs << obj
    end

    render :json => objs.to_json

  end
  
  #order_group 完成
  def make_done
  	_id = params[:id]
  	_hotel_id = params[:hotel_id]
  	
  		  #计调组并且存在记录
	  if current_user.check_mhotel(_hotel_id).blank? and current_user.has_role? :operator
	  	 render :json => {:code => "10001", :prompt => "你无此权限完成此排期!"}
	  	 return
	  end
  	
  	@order_group = OrderGroup.find(_id)
  	@orders = @order_group.orders
  	_uncoveres = @orders.where(:all_coverd => false).count
  	# 判断是否存在没有完成扣款的订单
  	if _uncoveres > 0
  		render :json => {:code => "10001", :prompt => "存在#{_uncoveres}条未扣款订单，无法完成此计调！"}
  		return
  	end
  	
  	_s = @orders.where("uncoverd_amount < 0").count
  	if _s > 0
  		render :json => {:code => "10001", :prompt => "存在 #{_s} 条订单出现多扣款记录，请及时更改！"}
  		return
  	end
  	
  	ActiveRecord::Base.transaction do

			@orders.each do |order|
				order.save_cusage(@order_group)
			end
		
			@order_group.save_hotel_ledger(@order_group)
		
			#完成排期
			@order_group.update_attribute(:done, true)
		
		end
		  	
  	render :json => {:code => "10000", :prompt => "完成此计调！"}
  end
	
	
#select transactions.id, transactions.used, fund_usages.id, fund_usages.usage_amount from transactions INNER JOIN fund_usages ON 
#transactions.customer_id = fund_usages.customer_id where fund_usages.customer_id = "5"


#select transactions.id, transactions.used, fund_usages.id, fund_usages.usage_amount from transactions LEFT JOIN fund_usages ON 
#transactions.customer_id = fund_usages.customer_id where transactions.customer_id = "5" or fund_usages.order_id="8"

#UPDATE fund_usages SET fund_usages.usage_amount = fund_usages.usage_amount + 100 WHERE fund_usages.id = '1' 

end
