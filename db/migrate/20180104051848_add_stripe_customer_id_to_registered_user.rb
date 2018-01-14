class AddStripeCustomerIdToRegisteredUser < ActiveRecord::Migration[5.1]
  def change
    add_column :registered_users, :stripe_customer_id, :string
  end
end
