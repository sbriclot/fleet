class MaintenancePlan < ApplicationRecord
  belongs_to :vehicle
  has_many :operations
end
