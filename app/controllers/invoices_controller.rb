class InvoicesController < ApplicationController
  before_action %i[show edit update]
  def index
    @invoices = Invoice.where(vehicle_id: params[:vehicle_id])
  end

  def show
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      redirect_to vehicle_invoice_path(@invoice), notice: 'Facture créee'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if Invoice.update(invoice_params)
      redirect_to vehicle_invoice_path(@invoice), notice: 'Facture mise à jour'
    else
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
end
