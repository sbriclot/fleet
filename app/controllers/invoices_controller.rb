class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[show edit update]
  before_action :set_vehicle
  before_action :old_invoice_price, only: %i[update]

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
    @invoice.vehicle = @vehicle
    @vehicle.total_expenses += params[:price]

    if @invoice.save
      redirect_to vehicle_invoice_path(@vehicle, @invoice), notice: 'Facture créee'
    else
      @action = 'Ajouter'
      render :new
    end
  end

  def edit
    @action = 'Modifier'
  end

  def update
    # Si il y a modification du prix, soustrait l'ancien prix et le remplace par le nouveau

    if @invoice.update(invoice_params)
      redirect_to vehicle_invoice_path(@vehicle, @invoice), notice: 'Facture mise à jour'
    else
      @action = 'Modifier'
      render :edit
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:date, :km,
                                    :reference, :remarks,
                                    :price, :invoice_ref,
                                    :shop_id, :invoice_type_id, docs: [])
  end

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:vehicle_id])
  end

  def old_invoice_price
    @old_price = @invoice.price
  end
end
