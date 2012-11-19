#coding:utf-8
class OrderGroup < ActiveRecord::Base
  # include Extensions::UUID
	
  belongs_to :hotel
  has_many :orders, :dependent => :destroy
  
	def save_hotel_ledger(ogroup)
		@hotel_ledger = HotelLedger.new
		@hotel_ledger.hotel_id = ogroup.hotel_id
		@hotel_ledger.order_group_id = ogroup.id
		@hotel_ledger.rooms = ogroup.day_1 + "/" + ogroup.day_2 + "/" + ogroup.day_3
		@hotel_ledger.night = ogroup.night
		@hotel_ledger.cosumption = ogroup.sum.to_i
		@hotel_ledger.credit = hotel.credit.to_i - ogroup.sum.to_i
		if @hotel_ledger.save!
			ActiveRecord::Base.connection.execute("UPDATE hotels SET hotels.credit = (hotels.credit - #{ogroup.sum.to_i}) WHERE hotels.id = #{ogroup.hotel_id}")
		end	
	end  
  # attr_accessible :id, :hotel_id, :day_1, :day_2, :day_3, :dinner, :night, :fee, :ref, :sum
end
