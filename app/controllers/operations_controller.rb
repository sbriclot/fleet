class OperationsController < ApplicationController
  before_action :set_operation, only: %i[show edit update destroy]
  before_action :set_maintenance, only: %i[index create edit update]
  before_action :set_vehicle, only: %i[index create edit update]

  def index
    populate_index

    @operation = Operation.new
    @btn_txt = "Ajouter"
  end

  def create
    @operation = Operation.new(operation_params)
    @operation.maintenance = @maintenance
    @operation.maintenance_plan_id = extract_mp_id

    if @operation.save
      redirect_to vehicle_maintenance_operations_path(@vehicle, @maintenance)
    else
      @btn_txt = "Ajouter"
      populate_index
      render "operations/index"
    end
  end

  def edit
    @btn_txt = 'Editer'
    populate_index
    render "operations/index"
  end

  def update
    @operation.maintenance_plan_id = extract_mp_id
    if @operation.update(operation_params)
      redirect_to vehicle_maintenance_operations_path(@vehicle, @maintenance)
    else
      @btn_txt = "Editer"
      populate_index
      render "operations/index"
    end
  end

  def destroy
    @operation.destroy

    redirect_to vehicle_maintenance_operations_path(params[:vehicle_id], params[:maintenance_id])
  end

  private

  def set_operation
    @operation = Operation.find(params[:id])
  end

  def set_maintenance
    @maintenance = Maintenance.find(params[:maintenance_id])
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:vehicle_id])
  end

  def operation_params
    params.require(:operation).permit(:task, :details)
  end

  def populate_index
    @maintenance = Maintenance.find(params[:maintenance_id])
    @operations = Operation.where(maintenance_id: params[:maintenance_id])
  end

  def extract_mp_id
    return if params[:operation][:maintenance_plan_id].empty?

    JSON.parse(params[:operation][:maintenance_plan_id])["id"]
  end
end
