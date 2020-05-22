# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'
require 'faker'

Hen.destroy_all
User.destroy_all

full_name ="poulette"
email = "poulette@poulette.com"
address = "poulette"
password = "poulette"
description = "poulette"
user = User.new(
  name: full_name,
  email: email,
  address: address,
  description: description,
  password: password
)
user.save!
"poulette created."

User.destroy_all

url = 'https://randomuser.me/api/?nat=fr'

20.times do
  p "Creating user."
  user_json = open(url).read
  user = JSON.parse(user_json)
  # Creating full name from the JSON.
  full_name = "#{user["results"][0]["name"]["first"]} #{user["results"][0]["name"]["last"]}"
  email = user["results"][0]["email"]
  address = user["results"][0]["location"]["city"]
  description = "#{full_name} is a #{Faker::Job.title} at #{Faker::Company.name}, a company operating in the #{Faker::Company.industry} industry. #{user["results"][0]["name"]["first"]} lives in the state of #{user["results"][0]["location"]["state"]} and is passionate about hens."
  password = 'poulette'
  image_url = user["results"][0]["picture"]["large"]
  image = URI.open(image_url)
  p image
  latitude = user["results"][0]["location"]["coordinates"]["latitude"].to_f
  longitude = user["results"][0]["location"]["coordinates"]["longitude"].to_f
  p latitude
  p longitude
  p full_name
  user = User.new(
    name: full_name,
    email: email,
    address: address,
    description: description,
    password: password
  )
  p "------------------------------"

  user.photo.attach(io: image, filename: 'nes.jpg', content_type: 'image/jpg')
  p user.photo.attached?
  p user.valid?
  # p image_url
  # user.save!
  p image_url
  p image.class
  user.save!
  p "------------------------------"
  puts 'User added.'
  puts 'Creating 5 fake hens per user...'



  # HENS BEING ADDED
  5.times do
    surname = Faker::Creature::Cat.name
    p surname
    age_hen = (1..8).to_a.sample
    p age_hen
    price_hen = (8..15).to_a.sample
    p price_hen
    description = Faker::Lorem.paragraph(sentence_count: 2)
    p description
    breed_hen = ['ISA Brown', 'Plymouth Rock', 'Barnevelder', 'Australorp', 'Naked Neck', 'Orpington', 'Silkie', 'New Hampshire Red'].sample
    p breed_hen
    availability_array = [true, false]
    hen = Hen.new(
      breed: breed_hen,
      description: description,
      price: price_hen,
      name: surname,
      age: age_hen,
      disponibility: availability_array.sample
      )
    hen.user_id = user.id
    hen.save!
    puts 'Hen added.'
  end

  # HENS

puts 'All 5 hens added.'

end
p "20 users added."


# Hen.destroy_all
# User.destroy_all

# full_name ="poulette"
# email = "poulette@poulette.com"
# address = "poulette"
# password = "poulette"
# description = "poulette"
# user = User.new(
#   name: full_name,
#   email: email,
#   address: address,
#   description: description,
#   password: password
# )
# user.save!
# "poulette created."

# puts 'Creating 20 fake  users...'
# 20.times do
#   full_name = Faker::Name.name
#   p full_name
#   surname = full_name.split[0].downcase
#   last_name = full_name.split[1].downcase
#   email = "#{surname}.#{last_name}@loremipsum.com"
#   p email
#   address = ["Le Mans", "Rouen", "Brest", "Blois", "Caen", "Amiens", "Reims", "Soissons", "Chaumont"].sample
#   p address
#   description = ["I'm an happy owner of hens! Happy owner make happy hens!", "Account Manager during the day, and a real mother-hen the rest of the time", "Come visit us and admire our hens, you'll be delighted", "I'll be very happy to take care of your hen[s] for you!", "Nature lover, I'm raising hens since 3 years"].sample
#   p description
#   password = 'poulette'
#   user = User.new(
#     name: full_name,
#     email: email,
#     address: address,
#     description: description,
#     password: password
#   )
#   user.save!
#   puts 'User added.'
#   puts 'Creating 5 fake hens per user...'
#   5.times do
#     surname = Faker::Creature::Cat.name
#     p surname
#     age_hen = (1..8).to_a.sample
#     p age_hen
#     price_hen = (8..15).to_a.sample
#     p price_hen
#     description = Faker::Lorem.paragraph(sentence_count: 2)
#     p description
#     breed_hen = ['ISA Brown', 'Plymouth Rock', 'Barnevelder', 'Australorp', 'Naked Neck', 'Orpington', 'Silkie', 'New Hampshire Red'].sample
#     p breed_hen
#     availability_array = [true, false]
#     hen = Hen.new(
#       breed: breed_hen,
#       description: description,
#       price: price_hen,
#       name: surname,
#       age: age_hen,
#       disponibility: availability_array.sample
#       )
#     hen.user_id = user.id
#     hen.save!
#   puts 'Hen added.'
#   end
# puts 'All 5 hens added.'
# end
# puts 'All 20 users added.'
