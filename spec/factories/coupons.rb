FactoryGirl.define do
  factory :coupon do
    code { Faker::Commerce.promotion_code }
    valid_start { rand(3.months).seconds.ago }
    valid_end { rand(3.months).seconds.from_now }
    quantity { rand() * 100 }
    amount { rand(5..50) }
    amount_type "percentage"
  end
end
