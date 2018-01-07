class OrdersController < ApplicationController
  before_action :authenticate_user
  before_action :authorize_admin, only: [:update]
  respond_to :json

  def index
    if current_user.user_type == 'admin'
      user = User.find(params[:user_id])
      json_response(user.orders.where_not(status: 'notfinalized'))
    else
      json_response(current_user.orders)
    end
  end

  def show
    json_response(current_user.orders.find(params[:id]))
  end

  def create
    @order = current_order
    @order.address = params[:address]
    @order.phone = params[:phone]
    current_order = current_user.orders.create!
    if validating
      @order.status = "finalized"
      @order.placements.each do |item|
        item.decrement_product_quantity!
      end
      if @order.placement_coupon
        @order.placement_coupon.decrement_coupon_quantity!
      end
      @order.set_total!
      render json: @order, status: 201
    else
      render json: { errors: @order.errors }, status: 422
    end
  end

  def update
    order = Order.find(params[:id])
    order.status = params[:status]
    if order.save
      render json: order, status: 200
    else
      render json: { errors: order.errors }, status: 422
    end
  end


  private
    def validating
      valid = true
      if !@order.placements.exists?
        @order.errors["placement"] << "there is no product has been added"
        valid = false
      end

      if !@order.address
        @order.errors["address"] << "please provide your mailing address"
        valid = false
      end

      if !@order.phone
        @order.errors["phone"] << "please provide your phone number"
        valid = false
      end

      @order.placements.each do |placement|
        product = placement.product
        if placement.quantity > product.quantity
          @order.errors["#{product.name}"] << "there is no sufficient amount of product, only #{product.quantity} left"
          valid = false
        end
      end
      if @order.placement_coupon
        coupon = @order.placement_coupon.coupon
        if coupon.quantity < 1
          @order.errors["#{coupon.code} quantity"] << "coupon is not valid, no coupon left"
          valid = false
        end

        if !Time.zone.today.between?(coupon.valid_start, coupon.valid_end)
          @order.errors["#{coupon.code} valid date"] << "coupon is not longer valid"
          valid = false
        end
      end
      return valid
    end
end
