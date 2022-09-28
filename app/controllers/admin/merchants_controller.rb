class Admin::MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)

    if @merchant.save
      flash[:messages] = ["Merchant #{@merchant.name} successfully created"]
      redirect_to  "/admin/merchants"
    else
      flash[:messages] = @merchant.errors.full_messages
      render :new
    end
  end

  def update
    @merchant = Merchant.find(params[:id])

    if params.has_key?(:status)
      @merchant.update(status: params[:status])
      redirect_to admin_merchants_path
    elsif @merchant.update(merchant_params)
      flash[:messages] = ["Merchant information successfully updated"]
      redirect_to admin_merchant_path(@merchant.id)
    else
      flash[:messages] = @merchant.errors.full_messages
      render :edit
    end
  end

private

  def merchant_params
    params.require(:merchant).permit(:name, :status)
  end

end
