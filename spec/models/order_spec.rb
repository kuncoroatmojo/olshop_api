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

      @order = FactoryGirl.build :order, product_ids: [product1.id, product2.id]
    end

    it "returns total amount of products price" do
      expect{@order.set_total!}.to change{@order.total}.from(0).to(55.7)
    end
  end

  describe "#build_placements" do
    before(:each) do
      product1 = FactoryGirl.create :product, price: 25.5
      product2 = FactoryGirl.create :product, price: 30.2

      @product_ids_and_quantities = [[product1.id, 2], [product2.id, 3]]
    end

    it "builds two placements" do
      expect{order.build_placements(@product_ids_and_quantities)}.to change{order.placements.size}.from(0).to(2)
    end
  end
end
