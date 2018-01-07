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
      expect(json['placements'].size).to eq(1)
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    before(:each) do
      current_user = FactoryGirl.create :user
      request.headers['Authorization'] = current_user.token
      @product = FactoryGirl.create :product
      address = "Bandung"
      phone = "081347899871"
      @order = current_user.orders.create!
      @existing_placement = FactoryGirl.create :placement, order_id: @order.id, product_id: @product.id, quantity: 2
      @coupon = FactoryGirl.create :coupon
      @placement_coupon = FactoryGirl.create :placement_coupon, order_id: @order.id, coupon_id: @coupon.id
      post :create, params: {user_id: current_user.id, address: address, phone: phone}
    end

    it "returns the newly created order" do
      json = JSON.parse(response.body)
      expect(json['id']).to be_present
    end

    it "returns status finalized" do
      json = JSON.parse(response.body)
      expect(json['status']).to eql("finalized")
    end

    it { should respond_with 201 }

    context "when no address provided" do
      before(:each) do
        current_user = FactoryGirl.create :user
        request.headers['Authorization'] = current_user.token
        @product = FactoryGirl.create :product
        address = "Bandung"
        phone = "081347899871"
        @order = current_user.orders.create!
        @existing_placement = FactoryGirl.create :placement, order_id: @order.id, product_id: @product.id, quantity: 2
        post :create, params: {user_id: current_user.id, phone: phone}
      end

      it "returns error message" do
        json = JSON.parse(response.body)
        expect(json['errors']['address']).to be_present
      end

      it { should respond_with 422 }
    end

    context "when insufficient product" do
      before(:each) do
        current_user = FactoryGirl.create :user
        request.headers['Authorization'] = current_user.token
        @product = FactoryGirl.create :product
        address = "Bandung"
        phone = "081347899871"
        @order = current_user.orders.create!
        @existing_placement = FactoryGirl.create :placement, order_id: @order.id, product_id: @product.id, quantity: 99
        post :create, params: {user_id: current_user.id, phone: phone}
      end

      it "returns error message" do
        json = JSON.parse(response.body)
        expect(json['errors']["#{@product.name}"]).to be_present
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT #update" do
    before(:each) do
      current_user = FactoryGirl.create :user, user_type: 'admin'
      request.headers['Authorization'] = current_user.token
      thecustumer = FactoryGirl.create :user
      @order = FactoryGirl.create :order, user: thecustumer
      @product = FactoryGirl.create :product
      @placement = FactoryGirl.create :placement, order_id: @order.id, product_id: @product.id, quantity: 2
      @order.status = "finalized"
      @payment = FactoryGirl.create :payment, order_id: @order.id
      put :update, params: {id: @order.id, status: 'approved'} #approved, canceled, readyforshipment, shipped
    end

    it "returns the updated status" do
      json = JSON.parse(response.body)
      expect(json['status']).to eql 'approved'
    end

    it { should respond_with 200 }

    context "user is not admin" do
      before(:each) do
        current_user = FactoryGirl.create :user
        request.headers['Authorization'] = current_user.token
        @order = FactoryGirl.create :order, user: current_user
        @product = FactoryGirl.create :product
        @placement = FactoryGirl.create :placement, order_id: @order.id, product_id: @product.id, quantity: 2
        @order.status = "finalized"
        @payment = FactoryGirl.create :payment, order_id: @order.id
        @shipment = FactoryGirl.create :shipment, order_id: @order.id, status: 'delivering'
        put :update, params: {id: @order.id, status: 'approved'} #approved, canceled, readyforshipment, shipped
      end

      it "returns errors" do
        json = JSON.parse(response.body)
        expect(json['errors'].size).to be_present
      end

      it { should respond_with 401 }
    end
  end
end
