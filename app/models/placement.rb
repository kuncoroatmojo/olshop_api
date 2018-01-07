class Placement < ApplicationRecord
  belongs_to :order, inverse_of: :placements
  belongs_to :product, inverse_of: :placements
  validates :quantity, numericality: { greater_than_or_equal_to: 0 },
                    presence: true
  #after_create :decrement_product_quantity!
  def decrement_product_quantity!
    self.product.decrement!(:quantity, self.quantity)
  end
end
