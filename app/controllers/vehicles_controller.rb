class VehiclesController < ApplicationController
	before_action :set_vehicle, only: [:show, :edit, :update]

	def index
		@all_vehicles = Vehicle.all     # à supprimer 
		@vehicles = Vehicle.where(user_id: current_user.id)
	end

	def show
	end

	def new
		@vehicle = Vehicle.new
	end
	
	def create
		@vehicle = Vehicle.new(vehicle_params)
		user = current_user
		@vehicle.user = user

		if @vehicle.save
      redirect_to vehicles_path, notice: "Vehicle successfully created"
    else
      render :new
		end
	end

	def edit
	end

	def update
		if @vehicle.update(vehicle_params)
			@vehicle.save
			redirect_to vehicles_path, notice: "Vehicle successfully updated"
		else
			render :edit
		end
	end

	private

	def vehicle_params
		params.require(:vehicle).permit(:brand, :model, :registration, :sn, :tank_capacity, :actual_km)
	end
	
	def set_vehicle
		@vehicle = Vehicle.find(params[:id])
	end
end
