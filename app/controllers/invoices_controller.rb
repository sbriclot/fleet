class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[show edit update]
  before_action :set_vehicle, only: %i[index new create edit update]
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
    # Ne fonctionne pas car n'est pas valide sans invoice_type_id mais j'ignore comment creer cela pour l'instant
    @invoice = Invoice.new(invoice_params)
    @invoice.vehicle = @vehicle

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
    if @invoice.update(invoice_params)
      redirect_to vehicle_invoice_path(@invoice), notice: 'Facture mise à jour'
    else
      @action = 'Modifier'
      render :edit
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:date, :km, :reference, :remarks, :price, :invoice_ref, :shop_id)
  end

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:vehicle_id])
  end
end
