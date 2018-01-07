require 'rails_helper'

RSpec.describe ShipmentsController, type: :controller do

  describe "POST #create" do
    before(:each) do
      current_user = FactoryGirl.create :user, user_type: 'admin'
      thecustumer = FactoryGirl.create :user
      request.headers['Authorization'] = current_user.token
      @order = FactoryGirl.create :order, user: thecustumer
      @product = FactoryGirl.create :product
      @placement = FactoryGirl.create :placement, order_id: @order.id, product_id: @product.id, quantity: 2
      @order.status = "finalized"
      @payment = FactoryGirl.create :payment, order_id: @order.id
      post :create, params: {order_id: @order.id, status: 'delivering'}
    end

    it "returns the newly created shipment" do
      json = JSON.parse(response.body)
      expect(json['id']).to be_present
    end

    it { should respond_with 201 }

    context "user is not admin" do
      before(:each) do
        current_user = FactoryGirl.create :user
        request.headers['Authorization'] = current_user.token
        @order = FactoryGirl.create :order, user: current_user
        @product = FactoryGirl.create :product
        @placement = FactoryGirl.create :placement, order_id: @order.id, product_id: @product.id, quantity: 2
        @order.status = "finalized"
        @payment = FactoryGirl.create :payment, order_id: @order.id
        post :create, params: {order_id: @order.id, status: 'delivering'}
      end

      it "returns errors" do
        json = JSON.parse(response.body)
        expect(json['errors'].size).to be_present
        puts json
      end

      it { should respond_with 401 }
    end
  end

  describe "GET #show" do
    before(:each) do
      current_user = FactoryGirl.create :user
      request.headers['Authorization'] = current_user.token
      @order = FactoryGirl.create :order, user: current_user
      @product = FactoryGirl.create :product
      @placement = FactoryGirl.create :placement, order_id: @order.id, product_id: @product.id, quantity: 2
      @order.status = "finalized"
      @payment = FactoryGirl.create :payment, order_id: @order.id
      @shipment = FactoryGirl.create :shipment, order_id: @order.id
      get :show, params: {id: @shipment.id}
    end

    it "returns shipment record matching the shipment id" do
      json = JSON.parse(response.body)
      expect(json['id']).to eql @shipment.id
    end
  end

  describe "PUT #update" do
    before(:each) do
      current_user = FactoryGirl.create :user, user_type: 'admin'
      thecustumer = FactoryGirl.create :user
      request.headers['Authorization'] = current_user.token
      @order = FactoryGirl.create :order, user: thecustumer
      @product = FactoryGirl.create :product
      @placement = FactoryGirl.create :placement, order_id: @order.id, product_id: @product.id, quantity: 2
      @order.status = "finalized"
      @payment = FactoryGirl.create :payment, order_id: @order.id
      @shipment = FactoryGirl.create :shipment, order_id: @order.id, status: 'delivering'
      put :update, params: {id: @shipment.id, status: 'delivered'}
    end

    it "returns the updated status" do
      json = JSON.parse(response.body)
      expect(json['status']).to eql 'delivered'
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
        put :update, params: {id: @shipment.id, status: 'delivered'}
      end

      it "returns errors" do
        json = JSON.parse(response.body)
        expect(json['errors'].size).to be_present
      end

      it { should respond_with 401 }
    end
  end

end
