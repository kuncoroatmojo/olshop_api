class Order < ApplicationRecord
  belongs_to :user
  after_initialize :default_values
  #before_validation :set_total!

  #validates :total, presence: true,
  #                    numericality: { greater_than_or_equal_to: 0 }

  validates :user_id, presence: true
  validates :status, presence: true
  has_many :placements
  has_many :products, through: :placements

  def set_total!
    self.total = products.map(&:price).sum
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
