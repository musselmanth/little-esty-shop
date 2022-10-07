class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.enabled
  end

  def update
    binding.pry
  end
end