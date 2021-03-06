class Order < ApplicationRecord
  belongs_to :user
  after_initialize :default_values
  before_validation :set_total!

  validates :total, presence: true,
                      numericality: { greater_than_or_equal_to: 0 }

  validates :user_id, presence: true
  validates :status, presence: true #notfinalized, finalized, approved, canceled, readyforshipment, shipped
  validates_with StocksValidator
  has_many :placements
  has_many :products, through: :placements
  has_one :placement_coupon
  has_one :coupon, through: :placement_coupon

  def set_total!
    self.total = 0
    placements.each do |placement|
      self.total += placement.product.price * placement.quantity
    end

    if placement_coupon
      coupon = placement_coupon.coupon
      if coupon.amount_type == 'percentage'
        self.total = self.total*(100-coupon.amount)/100
      else
        if self.total > coupon.amount
          self.total -= coupon.amount
        else
          self.total = 0
        end
      end
    end
  end

  def default_values
    self.status ||= "notfinalized"
  end
end
