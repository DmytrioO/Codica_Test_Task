class RemoveDoctorFromAppointment < ActiveRecord::Migration[7.0]
  def change
    remove_reference :appointments, :doctor, null: false, foreign_key: true
  end
end
