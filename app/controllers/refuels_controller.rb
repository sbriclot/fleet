class RefuelsController < ApplicationController
  before_action :set_refuel, only: %i[create]
  before_action :find_vehicle, only: %i[index create]

  def index
    @refuels = Refuel.where(vehicle_id: params[:vehicle_id])
  end

  def new
    @refuel = Refuel.new
  end

  def create
    @refuel.vehicle = @vehicle
    if @refuel.save
      redirect_to vehicle_refuels_path
    else
      render :new
    end
  end

  def destroy
    @refuel.destroy
  end

  private

  def set_refuel
    params(:refuel).permit(:date, :km, :quantity, :price, :fuel_id, :vehicle_id)
  end

  def find_vehicle
    @vehicle = Vehicle.find(params[:vehicle_id])
  end
end
