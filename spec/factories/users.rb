FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "12345678"
    user_type "customer"
    name { Faker::Name.name}
  end
end
