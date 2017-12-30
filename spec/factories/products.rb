FactoryGirl.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { rand() * 1000 }
    quantity { rand() * 100 }
  end
end
