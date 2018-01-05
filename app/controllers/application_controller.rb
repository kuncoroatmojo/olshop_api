class ApplicationController < ActionController::API
  include Authenticable
  include Response

  private
    def current_order
      order = Order.find_by(:user_id => current_user.id, :status => "notfinalized")
      if order.present?
        @current_order = order
      else
        @current_order = current_user.orders.create!
      end
    end
end
