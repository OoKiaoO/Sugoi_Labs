# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'database_cleaner/active_record'
require 'faker'

puts "Doing some cleaning🧹. . ."
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean
puts "Ready for new seeds🌱"

puts "Creating Items. ."

items_array = []

20.times do
  items_array << Item.create!({
    name: Faker::Commerce.product_name,
    brand: Faker::Commerce.brand,
    barcode: Faker::Barcode.ean(13),
    retail: Faker::Commerce.price,
    category: Item::CATEGORIES.sample,
    location: "0#{rand(65..70).chr}-0#{rand(1...9)}-0#{rand(65..70).chr}"
  })
end

puts "All items generated!"


puts "Generating items amounts.."

10.times do
  ItemAmount.create!({
    amount: rand(50),
    exp_date: Faker::Date.between(from: 30.days.from_now, to: 1.year.from_now),
    item: items_array[rand(20)]
  })
end

puts "All items amounts generated!"
puts "Seed completed - DB ready to use"


