class RemoveTimeFromAppointments < ActiveRecord::Migration[7.0]
  def change
    remove_column :appointments, :time, :time
  end
end
