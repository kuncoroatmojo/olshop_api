class UsersController < ApplicationController
  respond_to :json

  def index
    json_response(User.all)
  end

  def show
    json_response(User.find(params[:id]))
  end

  def create
    @user = User.create(product_params)
    json_response(@user)
  end
end
