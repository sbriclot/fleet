class Vehicle < ApplicationRecord
  belongs_to :user
  has_many :documentations
  has_many :invoices
  has_many :maintenances
  has_many :maintenance_plans
  has_many :refuels
  has_many :reminders
  has_many :vehicle_fuels
  has_one_attached :photo
end
