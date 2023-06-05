# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  phone                  :string
#  first_name             :string
#  last_name              :string
#  second_name            :string
#  role                   :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  birthday               :date             not null
#  photo                  :string
#  category_id            :bigint
#
require 'rails_helper'
require 'faker'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'validates presence of phone' do
      user = User.new
      expect(user).not_to be_valid
      expect(user.errors[:phone]).to include("can't be blank")
    end

    it 'validates uniqueness of phone' do
      phone = "+380#{Faker::Number.number(digits: 9)}"
      full_name = Faker::FunnyName.name.split(' ')
      birthday = Faker::Date.birthday(min_age: 18, max_age: 65)
      test_user = User.create(phone:, first_name: full_name.first, last_name: full_name.last, birthday:,
                              photo: 'https://codica-test-task-bucket.s3.eu-central-1.amazonaws.com/no_image.png')
      user = User.new(phone: test_user.phone)
      expect(user).not_to be_valid
      expect(user.errors[:phone]).to include("has already been taken")
      test_user.destroy
    end

    it 'validates phone regex' do
      user = User.new(phone: Faker::Number.number(digits: 12))
      expect(user).not_to be_valid
      expect(user.errors[:phone]).to include("is invalid")
    end
  end
end
