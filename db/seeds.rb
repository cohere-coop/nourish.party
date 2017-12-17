# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with
# db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

raise "Probably shouldn't run this on production..." if Rails.env.production?

User.create_with(password: "password", instance_admin: true)
    .find_or_create_by(email: "admin@example.com")
