# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'SETTING UP DEFAULT USER LOGIN'

User.destroy_all

user = User.create! :name => 'admin', 
                    :email => 'admin@gmail.com', 
                    :password => 'admin888', 
                    :password_confirmation => 'admin888', 
                    :approved => true
puts 'New user created: ' << user.name
user.add_role :admin

user = User.create! :name => 'user1', 
                    :email => 'user1@gmail.com', 
                    :password => '123456', 
                    :password_confirmation => '123456', 
                    :approved => true
                    
user.add_role :account
puts 'New user created: ' << user.name

user = User.create! :name => 'user2', 
                    :email => 'user2@gmail.com', 
                    :password => '123456', 
                    :password_confirmation => '123456', 
                    :approved => true

user.add_role :operator

puts 'New user created: ' << user.name
