class VehicleFuel < ApplicationRecord
  belongs_to :fuel
  belongs_to :vehicle
end
