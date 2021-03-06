class MaintenancesController < ApplicationController
  before_action :set_maintenance, only: %i[show edit update destroy]
  before_action only: %i[index create edit update] do
    set_vehicle(params[:vehicle_id])
  end
  before_action :populate_index, only: %i[index edit]

  def index
    @maintenance = Maintenance.new
    @action = "Ajouter"
  end

  def create
    @maintenance = Maintenance.new(maintenance_params)
    @maintenance.vehicle = @vehicle

    if @maintenance.save
      redirect_to vehicle_maintenance_operations_path(@vehicle, @maintenance)
    else
      @action = "Ajouter"
      populate_index
      render "maintenances/index"
    end
  end

  def edit
    @action = 'Editer'
    render "maintenances/index"
  end

  def update
    @maintenance.vehicle = @vehicle
    if @maintenance.update(maintenance_params)
      redirect_to vehicle_maintenances_path(@vehicle)
    else
      @action = "Editer"
      populate_index
      render "maintenances/index"
    end
  end

  def destroy
    @maintenance.destroy

    redirect_to vehicle_maintenances_path(params[:vehicle_id])
  end

  private

  def set_maintenance
    @maintenance = Maintenance.find(params[:id])
  end

  def maintenance_params
    params.require(:maintenance).permit(:date, :km)
  end

  def populate_index
    @maintenances = Maintenance.left_outer_joins(:operations)
                               .select("maintenances.id, maintenances.date, maintenances.km, count(operations.id) as nb_ops")
                               .where(vehicle_id: params[:vehicle_id])
                               .group("maintenances.id")
                               .order("maintenances.date DESC")
  end
end
