class Operation < ApplicationRecord
  belongs_to :maintenance
  belongs_to :maintenance_plan, optional: true
end
