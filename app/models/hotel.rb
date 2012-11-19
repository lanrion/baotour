#coding:utf-8

class Hotel < ActiveRecord::Base

	#消费记录
	has_many :customer_usage
	
	has_many :order_groups
	
	has_many :manage_hotels
	
	validates :name, :presence => true, :uniqueness => true
	
	#只能是数字
	validates :credit, :numericality => true
	
	
end
