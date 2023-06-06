# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
puts "destroying previous data"
Order.destroy_all
puts "deleted order"
Product.destroy_all
puts "deleted products"
Cart.destroy_all
puts "deleted cart"

print "creating 20 products"
(1..20).each do |i|
    Product.create!(
    name: Faker::Creature::Cat.breed,
    description: Faker::Creature::Cat.registry,
    price: Faker::Number.between(from: 0.0, to: 30.0).round(2),
    image: "https://loremflickr.com/320/240?random=#{i}"
  )
end
puts " DONE"
roger = User.find_by(email:"roger@mail")
print "creating a cart"
Cart.create(user:roger)
puts " DONE"
print "creating 5 order"
5.times do
    Order.create(user:roger,product:Product.all.sample)
end
puts " DONE"