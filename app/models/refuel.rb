class Refuel < ApplicationRecord
  belongs_to :fuel
  belongs_to :vehicle

  validates :date, presence: true
  validates :km, presence: true, numericality: { greater_than: 0 }
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :fuel_id, presence: true
  validates :vehicle_id, presence: true
end
