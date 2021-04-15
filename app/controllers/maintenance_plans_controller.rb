class MaintenancePlansController < ApplicationController
  before_action :set_plan, only: %i[edit update destroy]
  before_action { set_vehicle(params[:vehicle_id]) }
  before_action :populate_index, only: %i[index edit]

  def index
    @plan = MaintenancePlan.new
    @action = "Ajouter"
  end

  def create
    @plan = MaintenancePlan.new(plan_params)
    @plan.vehicle = @vehicle

    if @plan.save
      redirect_to vehicle_maintenance_plans_path(@vehicle)
    else
      @action = "Ajouter"
      populate_index
      render "maintenance_plans/index"
    end
  end

  def edit
    @action = 'Editer'
    render "maintenance_plans/index"
  end

  def update
    @plan.vehicle = @vehicle
    if @plan.update(plan_params)
      redirect_to vehicle_maintenance_plans_path(@vehicle)
    else
      @action = "Editer"
      populate_index
      render "maintenance_plans/index"
    end
  end

  def destroy
    # remove links between the deleted MP and Operations
    Operation.where(maintenance_plan_id: params[:id]).update_all(maintenance_plan_id: '')
    @plan.destroy

    redirect_to vehicle_maintenance_plans_path(@vehicle)
  end

  private

  def set_plan
    @plan = MaintenancePlan.find(params[:id])
  end

  def plan_params
    params.require(:maintenance_plan).permit(:task, :details, :interval_km, :interval_months)
  end

  def populate_index
    sql = %{with last_ops as (select mp.id as mp_id
                                    ,max(o.id) as last_id
                              from   maintenance_plans mp
                              left outer join operations o on mp.id = o.maintenance_plan_id
                              where  mp.vehicle_id = #{params[:vehicle_id]}
                              group by mp.id)
            select mp.id as id
                  ,mp.task as task
                  ,mp.details as details
                  ,mp.interval_km as int_km
                  ,mp.interval_months as int_months
                  ,mp.interval_km - (v.actual_km - coalesce(m.km, 0)) as next_km
                  ,coalesce(m.date, v.purchase_date) + make_interval(months => mp.interval_months) as next_date
            from   last_ops lo
            join maintenance_plans mp on lo.mp_id = mp.id
            join vehicles v on mp.vehicle_id = v.id
            left outer join operations o on lo.last_id = o.id
            left outer join maintenances m on o.maintenance_id = m.id
            order by next_km}

    @plans = ActiveRecord::Base.connection.exec_query(sql)
  end
end
