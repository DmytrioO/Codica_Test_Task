require 'faker'

# Category.create(name: 'Cardiologist')
# Category.create(name: 'Allergist')
# Category.create(name: 'Orthodontist')
# Category.create(name: 'Ophthalmologist')
# Category.create(name: 'Otolaryngologies')
# Category.create(name: 'Surgeon')

# categories = Category.all
#
# 20.times do
#   Faker::Config.locale = 'uk'
#   phone = Faker::PhoneNumber.cell_phone_in_e164
#   full_name = Faker::FunnyName.name.split(' ')
#   birthday = Faker::Date.birthday(min_age: 18, max_age: 65)
#   number = rand(categories.length - 1)
#   User.create(phone:, first_name: full_name.first, last_name: full_name.last, role: 'doctor',
#               birthday:, category: categories[number], photo: 'https://codica-test-task-bucket.s3.eu-central-1.amazonaws.com/no_image.png')
# end

AdminUser.create!(phone: '+380975553869', password: 'password', password_confirmation: 'password') if Rails.env.development?