class InvoiceDetail < ActiveRecord::Base
  belongs_to :invoice
  
  validates :doc_ref,:amount, :presence => true
end
