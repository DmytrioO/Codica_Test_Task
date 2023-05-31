class AddDoctorAndPatientToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :doctor_id, :integer
    add_column :appointments, :patient_id, :integer
    add_index :appointments, :doctor_id
    add_index :appointments, :patient_id
  end
end
