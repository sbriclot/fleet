class RemindersController < ApplicationController
  before_action :set_reminder, only: %i[edit update destroy]
  before_action :set_vehicle

  def index
    populate_index
    @reminder = Reminder.new
    @btn_txt = "Ajouter"
  end

  def create
    @reminder = Reminder.new(reminder_params)
    @reminder.vehicle = @vehicle

    if @reminder.save
      redirect_to vehicle_reminders_path(@vehicle)
    else
      @btn_txt = "Ajouter"
      populate_index
      render "reminders/index"
    end
  end

  def edit
    @btn_txt = 'Editer'
    populate_index
    render "reminders/index"
  end

  def update
    @reminder.vehicle = @vehicle
    if @reminder.update(reminder_params)
      redirect_to vehicle_reminders_path(@vehicle)
    else
      @btn_txt = "Editer"
      populate_index
      render "reminders/index"
    end
  end

  def destroy
    @reminder.destroy

    redirect_to vehicle_reminders_path(@vehicle)
  end

  private

  def set_reminder
    @reminder = Reminder.find(params[:id])
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:vehicle_id])
  end

  def reminder_params
    params.require(:reminder).permit(:task, :creation_km, :limit_km, :limit_date)
  end

  def populate_index
    @reminders = Reminder.where(vehicle_id: params[:vehicle_id])
  end
end
