class UpdateUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :birthday, false
  end
end
