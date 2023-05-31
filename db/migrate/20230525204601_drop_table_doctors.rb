class DropTableDoctors < ActiveRecord::Migration[7.0]
  def change
    drop_table :doctors
  end
end
