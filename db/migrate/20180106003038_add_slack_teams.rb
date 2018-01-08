class AddSlackTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :slack_teams, id: :uuid do |t|
      t.references :owner, type: :uuid, index: true
      t.string :slack_id
      t.string :access_token
      t.string :name
      t.string :domain
    end
  end
end
