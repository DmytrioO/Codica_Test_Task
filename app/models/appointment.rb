# == Schema Information
#
# Table name: appointments
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  doctor_id  :integer
#  patient_id :integer
#  date_time  :datetime
#  status     :integer          default("opened"), not null
#
class Appointment < ApplicationRecord
  belongs_to :patient, class_name: 'User', foreign_key: :patient_id
  belongs_to :doctor, class_name: 'User', foreign_key: :doctor_id

  has_one :conclusion

  enum :status, %i[opened in_progress closed canceled], default: 0

  validates :date_time, presence: true

  def return_user(user, role)
    role == 'doctor' && user.doctor? ? patient : doctor
  end
end
