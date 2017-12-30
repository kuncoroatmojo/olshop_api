class Coupon < ApplicationRecord
  validates :code,:valid_start,:valid_end,:amount_type, presence: true
  validates :amount,:quantity, numericality: { greater_than_or_equal_to: 0 },
                    presence: true
end
