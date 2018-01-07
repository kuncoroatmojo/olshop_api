class PlacementCouponCouponSerializer < CouponSerializer
  def include_quantity?
    false
  end
end
