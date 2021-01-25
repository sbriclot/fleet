class ShopsController < ApplicationController
  before_action :set_shop, only: %i[edit update]

  def index
    @shops = Shop.all.order(:name)
  end

  def new
    @shop = Shop.new
    @action = "Add"
  end

  def create
    @shop = Shop.new(shops_params)
    if @shop.save
      redirect_to shops_path, notice: "#{@shop.name} successfully created"
    else
      @action = "Add"
      render :new
    end
  end

  def edit
    @action = "Edit"
  end

  def update
    if @shop.update(shops_params)
      @shop.save
      redirect_to shops_path, notice: "#{@shop.name} successfully updated"
    else
      @action = "Edit"
      render :edit
    end
  end

  private
  def set_shop
    @shop = Shop.find(params[:id])
  end

  def shops_params
    params.require(:shop).permit(:name, :address, :tel, :home_url, :booking_url, :closed)
  end
end
