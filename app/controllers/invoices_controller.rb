class InvoicesController < ApplicationController
  private

  def invoices_params
    params.require(:invoice).permit(docs: [])
  end
end
