class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total, :status
  has_many :placements
  has_one :placement_coupon
end
