require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { FactoryGirl.build  :order }
  subject { order }

  it { should validate_presence_of :user_id }
  it { should respond_to :coupon_id }
  #it { should validate_presence_of :total }
  #it { should validate_numericality_of(:total).is_greater_than_or_equal_to(0) }
  #it { should validate_presence_of :status }
  it { should respond_to :shipment_id }
  it { should belong_to :user }
  it { should have_many(:placements) }
  it { should have_many(:products).through(:placements) }

  describe '#set_total!' do
    before(:each) do
      product1 = FactoryGirl.create :product, price: 25.5
      product2 = FactoryGirl.create :product, price: 30.2

      placement1 = FactoryGirl.build :placement, product: product1, quantity: 7
      placement2 = FactoryGirl.build :placement, product: product2, quantity: 6

      @order = FactoryGirl.build :order

      @order.placements << placement1
      @order.placements << placement2
  end

    it "returns total amount of products price" do
      expect{@order.set_total!}.to change{@order.total}.from(0).to(359.7)
    end
  end

  describe "#valid?" do
    before(:each) do
      product1 = FactoryGirl.create :product, price: 25.5, quantity: 3
      product2 = FactoryGirl.create :product, price: 30.2, quantity: 10

      placement1 = FactoryGirl.build :placement, product: product1, quantity: 7
      placement2 = FactoryGirl.build :placement, product: product2, quantity: 6

      @order = FactoryGirl.build :order

      @order.placements << placement1
      @order.placements << placement2
    end

    it "invalid due to product out of stock" do
      expect(@order).to_not be_valid
    end
  end
end
