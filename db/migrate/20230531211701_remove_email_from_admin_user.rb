class RemoveEmailFromAdminUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :admin_users, :email, :string
  end
end
