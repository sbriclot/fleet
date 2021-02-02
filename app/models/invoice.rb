class Invoice < ApplicationRecord
  belongs_to :invoice_type
  belongs_to :vehicle
  belongs_to :shop
  has_many_attached :docs
end
