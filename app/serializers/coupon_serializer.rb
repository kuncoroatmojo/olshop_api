class CouponSerializer < ActiveModel::Serializer
  attributes :id, :code, :quantity, :amount, :amount_type, :valid_start, :valid_end
end
