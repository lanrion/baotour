#coding:utf-8
#每一个order都会对应产生一对customer_usages，一对一
class Order < ActiveRecord::Base
  
  belongs_to :customer
  
  belongs_to :order_group
  
  	#消费记录
	has_one :customer_usage, :dependent => :destroy
	
	has_many :fund_usages
	
	def _operator
		Operator.find(operator)
	end
	
	def coverd_money
		_usages = 0
		fund_usages.each do |fu|
	 		_usages = _usages.to_i + fu.usage_amount.to_i			
	 	end
	 	_usages.to_i
	end
	
	def save_cusage(ogroup)
		fund_usages.each do |fusage|
			 @cusage = CustomerUsage.new
			 #拿到最新的值
			 _credit = Customer.find(customer.id).credit
			 @cusage.customer_id = customer_id
			 @cusage.order_id = id
			 @cusage.hotel_id = ogroup.hotel_id
			 @cusage.cosume = fusage.usage_amount
			 @cusage.remain = _credit.to_i - fusage.usage_amount.to_i 
			 @cusage.date = Time.now
			 if @cusage.save!
			 	ActiveRecord::Base.connection.execute(
			 		"UPDATE customers SET customers.credit = (customers.credit-#{fusage.usage_amount.to_i}) WHERE customers.id = #{customer.id}")
			 # 测试时取消
			 	fusage.update_attribute(:done, true)
			 end
		end 

			#生成invoice
			@invoice = Invoice.find_by_customer_id(customer_id)
			if @invoice.blank?
				# create
				@invoice = Invoice.new(:customer_id => customer_id, :issued => 0, :remain => sum)
   			@invoice.save!
			else
			 #update
			 	ActiveRecord::Base.connection.execute(
					"UPDATE invoices SET invoices.remain = (invoices.remain+#{sum.to_i}) WHERE invoices.customer_id=#{customer_id}")
			end

			update_attribute(:done, true)
	end
	
	def save_invoice
	
	end
  
end
