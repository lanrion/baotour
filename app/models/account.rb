class Account < ActiveRecord::Base
  
  belongs_to :customer
  
  validates :name, :bank, :acc, :presence => true
  
end
