class RefuelsController < ApplicationController
  before_action :params_refuel, only: %i[create]
  before_action :find_vehicle, only: %i[index create new]
  before_action :find_fuels, only: %i[new create]

  def index
    @refuels = Refuel.where(vehicle_id: params[:vehicle_id]).order(:created_at).last(10)
    # Data for the refuels details chart
    last_ten_refuels_info(@refuels)
    # Data for the twelve month history chart
    twelve_months_refuel_history
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

  def twelve_months_refuel_history
    refuel_history = Refuel.where("date >= current_date - 365")
                           .order("DATE_TRUNC('month', date)")
                           .group("DATE_TRUNC('month', date)")
                           .average(:price)

    @average_price = refuel_history.transform_values(&:round).values
    @average_date = refuel_history.transform_keys! do |key|
      key.strftime("%m/%Y")
    end
  end
end
