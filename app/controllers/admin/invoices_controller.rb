class Admin::InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    binding.pry
    if @invoice.update(invoice_params)
      flash[:success] = "Invoice #{@invoice.id} status successfully updated."
      render :show
    else
      flash[:error] = @invoice.errors.full_messages.first
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:status)
  end
end
