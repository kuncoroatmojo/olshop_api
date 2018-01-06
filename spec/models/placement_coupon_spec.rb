require 'rails_helper'

RSpec.describe PlacementCoupon, type: :model do
  let(:placement_coupon) { FactoryGirl.build :placement_coupon }
  subject { placement_coupon }

  it { should respond_to :order_id }
  it { should respond_to :coupon_id }

  it { should belong_to :order }
  it { should belong_to :coupon }
end
