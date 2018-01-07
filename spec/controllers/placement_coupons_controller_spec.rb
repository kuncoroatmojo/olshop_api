require 'rails_helper'

RSpec.describe PlacementCouponsController, type: :controller do
  describe "POST #create" do
    before(:each) do
      current_user = FactoryGirl.create :user
      request.headers['Authorization'] = current_user.token
      @coupon = FactoryGirl.create :coupon
      post :create, params: {coupon_id: @coupon.id}
    end

    it "returns the newly created placement_coupon" do
      json = JSON.parse(response.body)
      expect(json['id']).to be_present
    end

    it "embed the coupon object related to the placement_coupon" do
      json = JSON.parse(response.body)
      expect(json['coupon']['id']).to eql @coupon.id
    end

    context 'when the order already have a coupon applied' do
      before(:each) do
        current_user = FactoryGirl.create :user
        request.headers['Authorization'] = current_user.token
        @coupon = FactoryGirl.create :coupon
        @order = FactoryGirl.create :order, user: current_user
        @placement_coupon = FactoryGirl.create :placement_coupon, order_id: @order.id, coupon_id: @coupon.id
        post :create, params: {user_id: current_user.id, order_id: @order.id, coupon_id: @coupon.id}
      end

      it "returns error order already had a coupon applied" do
        json = JSON.parse(response.body)
        expect(json['errors']['message']).to eql 'Only one coupon can be applied'
      end

      it { should respond_with 422 }
    end
  end

  describe "GET #index" do
    before(:each) do
      current_user = FactoryGirl.create :user
      request.headers['Authorization'] = current_user.token
      @coupon = FactoryGirl.create :coupon
      @order = current_user.orders.create!
      @placement_coupon = FactoryGirl.create :placement_coupon, order_id: @order.id, coupon_id: @coupon.id
      get :index, params: {user_id: current_user.id, order_id: @order.id}
    end

    it "returns placement_coupon record matching the placement_coupon id" do
      json = JSON.parse(response.body)
      expect(json['id']).to eql @placement_coupon.id
    end

    it "includes the coupon_id of the placement" do
      json = JSON.parse(response.body)
      expect(json['coupon']['id']).to eql @coupon.id
    end

    it { should respond_with 200 }
  end

  describe "DELETE #destroy" do
    before(:each) do
      current_user = FactoryGirl.create :user
      request.headers['Authorization'] = current_user.token
      @order = current_user.orders.create!
      @placement_coupon = FactoryGirl.create :placement_coupon, order_id: @order.id
      delete :destroy, params: { order_id: @order.id, id: @placement_coupon.id }
    end

    it { should respond_with 204 }
  end
end
