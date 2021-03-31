class Operation < ApplicationRecord
  belongs_to :maintenance
  belongs_to :maintenance_plan, optional: true

  validates :task, presence: true
end
