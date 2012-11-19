class Operator < ActiveRecord::Base
  belongs_to :customer
  
	validates :name, :mobile, :presence => true
	
	validates :mobile, :length => { :maximum => Base::TEL_NUMS }, :numericality => true
	
	#validates :name, :uniqueness => true
end
