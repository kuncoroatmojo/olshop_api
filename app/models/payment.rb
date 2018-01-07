class Payment < ApplicationRecord
  belongs_to :order
  after_initialize :default_values
  validates :payment_method, presence: true
  validates :proof, presence: true
  validates :order_id, presence: true

  def default_values
    self.payment_method ||= "bank transfer"
  end
end
