require 'rails_helper'

RSpec.describe PlacementCoupon, type: :model do
  let(:placement_coupon) { FactoryGirl.build :placement_coupon }
  subject { placement_coupon }

  it { should respond_to :order_id }
  it { should respond_to :coupon_id }

  it { should belong_to :order }
  it { should belong_to :coupon }

  describe "#decrement_coupon_quantity!" do
    it "decreases the coupon quantity by 1" do
      coupon = placement_coupon.coupon
      expect{placement_coupon.decrement_coupon_quantity!}.to change{coupon.quantity}.by(-1)
    end
  end
end
