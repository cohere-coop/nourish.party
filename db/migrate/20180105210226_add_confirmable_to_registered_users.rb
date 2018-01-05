class AddConfirmableToRegisteredUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :registered_users do |t|
      # Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      # Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at
    end

    add_index :registered_users, :confirmation_token,   unique: true
    add_index :registered_users, :unlock_token,         unique: true
  end
end
