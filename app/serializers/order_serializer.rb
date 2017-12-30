class OrderSerializer < ActiveModel::Serializer
  attributes :id, :user, :products, :total
end
