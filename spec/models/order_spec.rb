require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { FactoryGirl.build  :order }
  subject { order }

  it { should validate_presence_of :user_id }
  it { should respond_to :coupon_id }
  it { should validate_presence_of :total }
  it { should validate_numericality_of(:total).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of :status }
  it { should respond_to :shipment_id }
  it { should belong_to :user }
  it { should have_many(:placements) }
  it { should have_many(:products).through(:placements) }
end
