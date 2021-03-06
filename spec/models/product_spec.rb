require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { FactoryGirl.build  :product }
  subject { product }

  it { should validate_presence_of :name }
  it { should validate_presence_of :price }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of :quantity }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  it { should have_many(:placements) }
  it { should have_many(:orders).through(:placements) }
end
