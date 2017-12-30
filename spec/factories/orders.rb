FactoryGirl.define do
  factory :order do
    user
    status "notfinalized"
    total 0
  end
end
