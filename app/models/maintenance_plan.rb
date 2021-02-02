class MaintenancePlan < ApplicationRecord
  belongs_to :vehicle
  has_many :operations

  validates :task, :interval_km, :interval_months, presence: true
end
