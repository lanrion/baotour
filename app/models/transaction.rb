class Transaction < ActiveRecord::Base
  belongs_to :customer
  
  has_many :refunds, :dependent => :destroy
  
  validates :customer_id, :bank, :account, :name, :amount, :recv_date,  :presence => true
  
	validates :memo, :length => { :maximum => Base::TEXT_LENGTH }
	
	validates :amount, :numericality => true
  
end
