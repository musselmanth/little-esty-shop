class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.enabled
  end
end