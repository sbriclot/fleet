class Invoice < ApplicationRecord
  belongs_to :invoice_type
  belongs_to :vehicle
  belongs_to :shop
  has_many_attached :docs

  validates :date, presence: true
  validates :km, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :invoice_type_id, presence: true
  validates :invoice_ref, presence: true, uniqueness: true
  validates :shop_id, presence: true
end
