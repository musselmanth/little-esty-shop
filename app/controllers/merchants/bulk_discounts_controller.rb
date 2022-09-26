class Merchants::BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
    @merchant = @bulk_discount.merchant
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount ||= BulkDiscount.new(merchant: @merchant)
  end

  def create
    params[:bulk_discount][:merchant_id] = params[:merchant_id]

    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.new(bulk_discount_params)
    if @bulk_discount.save
      flash[:messages] = ["Bulk Discount successfully created."]
      redirect_to merchant_bulk_discounts_path(@bulk_discount.merchant_id)
    else
      flash[:messages] = @bulk_discount.errors.full_messages
      render :new
    end
  end

  private

  def bulk_discount_params
    params.require(:bulk_discount).permit(:threshold, :discount, :merchant_id)
  end
end