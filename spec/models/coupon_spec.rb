require 'rails_helper'

RSpec.describe Coupon, type: :model do
  let(:coupon) { FactoryGirl.build  :coupon }
  subject { coupon }

  it { should validate_presence_of :code }
  it { should validate_presence_of :valid_start }
  it { should validate_presence_of :valid_end }
  it { should validate_presence_of :quantity }
  it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of :amount }
  it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of :amount_type }
end
