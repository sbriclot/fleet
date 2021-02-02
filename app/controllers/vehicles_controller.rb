class VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[show edit update]

  def index
    @all_vehicles = Vehicle.all     # a supprimer
    @vehicles = Vehicle.where(user_id: current_user.id)
  end

  def show
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
      redirect_to vehicles_path, notice: "Vehicle successfully created"
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
      @vehicle.save
      redirect_to vehicles_path, notice: "Vehicle successfully updated"
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
                                    :purchase_date, :purchase_km,
                                    :sale_date, :sale_km,
                                    :photo)
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end
end
