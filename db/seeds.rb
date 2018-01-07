# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

4.times do
  User.create \
    email: Faker::Internet.email,
    password: "12345678",
    user_type: "customer",
    name: Faker::Name.name
end

3.times do
  User.create \
    email: Faker::Internet.email,
    password: "12345678",
    user_type: "customer",
    name: Faker::Name.name,
    address: "#{Faker::Address.street_address}, #{Faker::Address.city}",
    phone: Faker::PhoneNumber.cell_phone
end

3.times do
  User.create \
    email: Faker::Internet.email,
    password: "12345678",
    user_type: "admin",
    name: Faker::Name.name
end

30.times do
  Product.create \
    name: Faker::Commerce.product_name,
    price: Faker::Commerce.price,
    quantity: rand() * 100
end

5.times do
  Coupon.create \
    code: Faker::Commerce.promotion_code,
    valid_start: rand(3.months).seconds.ago,
    valid_end: rand(3.months).seconds.from_now,
    quantity: 90,
    amount: rand(5..50),
    amount_type: "percentage"
end

5.times do
  Coupon.create \
    code: Faker::Commerce.promotion_code,
    valid_start: rand(3.months).seconds.ago,
    valid_end: rand(3.months).seconds.from_now,
    quantity: 90,
    amount: rand(5..50),
    amount_type: "nominal"
end
