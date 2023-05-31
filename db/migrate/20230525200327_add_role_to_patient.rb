class AddRoleToPatient < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :role, :integer
  end
end
