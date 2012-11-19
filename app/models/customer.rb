class Customer < ActiveRecord::Base

	has_many :operators, :dependent => :destroy
	
	has_many :invoices, :dependent => :destroy
	
	has_many :transactions, :dependent => :destroy
	
	has_many :accounts, :dependent => :destroy
	
	validates :name, :vip, :aka, :fax, :addr, :manager, :tel, :mobile, :presence => true
	
	validates :vip, :uniqueness => true
	
	validates :tel, :length => { :maximum => Base::TEL_NUMS }, :numericality => true
	
	validates :mobile, :length => {:maximum => Base::TEL_NUMS}, :numericality => true
	
	validates :addr, :length => { :maximum => Base::TEXT_LENGTH }	
	
		#只能是数字
	validates :credit, :numericality => true

end
