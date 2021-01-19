class Maintenance < ApplicationRecord
  belongs_to :vehicle
  has_many :operations
end
