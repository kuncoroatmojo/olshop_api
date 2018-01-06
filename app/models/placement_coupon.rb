class PlacementCoupon < ApplicationRecord
  belongs_to :order, inverse_of: :placement_coupon
  belongs_to :coupon, inverse_of: :placement_coupons
end
