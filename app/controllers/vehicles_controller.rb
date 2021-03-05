class VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[show edit update]

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
    update_vehicle_fuels if params[:vehicle][:fuel_ids]

    if @vehicle.update(vehicle_params)
      redirect_to vehicle_path(@vehicle), notice: "Vehicle successfully updated"
    else
      @action = "Editer"
      render :edit
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
                                    :fuel_ids,
                                    :photo)
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def update_vehicle_fuels
    VehicleFuel.where(vehicle_id: @vehicle).destroy_all
    params[:vehicle][:fuel_ids].each do |fuel|
      VehicleFuel.create(vehicle_id: @vehicle.id, fuel_id: fuel)
    end
  end
end
