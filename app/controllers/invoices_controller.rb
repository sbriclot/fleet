class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[show edit update]
  before_action :set_vehicle, only: %i[index new]
  def index
    @invoices = Invoice.where(vehicle_id: params[:vehicle_id])
  end

  def show
    @shop = Shop.find(@invoice.shop_id)
  end

  def new
    @invoice = Invoice.new
    @action = 'Ajouter'
  end

  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      redirect_to vehicle_invoice_path(@invoice), notice: 'Facture créee'
    else
      @action = 'Ajouter'
      render :new
    end
  end

  def edit
    @action = 'Modifier'
  end

  def update
    if Invoice.update(invoice_params)
      redirect_to vehicle_invoice_path(@invoice), notice: 'Facture mise à jour'
    else
      @action = 'Modifier'
      render :edit
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:date, :km, :reference, :remarks, :price)
  end

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:vehicle_id])
  end
end
