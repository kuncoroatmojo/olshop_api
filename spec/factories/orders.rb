FactoryGirl.define do
  factory :order do
    user
    status "notfinalized"
    address "#{Faker::Address.street_address}, #{Faker::Address.city}"
    phone {Faker::PhoneNumber.cell_phone}
    total 0
  end
end
