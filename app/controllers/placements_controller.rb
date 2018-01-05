class PlacementsController < ApplicationController
  before_action :authenticate_user
  respond_to :json

  def create
    chosen_product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    @placement = current_order.placements.find_by(:product_id => chosen_product.id)
    if @placement.present?
      @placement.quantity += quantity
    else
      #@placement = current_order.placements.create!(product_id: chosen_product.id, quantity: quantity)
      @placement = Placement.new
      @placement.order = current_order
      @placement.product = chosen_product
      @placement.quantity = quantity
    end
    if @placement.save
      render json: @placement, status: 201
    else
      render json: { errors: @placement.errors }, status: 422
    end
  end
end
