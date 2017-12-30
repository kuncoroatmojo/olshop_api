require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe "GET #index" do
    before(:each) do
      current_user = FactoryGirl.create :user
      request.headers['Authorization'] = current_user.token
      4.times { FactoryGirl.create :order, user: current_user }
      get :index, params: {user_id: current_user.id}
    end

    it "returns 4 order records from the user" do
      json = JSON.parse(response.body)
      #orders_response = json_response[:orders]
      expect(json['orders']).to have(4).items
    end

    it { should respond_with 200 }
  end
end
