class Shipment < ApplicationRecord
  belongs_to :order
  after_initialize :default_values
  validates :status, presence: true #delivering, delivered
  validates :order_id, presence: true

  def default_values
    self.status ||= "delivering"
  end
end
