class OperationsMaintenancePlanIdNullTrue < ActiveRecord::Migration[6.0]
  def change
    change_column_null :operations, :maintenance_plan_id, true
  end
end
