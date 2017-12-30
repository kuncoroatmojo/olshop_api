class UsersController < ApplicationController
  respond_to :json

  def show
    json_response(User.find(params[:id]))
  end
end
