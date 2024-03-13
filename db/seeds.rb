require 'factory_bot_rails'

puts "Creating admin..."
user = User.find_or_initialize_by(email: "mohamed.bengrich@outlook.fr")

user.password = "123456"
user.password_confirmation = "123456"
user.role = "admin"
user.firstname = "Mohamed"
user.lastname = "Bengrich"

user.save!

puts "Admin created! email: mohamed.bengrich@outlook.fr, password: 123456"
