require 'rails_helper'
require 'capybara/rails'

RSpec.feature 'Making a conclusion', type: :feature do
  phone = "+380#{Faker::Number.number(digits: 9)}"
  full_name = Faker::FunnyName.name.split(' ')
  birthday = Faker::Date.birthday(min_age: 18, max_age: 65)
  password = '123#QWEqwe'
  doctor = User.create(phone:, first_name: full_name.first, last_name: full_name.last,
                       birthday:, role: 'doctor', password:)

  phone = "+380#{Faker::Number.number(digits: 9)}"
  full_name = Faker::FunnyName.name.split(' ')
  birthday = Faker::Date.birthday(min_age: 18, max_age: 65)
  patient = User.create(phone:, first_name: full_name.first, last_name: full_name.last,
                        birthday:, photo: 'https://codica-test-task-bucket.s3.eu-central-1.amazonaws.com/no_image.png')

  appointment = Appointment.create(doctor:, patient:, date_time: DateTime.now, status: 'in_progress')

  scenario 'Doctor successfully let a conclusion for patient' do
    visit new_user_session_path

    fill_in 'Phone', with: doctor.phone
    fill_in 'Password', with: password

    click_button 'Log in'

    expect(current_path).to eq root_path

    visit appointment_path(appointment)

    click_button 'Finish appointment'

    fill_in 'Recommendations', with: 'Drink water'

    click_button 'Close appointment'

    expect(current_path).to eq appointment_path(appointment)
    expect(Appointment.last.status).to eq('closed')
    expect(Appointment.last.conclusion.recommendations).to eq('Drink water')

    Appointment.last.conclusion.destroy
    Appointment.last.destroy
  end
end