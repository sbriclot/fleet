class ShopsController < ApplicationController
  before_action :set_shop, only: %i[edit update show]

  def index
    @shops = Shop.all.order(:name)
  end

  def new
    @shop = Shop.new
    @action = "Ajouter"
  end

  def create
    @shop = Shop.new(shops_params)
    if @shop.save
      redirect_to shops_path, notice: "#{@shop.name} créé"
    else
      @action = "Ajouter"
      render :new
    end
  end

  def edit
    @action = "Editer"
  end

  def update
    if @shop.update(shops_params)
      redirect_to shops_path, notice: "#{@shop.name} mis à jour"
    else
      @action = "Editer"
      render :edit
    end
  end

  def show
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def shops_params
    params.require(:shop).permit(:name, :address, :tel, :home_url, :booking_url, :closed)
  end
end
