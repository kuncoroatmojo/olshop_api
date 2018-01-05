class OrdersController < ApplicationController
  before_action :authenticate_user
  respond_to :json

  def index
    json_response(current_user.orders)
  end

  def show
    json_response(current_user.orders.find(params[:id]))
  end

  def create
    order = current_user.orders.create!

    #order.build_placements(order_params)
    json_response(order, :created)
    '''
    order = current_user.orders.build(order_params)
    if order.save
      render json: order, status: 201, location: [:api, current_user, order]
    else
      render json: { errors: order.errors }, status: 422
    end
    '''
  end

  private

    def order_params
    #  params.permit(:product_ids_and_quantities => [])
     hash = params.permit(:product_ids_and_quantities => [])
     hash[:product_ids_and_quantities] = params.require(:product_ids_and_quantities) if params.has_key?(:product_ids_and_quantities)
     hash
    end
end
