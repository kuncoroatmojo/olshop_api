require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe "POST #create" do
    before(:each) do
      current_user = FactoryGirl.create :user
      request.headers['Authorization'] = current_user.token
      @order = FactoryGirl.create :order, user: current_user
      @product = FactoryGirl.create :product
      @placement = FactoryGirl.create :placement, order_id: @order.id, product_id: @product.id, quantity: 2
      @order.status = "finalized"
      proof = "https://cdn/18na82jao221fc53b4bc84d0swq98f73.jpg"
      post :create, params: {order_id: @order.id, proof: proof}
    end

    it "returns the newly created payment" do
      json = JSON.parse(response.body)
      expect(json['id']).to be_present
    end

    it { should respond_with 201 }
  end
end
