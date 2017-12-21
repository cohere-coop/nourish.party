class AddInstanceAdminFlagToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :instance_admin, :boolean, default: false
  end
end
