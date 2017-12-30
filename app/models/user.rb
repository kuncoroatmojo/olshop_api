class User < ApplicationRecord
  validates :email, :password, :user_type, :name, presence: true
  has_many :orders, dependent: :destroy
  has_secure_token
end
