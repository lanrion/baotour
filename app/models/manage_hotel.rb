class ManageHotel < ActiveRecord::Base
	belongs_to :user
	belongs_to :hotel

end
