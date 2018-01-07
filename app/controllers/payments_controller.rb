class PaymentsController < ApplicationController
  before_action :authenticate_user
  respond_to :json

  def create
    order = Order.find(params[:order_id])
    payment = Payment.new
    payment.order = order
    payment.proof = params[:proof]

    if payment.save
      render json: payment, status: 201
    else
      render json: { errors: payment.errors }, status: 422
    end
  end
end
