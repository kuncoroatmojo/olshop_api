class Product < ApplicationRecord
  validates :name, presence: true
  validates :price,:quantity, numericality: { greater_than_or_equal_to: 0 },
                    presence: true
end
