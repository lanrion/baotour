class FundUsage < ActiveRecord::Base
  belongs_to :customer
  belongs_to :order
  belongs_to :transaction
  belongs_to :order_group
end
