class Merchants::BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
    @holidays = HolidayFacade.generate_holidays
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
    @merchant = @bulk_discount.merchant
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount ||= BulkDiscount.new(threshold: params[:threshold], discount: params[:discount], holiday: params[:holiday])
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

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    @bulk_discount = BulkDiscount.find(params[:id])
    @merchant = @bulk_discount.merchant

    if @bulk_discount.update(bulk_discount_params)
      flash[:messages] = ["Bulk Discount Updated Successfully"]
      redirect_to merchant_bulk_discount_path(@merchant.id, @bulk_discount.id)
    else
      flash[:messages] = @bulk_discount.errors.full_messages
      @bulk_discount.convert_discount_to_decimal
      render :edit
    end
  end

  def destroy
    BulkDiscount.destroy(params[:id])
    redirect_to merchant_bulk_discounts_path(params[:merchant_id])
  end

  private

  def bulk_discount_params
    params.require(:bulk_discount).permit(:threshold, :discount, :merchant_id, :holiday)
  end
end