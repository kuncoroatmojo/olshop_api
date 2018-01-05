class StocksValidator < ActiveModel::Validator
  def validate(order)
    order.placements.each do |placement|
      product = placement.product
      if placement.quantity > product.quantity
        order.errors["#{product.name}"] << "there is no sufficient amount of product, only #{product.quantity} left"
      end
    end
  end
end
