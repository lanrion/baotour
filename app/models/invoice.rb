class Invoice < ActiveRecord::Base
  belongs_to :customer
  
  has_many :invoice_details, :dependent => :destroy
end
