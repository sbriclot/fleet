class VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[show edit update upd_vehicle_fuels]

  def index
    @all_vehicles = Vehicle.all     # a supprimer
    @vehicles = Vehicle.where(user_id: current_user.id)
  end

  def show
    sql = %{with vf as (select fuel_id, vehicle_id
                        from   vehicle_fuels
                        where  vehicle_id = #{@vehicle.id})
            select f.id as id, f.name as name, vf.vehicle_id as checked
            from   fuels f
            left outer join vf on vf.fuel_id = f.id
            order by f.name}

    @vehicle_fuels = ActiveRecord::Base.connection.exec_query(sql)
  end

  def new
    @vehicle = Vehicle.new
    @action = "Ajouter"
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    user = current_user
    @vehicle.user = user

    if @vehicle.save
      redirect_to vehicle_path(@vehicle), notice: "Vehicle successfully created"
    else
      @action = "Ajouter"
      render :new
    end
  end

  def edit
    @action = "Editer"
  end

  def update
    if @vehicle.update(vehicle_params)
      redirect_to vehicle_path(@vehicle), notice: "Vehicle successfully updated"
    else
      @action = "Editer"
      render :edit
    end
  end

  def upd_vehicle_fuels
    return unless params["cb-fuel-id"]

    @cb_fuel_id = params["cb-fuel-id"]

    if params["cb-checked"] == "true"
      VehicleFuel.create(vehicle_id: @vehicle.id, fuel_id: @cb_fuel_id)
    else
      VehicleFuel.where(vehicle_id: @vehicle.id, fuel_id: @cb_fuel_id).delete_all
    end
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:brand, :model,
                                    :registration, :sn,
                                    :tank_capacity,
                                    :actual_km,
                                    :total_expenses,
                                    :purchase_date, :purchase_km,
                                    :sale_date, :sale_km,
                                    :photo)
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end
end
