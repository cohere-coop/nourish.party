class RenameUsersToRegisteredUsers < ActiveRecord::Migration[5.1]
  def change
    rename_table :users, :registered_users
  end
end
