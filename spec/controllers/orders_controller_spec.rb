require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe "GET #index" do
    before(:each) do
      current_user = FactoryGirl.create :user
      request.headers['Authorization'] = current_user.token
      4.times { FactoryGirl.create :order, user: current_user }
      get :index, params: {user_id: current_user.id}
    end

    it "returns order records from a user" do
      json = JSON.parse(response.body)
      #orders_response = json_response[:orders]
      expect(json.size).to eq(4)
    end

    it { should respond_with 200 }
  end

  describe "GET #show" do
    before(:each) do
      current_user = FactoryGirl.create :user
      request.headers['Authorization'] = current_user.token

      @product = FactoryGirl.create :product
      @order = FactoryGirl.create :order, user: current_user, product_ids: [@product.id]
      get :show, params: {user_id: current_user.id, id: @order.id}
    end

    it "returns order record matching the order id" do
      json = JSON.parse(response.body)
      expect(json['id']).to eql @order.id
    end

    it "includes the total of the order" do
      json = JSON.parse(response.body)
      expect(json['total']).to eql @order.total.to_s
    end

    it "includes the product of the order" do
      json = JSON.parse(response.body)
      expect(json['products'].size).to eq(1)
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    before(:each) do
      current_user = FactoryGirl.create :user
      request.headers['Authorization'] = current_user.token
      product1 = FactoryGirl.create :product
      product2 = FactoryGirl.create :product
      @product_ids_and_quantities = [[product1.id, 2], [product2.id, 3]]
      post :create, params: {user_id: current_user.id, product_ids_and_quantities:@product_ids_and_quantities}
    end

    it "returns the newly created order" do
      json = JSON.parse(response.body)
      expect(json['id']).to be_present
    end

    it "embed the two product objects related to the order" do
      json = JSON.parse(response.body)
      #expect(json['products'].size).to eql(2)

      puts json
    end

    it { should respond_with 201 }
  end
end
