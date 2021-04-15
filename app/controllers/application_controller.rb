class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def set_vehicle(veh_id)
    @vehicle = Vehicle.find(veh_id)
    user_not_allowed if current_user != @vehicle.user
  end

  private
    def user_not_allowed
      redirect_to vehicles_path, alert: "Ce véhicule n'existe pas dans votre garage !"
    end

    def record_not_found
      redirect_to vehicles_path, alert: "Ce véhicule n'existe pas !"
    end
end
