class CreateStripeConnections < ActiveRecord::Migration[5.1]
  def change
    create_table :stripe_connections, id: :uuid do |t|
      t.references :owner, type: :uuid, index: true
      t.string :stripe_account_id
      t.string :business_name
      t.string :display_name
      t.string :statement_descriptor

      t.timestamps
    end
  end
end
