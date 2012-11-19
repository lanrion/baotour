class HotelLedger < ActiveRecord::Base
  belongs_to :hotel
  belongs_to :order_group
  belongs_to :transfer
end
