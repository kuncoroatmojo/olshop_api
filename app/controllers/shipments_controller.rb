class ShipmentsController < ApplicationController
  before_action :authenticate_user
  before_action :authorize_admin, only: [:create, :update]
  respond_to :json

  def create
    order = Order.find(params[:order_id])
    shipment = Shipment.new
    shipment.order = order
    shipment.status = params[:status]

    if shipment.save
      render json: shipment, status: 201
    else
      render json: { errors: shipment.errors }, status: 422
    end
  end

  def show
    json_response(Shipment.find(params[:id]))
  end

  def update
    shipment = Shipment.find(params[:id])
    shipment.status = params[:status]
    if shipment.save
      render json: shipment, status: 200
    else
      render json: { errors: shipment.errors }, status: 422
    end
  end
end
