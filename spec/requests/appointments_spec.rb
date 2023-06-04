require 'rails_helper'

RSpec.describe 'Appointments', type: :request do
  describe 'POST appointment/create' do
    Appointment.all.destroy_all

    phone = "+380#{Faker::Number.number(digits: 9)}"
    full_name = Faker::FunnyName.name.split(' ')
    birthday = Faker::Date.birthday(min_age: 18, max_age: 65)
    patient = User.create(phone:, first_name: full_name.first, last_name: full_name.last,
                       birthday:)
    phone = "+380#{Faker::Number.number(digits: 9)}"
    full_name = Faker::FunnyName.name.split(' ')
    birthday = Faker::Date.birthday(min_age: 18, max_age: 65)
    doctor = User.create(phone:, first_name: full_name.first, last_name: full_name.last,
                         birthday:, role: 'doctor')

    it 'create new appointment' do
      sign_in patient

      post appointment_create_path, params: { doctor_id: doctor.id, date: Date.today, time: DateTime.now, patient: }

      expect(response).to have_http_status(200)

      expect(Appointment.last.doctor.first_name).to eq(doctor.first_name)
      expect(Appointment.last.patient.last_name).to eq(patient.last_name)

      Appointment.last.destroy
    end

    it 'prevents a doctor from creating an appointment with itself' do
      sign_in doctor

      post appointment_create_path, params: { doctor_id: doctor.id, date: Date.today, time: DateTime.now }

      expect(response).to have_http_status(422)

      expect(Appointment.last).to eq(nil)
    end

    it 'prevents a user from creating an appointment with a doctor with maximum number of appointments' do
      10.times do |number|
        Appointment.create(doctor:, patient:, date_time: DateTime.now + (number * 2).minutes )
      end

      sign_in patient

      post appointment_create_path, params: { doctor_id: doctor.id, date: Date.tomorrow, time: DateTime.now,
                                              patient: }

      expect(response).to have_http_status(422)

      doctor.appointments_as_doctor.destroy_all
    end

    it 'prevents a user from creating an appointment on the same time as other' do
      date_time = DateTime.now.strftime('%d.%m.%Y %H:%M').to_datetime

      appointment = Appointment.create(patient:, doctor:, date_time:)

      sign_in patient

      post appointment_create_path, params: { doctor_id: doctor.id, date: date_time.to_date, time: date_time,
                                              patient: }

      expect(response).to have_http_status(422)

      expect(Appointment.all.count).to eq(1)

      appointment.destroy
    end
  end
end