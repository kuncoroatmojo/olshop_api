FactoryGirl.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price }
    quantity { rand() * 100 }
  end
end
