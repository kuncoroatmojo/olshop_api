class PlacementCoupon < ApplicationRecord
  belongs_to :order, inverse_of: :placement_coupon
  belongs_to :coupon, inverse_of: :placement_coupons
  after_create :decrement_coupon_quantity!
  def decrement_coupon_quantity!
    self.coupon.decrement!(:quantity)
  end
end
