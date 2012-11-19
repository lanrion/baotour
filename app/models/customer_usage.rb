#coding: utf-8
#客户消费记录

class CustomerUsage < ActiveRecord::Base
  belongs_to :customer
 
  belongs_to :order
 
  belongs_to :hotel
  

end
