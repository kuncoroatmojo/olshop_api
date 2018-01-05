require 'rails_helper'

RSpec.describe PlacementsController, type: :controller do
  describe "POST #create" do
    before(:each) do
      current_user = FactoryGirl.create :user
      request.headers['Authorization'] = current_user.token
      @product = FactoryGirl.create :product
      quantity = 5
      post :create, params: {user_id: current_user.id, product_id: @product.id, quantity: quantity}
    end

    it "returns the newly created placement" do
      json = JSON.parse(response.body)
      expect(json['id']).to be_present
    end

    it "embed the product object related to the placement" do
      json = JSON.parse(response.body)
      expect(json['product_id']).to eql @product.id
    end

    it "embed the quantity of the placement" do
      json = JSON.parse(response.body)
      expect(json['quantity']).to eql 5
    end

    context 'when the added product already exist' do
      before(:each) do
        current_user = FactoryGirl.create :user
        request.headers['Authorization'] = current_user.token
        @product = FactoryGirl.create :product
        quantity = 5
        @order = current_user.orders.create!
        @existing_placement = FactoryGirl.create :placement, order_id: @order.id, product_id: @product.id, quantity: 7
        post :create, params: {user_id: current_user.id, product_id: @product.id, quantity: quantity}
      end


      it "increment the quantity of the existing placement" do
        json = JSON.parse(response.body)
        expect(json['quantity']).to eql 12
      end
    end
  end
end
