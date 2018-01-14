class AddContributions < ActiveRecord::Migration[5.1]
  def change
    create_table :contributions, id: :uuid do |t|
      t.references :contributor, type: :uuid, index: true
      t.references :project, type: :uuid, index: true
      t.integer :amount_cents

      t.timestamps
    end
  end
end
