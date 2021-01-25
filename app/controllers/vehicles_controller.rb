class VehiclesController < ApplicationController
	def index
		@all_vehicles = Vehicle.all
		@vehicles = Vehicle.where(user_id: current_user.id)
	end

	def show
		@vehicle = Vehicle.find(params[:id])
	end
end
