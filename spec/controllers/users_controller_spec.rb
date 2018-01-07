require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
      before(:each) do
        @user = FactoryGirl.create :user
        get :show, params: {id: @user.id}
      end

      it "returns the information about a user" do
        json = JSON.parse(response.body)
        expect(json['email']).to eql @user.email
      end

      it { should respond_with 200 }
    end
end
