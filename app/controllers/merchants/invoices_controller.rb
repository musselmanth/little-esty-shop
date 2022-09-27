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
end