class RefuelsController < ApplicationController
  before_action :params_refuel, only: %i[create]
  before_action :find_vehicle, only: %i[index create new]
  before_action :find_fuels, only: %i[new create]

  def index
    @refuels = Refuel.where(vehicle_id: params[:vehicle_id]).order(created_at: :desc)
    # Data for the refuels details chart
    last_ten_refuels_info(@refuels)
    # Need to get the average spending for each month of the last 12 months.
    # 1. Get the dates between now and 12 month ago.
    # 1.1 From that fetch each refuel spending across this time.
    # 2. For each month, average the refuel spending
    # 2.1 Maybe do an object that contain each month with the average spending value
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

  def find_fuels
    fuel_ids = []
    VehicleFuel.where(vehicle_id: params[:vehicle_id]).find_each do |fuel|
      fuel_ids << fuel.fuel_id
    end
    @vehicle_fuel = Fuel.find(fuel_ids)
  end

  def last_ten_refuels_info(refuel_info)
    @refuels_dates = []
    @refuels_price = []
    @refuels_quantity = []
    refuel_info.each do |refuel|
      @refuels_dates << refuel.date
      @refuels_price << refuel.price
      @refuels_quantity << refuel.quantity
    end
  end
end
