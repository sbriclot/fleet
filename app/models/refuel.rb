class Refuel < ApplicationRecord
  belongs_to :fuel
  belongs_to :vehicle
end
