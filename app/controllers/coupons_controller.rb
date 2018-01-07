class CouponsController < ApplicationController
  respond_to :json

  def index
    json_response(Coupon.all)
  end

  def show
    json_response(Coupon.find(params[:id]))
  end

  def create
    @product = Coupon.create(product_params)
    json_response(@product)
  end
end
