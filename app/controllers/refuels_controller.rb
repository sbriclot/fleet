class RefuelsController < ApplicationController
  before_action :params_refuel, only: %i[create]
  before_action :find_vehicle, only: %i[index create new]
  before_action :find_fuel, only: %i[new create]

  def index
    @refuels = Refuel.where(vehicle_id: params[:vehicle_id]).order(created_at: :desc)
    # Need to create array with informations to pass to dataset for charts
  end

  def new
    @refuel = Refuel.new
  end

  def create
    @refuel = Refuel.new(params_refuel)
    @refuel.vehicle = @vehicle
    if @refuel.save
      redirect_to vehicle_refuels_path, notice: "Création effectuée"
    else
      render :new
    end
  end

  def destroy
    @to_delete = Refuel.find(params[:id])
    redirect_to vehicle_refuels_path, notice: 'Suppression effectuée' if @to_delete.destroy
  end

  private

  def params_refuel
    params.require(:refuel).permit(:date, :km, :quantity, :price, :fuel_id, :vehicle_id)
  end

  def find_vehicle
    @vehicle = Vehicle.find(params[:vehicle_id])
  end

  def find_fuel
    fuel_ids = []
    VehicleFuel.where(vehicle_id: params[:vehicle_id]).find_each do |fuel|
      fuel_ids << fuel.fuel_id
    end
    @vehicle_fuel = Fuel.find(fuel_ids)
  end
end
