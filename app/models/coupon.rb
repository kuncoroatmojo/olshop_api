class Coupon < ApplicationRecord
  validates :code,:valid_start,:valid_end,:amount_type, presence: true  #amount_type:["percentage", "nominal"]
  validates :amount,:quantity, numericality: { greater_than_or_equal_to: 0 },
                    presence: true
  validate :condition_testing
  has_many :placement_coupons
  has_many :orders, through: :placement_coupons

  def condition_testing
    if amount
      if amount_type == 'percentage' && amount > 100
        errors.add(:amount,'amount cannot more than 100 percent')
      end
    end
  end
end
