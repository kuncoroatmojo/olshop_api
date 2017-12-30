class User < ApplicationRecord
  validates :email, :password, :user_type, :name, presence: true
end
