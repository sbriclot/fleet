class Fuel < ApplicationRecord
  has_many :vehicule_fuels
  has_many :refuels
end
