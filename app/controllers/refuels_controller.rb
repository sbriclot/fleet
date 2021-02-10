class RefuelsController < ApplicationController
  before_action :params_refuel, only: %i[create]
  before_action :find_vehicle, only: %i[index create new]

  def index
    @refuels = Refuel.where(vehicle_id: params[:vehicle_id])
  end

  def new
    @refuel = Refuel.new
  end

  def create
    @refuel = Refuel.new(params_refuel)
    @refuel.vehicle = @vehicle
    if @refuel.save
      redirect_to vehicle_refuels_path
    else
      render :new
    end
  end

  def destroy
    @todelete = Refuel.find(params[:id])
    redirect_to vehicle_refuels_path if @todelete.destroy
  end

  private

  def params_refuel
    params.require(:refuel).permit(:date, :km, :quantity, :price, :fuel_id, :vehicle_id)
  end

  def find_vehicle
    @vehicle = Vehicle.find(params[:vehicle_id])
  end
end
