class Merchants::InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.distinct_invoices
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @customer = @invoice.customer
    @invoice_items = @merchant.invoice_items_for_invoice(@invoice.id)
  end

  def update
    @invoice = Invoice.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
    if @invoice.update(invoice_params)
      flash[:messages] = ["Item statuses succesfully updated"]
      redirect_to merchant_invoice_path(@merchant.id, @invoice.id)
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(invoice_items_attributes: [:status, :id])
  end
end