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

item_1 = Item.create({ name: "KitKat - Peach Parfait Flavour", brand: "Nestle", barcode: Faker::Barcode.ean(13)})
puts "Generated item 1: #{item_1.name} with barcode #{item_1.barcode}!"

item_2 = Item.create({ name: "KitKat - Mango Flavour", brand: "Nestle", barcode: Faker::Barcode.ean(13)})
puts "Generated item 2: #{item_2.name} with barcode #{item_2.barcode}"

item_3 = Item.create({ name: "Pocky Coconut", brand: "Glico", barcode: Faker::Barcode.ean(13)})
puts "Generated item 3: #{item_3.name} with barcode #{item_3.barcode}"

puts "All items generated!"


puts "Generating items amounts.."

items_array = [item_1, item_2, item_3]
10.times do
  ItemAmount.create!({
    amount: rand(50),
    exp_date: Faker::Date.between(from: 30.days.from_now, to: 1.year.from_now),
    item: items_array[rand(3)]
  })
end

puts "All items amounts generated!"
puts "Seed completed - DB ready to use"


