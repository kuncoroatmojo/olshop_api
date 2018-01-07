FactoryGirl.define do
  require 'securerandom'
  random_string = SecureRandom.hex
  factory :payment do
    payment_method "bank transfer"
    proof "https://cdn/#{random_string}.jpg"
    order
  end
end
