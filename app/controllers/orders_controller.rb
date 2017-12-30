class OrdersController < ApplicationController
  before_action :authenticate_user
  respond_to :json

  def index
    json_response(current_user.orders)
  end
end
