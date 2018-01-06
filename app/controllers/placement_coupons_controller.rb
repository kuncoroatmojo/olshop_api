class PlacementCouponsController < ApplicationController
  before_action :authenticate_user
  respond_to :json

  def create
    chosen_coupon = Coupon.find(params[:coupon_id])
    placement_coupon = current_order.placement_coupon
    if placement_coupon
      render json: { errors: {message: 'Only one coupon can be applied'} }, status: 422
    else
      placement_coupon = PlacementCoupon.new
      placement_coupon.order = current_order
      placement_coupon.coupon = chosen_coupon

      if placement_coupon.save
        render json: placement_coupon, status: 201, location: [current_user, current_order, placement_coupon]
      else
        render json: { errors: placement_coupon.errors }, status: 422
      end
    end
  end

  def index
    json_response(current_user.orders.find(params[:order_id]).placement_coupon)
  end

  def destroy
    placement_coupon = PlacementCoupon.find(params[:id])
    placement_coupon.destroy
    head :no_content
  end
end
