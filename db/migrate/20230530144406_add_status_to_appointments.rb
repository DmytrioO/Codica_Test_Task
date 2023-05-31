class AddStatusToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :status, :integer, null: false, default: 0
  end
end
