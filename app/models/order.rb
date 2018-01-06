class Order < ApplicationRecord
  belongs_to :user
  after_initialize :default_values
  #before_validation :set_total!

  #validates :total, presence: true,
  #                    numericality: { greater_than_or_equal_to: 0 }

  validates :user_id, presence: true
  validates :status, presence: true
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
  end

  def default_values
    self.status ||= "notfinalized"
  end
  def build_placements(product_ids_and_quantities)
    puts product_ids_and_quantities
    product_ids_and_quantities.each do |product_id_and_quantity|
      id, quantity = product_id_and_quantity
      puts quantity
      self.placements.create!(product_id: id, quantity: quantity)
    end
  end
end
