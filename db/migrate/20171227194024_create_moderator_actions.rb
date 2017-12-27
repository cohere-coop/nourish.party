class CreateModeratorActions < ActiveRecord::Migration[5.1]
  def change
    create_table :moderator_actions, id: :uuid do |t|
      t.string :action
      t.string :reason
      t.references :moderator, type: :uuid, index: true
      t.references :moderatable, type: :uuid, index: true
      t.string :moderatable_type
      t.timestamps
    end
  end
end
